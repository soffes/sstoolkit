//
//  DateCategoryTest.m
//  SSToolkit
//
//  Created by Sam Soffes on 4/14/11.
//  Copyright 2011 Sam Soffes. All rights reserved.
//

#import <SSToolkit/NSDate+SSToolkitAdditions.h>

#define DAYLIGHT_SAVING_TIME 3600.0

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

	NSUInteger components = (NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit);

	NSCalendar *calendar = [NSCalendar currentCalendar];
	NSDateComponents *midnightComponents = [calendar components:components fromDate:midnight];
	GHAssertEquals(midnightComponents.hour, 0, nil);
	GHAssertEquals(midnightComponents.minute, 0, nil);

	NSDateComponents *nowComponents = [calendar components:components fromDate:now];
	GHAssertEquals(nowComponents.year, midnightComponents.year, nil);
	GHAssertEquals(nowComponents.month, midnightComponents.month, nil);
	GHAssertEquals(nowComponents.day, midnightComponents.day, nil);
	GHAssertNotEquals(nowComponents.hour, midnightComponents.hour, nil);
	GHAssertNotEquals(nowComponents.minute, midnightComponents.minute, nil);
}


- (void)testSecondsInDay {
	// Not sure if this could fail when testing on a day when daylight saving time applies
	GHAssertEquals([[NSDate date] secondsInDay], 86400.0, nil);
}


- (void)testSecondsInWeek {
	NSTimeInterval secondsInRegularWeek = 604800.0;	// 86400 * 7

	NSTimeInterval valueToTest = [[NSDate date] secondsInWeek];
	BOOL testWeek = (valueToTest == secondsInRegularWeek || valueToTest == (secondsInRegularWeek - DAYLIGHT_SAVING_TIME) || valueToTest == (secondsInRegularWeek + DAYLIGHT_SAVING_TIME));
	GHAssertTrue(testWeek, nil);
}


- (void)testSecondsInMonth {
	NSTimeInterval secondsIn28DaysMonth = 2419200.0;	// 86400 * 28
	NSTimeInterval secondsIn29DaysMonth = 2505600.0;	// 86400 * 29
	NSTimeInterval secondsIn30DaysMonth = 2592000.0;	// 86400 * 30
	NSTimeInterval secondsIn31DaysMonth = 2678400.0;	// 86400 * 31

	NSTimeInterval valueToTest = [[NSDate date] secondsInMonth];
	BOOL test28DaysMonth = (valueToTest == secondsIn28DaysMonth || valueToTest == (secondsIn28DaysMonth - DAYLIGHT_SAVING_TIME) || valueToTest == (secondsIn28DaysMonth + DAYLIGHT_SAVING_TIME));
	BOOL test29DaysMonth = (valueToTest == secondsIn29DaysMonth || valueToTest == (secondsIn29DaysMonth - DAYLIGHT_SAVING_TIME) || valueToTest == (secondsIn29DaysMonth + DAYLIGHT_SAVING_TIME));
	BOOL test30DaysMonth = (valueToTest == secondsIn30DaysMonth || valueToTest == (secondsIn30DaysMonth - DAYLIGHT_SAVING_TIME) || valueToTest == (secondsIn30DaysMonth + DAYLIGHT_SAVING_TIME));
	BOOL test31DaysMonth = (valueToTest == secondsIn31DaysMonth || valueToTest == (secondsIn31DaysMonth - DAYLIGHT_SAVING_TIME) || valueToTest == (secondsIn31DaysMonth + DAYLIGHT_SAVING_TIME));

	GHAssertTrue((test28DaysMonth || test29DaysMonth || test30DaysMonth || test31DaysMonth), nil);
}


- (void)testSecondsInYear {
	static const NSTimeInterval secondsIn365DaysYear = 31536000.0;	// 86400 * 365
	static const NSTimeInterval secondsIn364DaysYear = 31449600.0;	// 86400 * 364

	NSTimeInterval valueToTest = [[NSDate date] secondsInYear];
	BOOL test365DaysYear = (valueToTest == secondsIn365DaysYear || valueToTest == (secondsIn365DaysYear - DAYLIGHT_SAVING_TIME) || valueToTest == (secondsIn365DaysYear + DAYLIGHT_SAVING_TIME));
	BOOL test364DaysYear = (valueToTest == secondsIn364DaysYear || valueToTest == (secondsIn364DaysYear - DAYLIGHT_SAVING_TIME) || valueToTest == (secondsIn364DaysYear + DAYLIGHT_SAVING_TIME));

	GHAssertTrue((test365DaysYear || test364DaysYear), nil);
}

@end
