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

	date = [NSDate dateWithTimeIntervalSince1970:1323818220];
	string = @"2011-12-13T17:17:00-06:00";
	GHAssertEqualObjects(date, [NSDate dateFromISO8601String:string], nil);
}


- (void)testISO8601String {
	NSDate *date = [NSDate dateWithTimeIntervalSince1970:1296502956];
	NSString *string = @"2011-01-31T19:42:36Z";
	GHAssertEqualObjects(string, [date ISO8601String], nil);
	
	date = [NSDate dateWithTimeIntervalSince1970:1336467079];
	string = @"2012-05-08T08:51:19Z";
	GHAssertEqualObjects(string, [date ISO8601String], nil);
}


- (void)testOccursToday {
	NSDate *now = [NSDate date];
	GHAssertTrue([now occursToday], nil);

	NSDate *tomorrow = [now dateByAddingTimeInterval:86400];
	GHAssertFalse([tomorrow occursToday], nil);

	NSDate *yesterday = [now dateByAddingTimeInterval:-86400];
	GHAssertFalse([yesterday occursToday], nil);
}


- (void)testOccursTomorrow {
	NSDate *now = [NSDate date];
	GHAssertFalse([now occursTomorrow], nil);

	NSDate *tomorrow = [now dateByAddingTimeInterval:86400];
	GHAssertTrue([tomorrow occursTomorrow], nil);
}


- (void)testDateAtMidnight {
	NSDate *now = [NSDate date];

	NSDate *midnight = [now dateAtMidnight];
	GHAssertNotNil(midnight, nil);

	NSCalendar *calendar = [NSCalendar currentCalendar];
	NSDateComponents *midnightComponents = [calendar components:(NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit) fromDate:midnight];
	GHAssertEquals(midnightComponents.hour, 0, nil);
	GHAssertEquals(midnightComponents.minute, 0, nil);


	NSDateComponents *nowComponents = [calendar components:(NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit) fromDate:now];
	GHAssertEquals(nowComponents.year, midnightComponents.year, nil);
	GHAssertEquals(nowComponents.month, midnightComponents.month, nil);
	GHAssertEquals(nowComponents.day, midnightComponents.day, nil);
	GHAssertNotEquals(nowComponents.hour, midnightComponents.hour, nil);
	GHAssertNotEquals(nowComponents.minute, midnightComponents.minute, nil);
}

@end
