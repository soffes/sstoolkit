//
//  NSDate+dateFromISO8601String.m
//  TWToolkit
//
//  Created by Sam Soffes on 5/26/10.
//  Copyright 2010 Tasteful Works, Inc. All rights reserved.
//

#import "NSDate+dateFromISO8601String.h"

@implementation NSDate (dateFromISO8601String)

+ (NSDate *)dateFromISO8601String:(NSString *)string {
	NSDateFormatter* dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
    return [dateFormatter dateFromString:string];
}

@end
