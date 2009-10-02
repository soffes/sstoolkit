//
//  TWConnection.m
//  TWToolkit
//
//  Created by Sam Soffes on 3/19/09.
//  Copyright 2009 Tasteful Works, Inc. All rights reserved.
//

#import "TWConnection.h"
#import "CJSONDeserializer.h"
#import "NSString+encoding.h"
#import <SystemConfiguration/SystemConfiguration.h>
#include <netinet/in.h>

@implementation TWConnection

@synthesize delegate, dataType = _dataType;

#pragma mark -
#pragma mark Class Methods
#pragma mark -

+ (BOOL)isConnectedToNetwork {
	
	// Create zero address
	struct sockaddr_in zeroAddress;
	bzero(&zeroAddress, sizeof(zeroAddress));
	zeroAddress.sin_len = sizeof(zeroAddress);
	zeroAddress.sin_family = AF_INET;
	
	// Recover reachability flags
	SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
	SCNetworkReachabilityFlags flags;
	
	BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
	CFRelease(defaultRouteReachability);
	
	if (!didRetrieveFlags) {
		return NO;
	}
	
	return (didRetrieveFlags && (flags & kSCNetworkFlagsReachable) && !(flags & kSCNetworkFlagsConnectionRequired));
}

#pragma mark -
#pragma mark NSObject
#pragma mark -

- (id)init {
	if (self = [super init]) {
		self.delegate = nil;
		self.dataType = TWConnectionDataTypeData;
	}
	return self;
}

- (id)initWithDelegate:(id)aDelegate {
	if (self = [super init]) {
		self.delegate = aDelegate;
		self.dataType = TWConnectionDataTypeData;
	}
	return self;
}

- (void)dealloc {
	[self cancel];
	[super dealloc];
}

#pragma mark -
#pragma mark Request Methods
#pragma mark -

- (void)requestURL:(NSURL *)url {
	[self requestURL:url HTTPMethod:TWConnectionHTTPMethodGET additionalHeaders:nil];
}

- (void)requestURL:(NSURL *)url HTTPMethod:(TWConnectionHTTPMethod)HTTPMethod additionalHeaders:(NSDictionary *)additionalHeaders {
	NSMutableURLRequest* aRequest = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:kTimeout];	
	
	// Setup basic auth headers if user and pass are provided
	NSString *username = [url user];
	NSString *password = [url password];
	if (username || password) {
		NSString* auth = [[NSString alloc] initWithFormat:@"%@:%@", username, password];
		NSString* basicauth = [[NSString alloc] initWithFormat:@"Basic %@", [NSString base64encode:auth]];
		[aRequest setValue:basicauth forHTTPHeaderField:@"Authorization"];
		[auth release];
		[basicauth release];
	}
	
	static NSString *methods[4] = {
		@"GET",
		@"POST",
		@"PUT",
		@"DELETE"
	};
	
	// Setup POST data
	if (HTTPMethod != TWConnectionHTTPMethodGET) {
		
		[aRequest setHTTPMethod:methods[HTTPMethod]];
		NSString *parametersString = [url query];
		NSInteger contentLength = [parametersString lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
		[aRequest setValue:[NSString stringWithFormat:@"%d", contentLength] forHTTPHeaderField:@"Content-Length"];
		NSData *body = [[NSData alloc] initWithBytes:[parametersString UTF8String] length:contentLength];
		[aRequest setHTTPBody:body];
		[body release];
	}
	
	// Additional headers
	for (NSString *field in additionalHeaders) {
		[aRequest setValue:[additionalHeaders objectForKey:field] forHTTPHeaderField:field];
	}
	
	[self startRequest:aRequest];
	[aRequest release];
}

