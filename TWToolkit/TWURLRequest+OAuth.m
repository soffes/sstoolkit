//
//  TWURLRequest+OAuth.m
//  TWToolkit
//
//  Created by Sam Soffes on 11/3/09.
//  Copyright 2009 Tasteful Works, Inc. All rights reserved.
//

#import "TWURLRequest+OAuth.h"
#import "OAToken.h"
#import "OAConsumer.h"
#import "TWURLRequest+Parameters.h"
#import "TWURLRequestParameter.h"
#import "OAHMAC_SHA1SignatureProvider.h"
#import "NSString+encoding.h"
#import "NSURL+OAuthString.h"

@implementation TWURLRequest (OAuth)

- (void)setOAuthConsumer:(OAConsumer *)consumer {
	[self setOAuthConsumer:consumer token:nil realm:nil signatureProvider:nil nonce:nil timestamp:nil];
}


- (void)setOAuthConsumer:(OAConsumer *)consumer token:(OAToken *)token {
	[self setOAuthConsumer:consumer token:token realm:nil signatureProvider:nil nonce:nil timestamp:nil];
}


- (void)setOAuthConsumer:(OAConsumer *)consumer token:(OAToken *)token realm:(NSString *)realm signatureProvider:(id<OASignatureProviding>)signatureProvider nonce:(NSString *)nonce timestamp:(NSString *)timestamp {
	// Defaults
	// Empty token for Unauthorized Request Token transaction
	if (token == nil) {
		token = [[[OAToken alloc] init] autorelease];
	}
	
	if (realm == nil) {
		realm = @"";
	}
	
	if (signatureProvider == nil) {
		signatureProvider = [[OAHMAC_SHA1SignatureProvider alloc] init];
	}
	
	if (nonce == nil) {
		CFUUIDRef theUUID = CFUUIDCreate(NULL);
		CFStringRef string = CFUUIDCreateString(NULL, theUUID);
		CFRelease(theUUID);
		nonce = [(NSString *)string autorelease];
	}
	
	if (timestamp == nil) {
		timestamp = [NSString stringWithFormat:@"%d", time(NULL)];
	}
	
	// OAuth Spec, Section 9.1.1 "Normalize Request Parameters"
    // build a sorted array of both request parameters and OAuth header parameters
    NSMutableArray *parameterPairs = [[NSMutableArray alloc] initWithObjects:
									  [[TWURLRequestParameter requestParameterWithKey:@"oauth_consumer_key" value:consumer.key] URLEncodedKeyValuePair],
									  [[TWURLRequestParameter requestParameterWithKey:@"oauth_signature_method" value:[signatureProvider name]] URLEncodedKeyValuePair],
									  [[TWURLRequestParameter requestParameterWithKey:@"oauth_timestamp" value:timestamp] URLEncodedKeyValuePair],
									  [[TWURLRequestParameter requestParameterWithKey:@"oauth_nonce" value:nonce] URLEncodedKeyValuePair],
									  [[TWURLRequestParameter requestParameterWithKey:@"oauth_version" value:@"1.0"] URLEncodedKeyValuePair],
									  nil];
    
    if (![token.key isEqualToString:@""]) {
        [parameterPairs addObject:[[TWURLRequestParameter requestParameterWithKey:@"oauth_token" value:token.key] URLEncodedKeyValuePair]];
    }
    
    // Add existing parameters
	for (TWURLRequestParameter *parameter in [self parameters]) {
		[parameterPairs addObject:[parameter URLEncodedKeyValuePair]];
	}
    
	// Sort and concatenate
    NSString *normalizedRequestParameters = [[parameterPairs sortedArrayUsingSelector:@selector(compare:)] componentsJoinedByString:@"&"];
	[parameterPairs release];
    	
    // OAuth Spec, Section 9.1.2 "Concatenate Request Elements"
    NSString *signatureBaseString = [NSString stringWithFormat:@"%@&%@&%@", [self HTTPMethod],
									 [[[self URL] OAuthString] URLEncodedString],
									 [normalizedRequestParameters URLEncodedString]];
	
	// Sign
	// Secrets must be urlencoded before concatenated with '&'
    NSString *signature = [signatureProvider signClearText:signatureBaseString withSecret:
						   [NSString stringWithFormat:@"%@&%@", [consumer.secret URLEncodedString], 
							[token.secret URLEncodedString]]];
    
    // Set OAuth headers
    NSString *oauthToken = @"";
    if (![token.key isEqualToString:@""]) {
        oauthToken = [NSString stringWithFormat:@"oauth_token=\"%@\", ", [token.key URLEncodedString]];
	}
    
    NSString *oauthHeader = [NSString stringWithFormat:@"OAuth realm=\"%@\", oauth_consumer_key=\"%@\", %@oauth_signature_method=\"%@\", oauth_signature=\"%@\", oauth_timestamp=\"%@\", oauth_nonce=\"%@\", oauth_version=\"1.0\"",
                             [realm URLEncodedString],
                             [consumer.key URLEncodedString],
                             oauthToken,
                             [[signatureProvider name] URLEncodedString],
                             [signature URLEncodedString],
                             timestamp,
                             nonce];
	
	// Clean up
	[signatureProvider release];
	
	// Add the header
    [self setValue:oauthHeader forHTTPHeaderField:@"Authorization"];
}

@end
