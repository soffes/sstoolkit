//
//  DateCategoryTest.m
//  SSToolkit
//
//  Created by Sam Soffes on 4/14/11.
//  Copyright 2011 Sam Soffes. All rights reserved.
//

#import <SSToolkit/NSDate+SSToolkitAdditions.h>

@interface DateCategoryTest : GHTestCase
@end

@implementation DateCategoryTest

// To test:
//+ (NSString *)timeAgoInWordsFromTimeInterval:(NSTimeInterval)intervalInSeconds includingSeconds:(BOOL)includeSeconds;
//- (NSString *)timeAgoInWords;
//- (NSString *)timeAgoInWordsIncludingSeconds:(BOOL)includeSeconds;
//- (NSString *)briefTimeAgoInWords;

- (void)testDateFromISO8601String {
	NSDate *date = [NSDate dateWithTimeIntervalSince1970:1296502956];
	NSString *string = @"2011-01-31T19:42:36Z";
	GHAssertEqualObjects(date, [NSDate dateFromISO8601String:string], nil);

	// Specifying a timezone currently isn't supported
//	date = [NSDate dateWithTimeIntervalSince1970:1296586675];
//	string = @"2011-02-01T10:57:55-08:00";
//	GHAssertEqualObjects(date, [NSDate dateFromISO8601String:string], nil);
}


- (void)testISO8601String {
	NSDate *date = [NSDate dateWithTimeIntervalSince1970:1296502956];
	NSString *string = @"2011-01-31T19:42:36Z";
	GHAssertEqualObjects(string, [date ISO8601String], nil);
}

@end
