//
//  TWURLRequest.m
//  TWToolkit
//
//  Created by Sam Soffes on 10/9/09.
//  Copyright 2009 Tasteful Works, Inc. All rights reserved.
//

#import "TWURLRequest.h"
#import "NSString+encoding.h"
#import "NSString+SBJSON.h"

@interface TWURLRequest (PrivateMethods)
- (void)_updateHeaders;
- (void)_generateHash;
@end

@implementation TWURLRequest

@synthesize dataType;
@synthesize hash;
@synthesize cacheLifetime;

#pragma mark -
#pragma mark Class Methods
#pragma mark -

+ (id)parseData:(NSData *)data dataType:(TWURLRequestDataType)dataType error:(NSError **)outError {
	id parsedObject = nil;
	
	switch (dataType) {
		default:
		case TWURLRequestDataTypeData: {
			parsedObject = [NSData dataWithData:data];
			break;
		}
		case TWURLRequestDataTypeString: {
			parsedObject = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
			break;
		}
		case TWURLRequestDataTypeImage: {
			parsedObject = [UIImage imageWithData:data];
			break;
		}
		case TWURLRequestDataTypeJSON: {
			NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
			parsedObject = [jsonString JSONValue];
			[jsonString release];
			break;
		}
	}
	return parsedObject;
}


#pragma mark -
#pragma mark NSObject
#pragma mark -

- (id)initWithURL:(NSURL *)theURL {
	if (self = [super initWithURL:theURL cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:kTWURLRequestTimeout]) {
		[self _updateHeaders];
		
		dataType = TWURLRequestDataTypeData;
		hash = nil;
		cacheLifetime = -1.0;
	}
	return self;
}


#pragma mark -
#pragma mark NSMutableURLRequest
#pragma mark -

- (void)setURL:(NSURL *)theURL {
	[super setURL:theURL];
	[self _updateHeaders];
}


- (void)setHTTPMethod:(NSString *)method {
	[super setHTTPMethod:method];
	[self _updateHeaders];
}


#pragma mark -
#pragma mark TWURLRequest
#pragma mark -

- (void)_updateHeaders {
	
	static NSString *authorizationField = @"Authorization";
	static NSString *getMethod = @"GET";
	
	NSURL *url = [self URL];
	
	// Check for basic auth
	NSString *username = [url user];
	NSString *password = [url password];
	if ((username || password) && ![self valueForHTTPHeaderField:authorizationField]) {
		NSString* auth = [[NSString alloc] initWithFormat:@"%@:%@", username, password];
		NSString* basicauth = [[NSString alloc] initWithFormat:@"Basic %@", [NSString base64encode:auth]];
		[self setValue:basicauth forHTTPHeaderField:authorizationField];
		[auth release];
		[basicauth release];
	}
	
	// Check for post data
	if ([[self HTTPMethod] isEqualToString:getMethod] == NO && [[url query] length] > 0) {
		static NSString *contentLengthField = @"Content-Length";
		NSString *parametersString = [url query];
		
		// Set content length
		NSInteger contentLength = [parametersString lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
		[self setValue:[NSString stringWithFormat:@"%d", contentLength] forHTTPHeaderField:contentLengthField];
		
		// Set body
		NSData *body = [[NSData alloc] initWithBytes:[parametersString UTF8String] length:contentLength];
		[self setHTTPBody:body];
		[body release];
	}
}


- (void)_generateHash {
	// TODO: Make better hash
	hash = [[self URL] absoluteString];
}

#pragma mark -
#pragma mark Getters
#pragma mark -

- (NSString *)hash {
	if (!hash) {
		[self _generateHash];
	}
	return hash;
}

@end