- (void)startRequest:(NSURLRequest *)aRequest {
	
	// Cancel any current requests
	[self cancel];
	
	if (aRequest == nil) {
		return;
	}
	
	// Check network
	// TODO: Experienced issues with this, so commenting out for now
//	if ([TWConnection isConnectedToNetwork] == NO) {
//		if ([delegate respondsToSelector:@selector(connection:didFailWithError:)]) {
//			// TODO: Send useful error
//			[delegate connection:self failedWithError:nil];
//		}
//		return;
//	}
	
	// Retain the request
	_request = [aRequest retain];
	
	// Show activity indicator
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
	
	// Initialize the connection
	_urlConnection = [[NSURLConnection alloc] initWithRequest:_request delegate:self];
	
	// Initialize the data
	_receivedData = [[NSMutableData alloc] init];
	
	// Start the request
	[_urlConnection start];
	
	// Notify the delegate the request started
	if ([delegate respondsToSelector:@selector(connection:startedLoadingRequest:)]) {
		[delegate connection:self startedLoadingRequest:_request];
	}
}

- (void)cancel {
	[_urlConnection cancel];
	[_urlConnection release];
	_urlConnection = nil;
	
	[_request release];
	_request = nil;
	
	[_receivedData release];
	_receivedData = nil;
}

- (id)_parseData:(NSData *)data {
	id parsedData = nil;
	
	// TODO: Message delegate if there is an error
	
	switch (self.dataType) {
		default:
		case TWConnectionDataTypeData: {
			parsedData = [NSData dataWithData:data];
			break;
		}
		case TWConnectionDataTypeString: {
			parsedData = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
			break;
		}
		case TWConnectionDataTypeJSONDictionary: {
			parsedData = [[CJSONDeserializer deserializer] deserializeAsDictionary:data error:nil];
			break;
		}
		case TWConnectionDataTypeJSONArray: {
			// This method is deprecated. This one is being used to support illegal (but common) JSON strings.
			// @see http://stackoverflow.com/questions/288412#289193
			parsedData = [[CJSONDeserializer deserializer] deserialize:data error:nil];
			break;
		}
	}
	return parsedData;
}

#pragma mark -
#pragma mark NSURLConnection Delegate
#pragma mark -

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
	
	NSString *user = [[_request URL] user];
	NSString *password = [[_request URL] password];
	
	if (user|| password) {
		NSURLCredential *credential = [[NSURLCredential alloc] initWithUser:user password:password persistence:NSURLCredentialPersistenceForSession];
		[[challenge sender] useCredential:credential forAuthenticationChallenge:challenge];
		[credential release];
	} else {
		// Send error to delegate
		if ([delegate respondsToSelector:@selector(connection:didFailWithError:)]) {
			// TODO: Send useful error
			[delegate connection:self failedWithError:nil];
		}
		
		[self cancel];
	}
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {	
	_totalExpectedBytes = [response expectedContentLength];
	[_receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	[_receivedData appendData:data];
	
	NSInteger receivedBytes = [data length];
	_totalReceivedBytes += receivedBytes;
	
	// Send an update to the delegate
	if ([delegate respondsToSelector:@selector(connection:didReceiveBytes:totalReceivedBytes:totalExpectedBytes:)]) {
		[delegate connection:self didReceiveBytes:receivedBytes totalReceivedBytes:_totalReceivedBytes totalExpectedBytes:_totalExpectedBytes];
	}
	
	// Send chunk to delegate
	if ([delegate respondsToSelector:@selector(connection:didReceiveChunk:)]) {
		[delegate connection:self didReceiveChunk:[self _parseData:data]];
	}
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	
	// Hide the network activity
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
	
	// Send error to delegate
	if ([delegate respondsToSelector:@selector(connection:failedWithError:)]) {
		[delegate connection:self failedWithError:error];
	}
	
	[self cancel];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	
	// Hide the network activity
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
	
	// Send the result to the delegate
	if ([delegate respondsToSelector:@selector(connection:didFinishLoadingRequest:withResult:)]) {
		
		id result = [self _parseData:_receivedData];
		
		[delegate connection:self didFinishLoadingRequest:_request withResult:result];
	}
	
	// Stop request and free up resources
	[self cancel];
}

@end
