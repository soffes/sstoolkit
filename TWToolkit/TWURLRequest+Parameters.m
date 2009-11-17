//
//  TWURLRequest+Parameters.m
//  TWToolkit
//
//  Created by Sam Soffes on 11/9/09.
//  Copyright 2009 Tasteful Works, Inc. All rights reserved.
//

#import "TWURLRequest+Parameters.h"
#import "TWURLRequestParameter.h"
#import "NSURL+OAuthString.h"

@implementation TWURLRequest (Parameters)

+ (NSArray *)parametersFromString:(NSString *)encodedParameters {
            
	// Check for empty parameters
    if (encodedParameters == nil || [encodedParameters isEqualToString:@""]) {
        return nil;
	}
	
    NSArray *encodedParameterPairs = [encodedParameters componentsSeparatedByString:@"&"];
    NSMutableArray *requestParameters = [[NSMutableArray alloc] initWithCapacity:16];
    
    for (NSString *encodedPair in encodedParameterPairs) {
        NSArray *encodedPairElements = [encodedPair componentsSeparatedByString:@"="];
        TWURLRequestParameter *parameter = [TWURLRequestParameter requestParameterWithKey:[[encodedPairElements objectAtIndex:0] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]
																			   value:[[encodedPairElements objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        [requestParameters addObject:parameter];
    }
	
    return [requestParameters autorelease];
}


- (NSArray *)parameters {
	NSString *encodedParameters = nil;
    
	// GET and DELETE
    if ([[self HTTPMethod] isEqualToString:@"GET"] || [[self HTTPMethod] isEqualToString:@"DELETE"]) {
        encodedParameters = [[[self URL] query] retain];
	}
	
	// POST and PUT
	else {
        encodedParameters = [[NSString alloc] initWithData:[self HTTPBody] encoding:NSASCIIStringEncoding];
    }
	
	NSArray *parameters = [[self class] parametersFromString:encodedParameters];
	[encodedParameters release];
	return parameters;
}


- (void)setParameters:(NSArray *)parameters  {
    NSMutableString *encodedParameterPairs = [NSMutableString stringWithCapacity:256];
    
    NSInteger position = 1;
    for (TWURLRequestParameter *requestParameter in parameters) {
        [encodedParameterPairs appendString:[requestParameter URLEncodedKeyValuePair]];
        if (position < [parameters count]) {
            [encodedParameterPairs appendString:@"&"];
		}
        position++;
    }
    
	// GET and DELETE
    if ([[self HTTPMethod] isEqualToString:@"GET"] || [[self HTTPMethod] isEqualToString:@"DELETE"]) {
        [self setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?%@", [[self URL] OAuthString], encodedParameterPairs]]];
	}
	
	// PUT and POST
	else {
        NSData *postData = [encodedParameterPairs dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        [self setHTTPBody:postData];
        [self setValue:[NSString stringWithFormat:@"%d", [postData length]] forHTTPHeaderField:@"Content-Length"];
        [self setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    }
}


- (void)appendParameters:(NSArray *)additionalParameters {
	NSMutableArray *parameters = [NSMutableArray arrayWithArray:[self parameters]];
	[parameters addObjectsFromArray:additionalParameters];
	[self setParameters:parameters];
}


- (void)appendParameter:(TWURLRequestParameter *)parameter {
	NSMutableArray *parameters = [NSMutableArray arrayWithArray:[self parameters]];
	[parameters addObject:parameter];
	[self setParameters:parameters];
}


- (void)appendParametersFromString:(NSString *)parametersString {
	[self appendParameters:[[self class] parametersFromString:parametersString]];
}

@end
