//
//  NSURL+SSToolkitAdditions.m
//  SSToolkit
//
//  Created by Sam Soffes on 4/27/10.
//  Copyright 2010 Sam Soffes. All rights reserved.
//

#import "NSURL+SSToolkitAdditions.h"

@implementation NSURL (SSToolkitAdditions)

// Not a perfect implementation, but will work for most cases
- (NSDictionary *)queryDictionary {
	NSArray *components = [[self query] componentsSeparatedByString:@"&"];
	NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] initWithCapacity:[components count]];	
	for (NSString *component in components) {
		NSArray *keyValue = [component componentsSeparatedByString:@"="];
		[dictionary setObject:[[keyValue objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] forKey:[[keyValue objectAtIndex:0] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	}
	return [dictionary autorelease];
}

@end
