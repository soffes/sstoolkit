//
//  NSURL+OAuthString.m
//  TWToolkit
//
//  Created by Sam Soffes on 11/17/09.
//  Copyright 2009 Tasteful Works, Inc. All rights reserved.
//

#import "NSURL+OAuthString.h"

@implementation NSURL (OAuthString)

- (NSString *)OAuthString {
	NSString *lowercaseScheme = [[self scheme] lowercaseString];

	// Check port - only show port if nonstandard
	NSString *port = @"";
	if ([self port]) {
		NSInteger portInteger = [[self port] integerValue];
		if (!(([lowercaseScheme isEqualToString:@"http"] && portInteger == 80) || 
			  ([lowercaseScheme isEqualToString:@"https"] && portInteger == 443)
			)) {
			port = [NSString stringWithFormat:@":%i", portInteger];
		}
	}
	
	// Build string
	return [[NSString stringWithFormat:@"%@://%@%@%@", lowercaseScheme, [self host], port, [self path]] lowercaseString];
}

@end
