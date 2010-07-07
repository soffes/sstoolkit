//
//  NSDate+ISO8601String.m
//  TWToolkit
//
//  Created by Sam Soffes on 5/26/10.
//  Copyright 2010 Tasteful Works, Inc. All rights reserved.
//

#import "NSDate+ISO8601String.h"

@implementation NSDate (dateFromISO8601String)

+ (NSDate *)dateFromISO8601String:(NSString *)string {
	if (!string) {
		return nil;
	}
	NSDateFormatter* dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
	[dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'"];
    return [dateFormatter dateFromString:string];
}


- (NSString *)ISO8601String {
	NSDateFormatter* dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
	[dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'"];
	return [dateFormatter stringFromDate:self];
}

@end
