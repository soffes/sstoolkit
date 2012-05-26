//
//  NSNumber+SSToolkitAdditions.m
//  SSToolkit
//
//  Created by Alexander Zats on 5/22/12.
//  Copyright (c) 2012 Sam Soffes. All rights reserved.
//

#import "NSNumber+SSToolkitAdditions.h"

@implementation NSNumber (SSToolkitAdditions)

- (NSDate *)dateValue
{
	NSTimeInterval timestamp = [self doubleValue];
	if (!timestamp) {
		return nil;
	}
	return [NSDate dateWithTimeIntervalSince1970:timestamp];
}

@end
