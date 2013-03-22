//
//  NSDate+SSToolkitAdditions.m
//  SSToolkit
//
//  Created by Sam Soffes on 5/26/10.
//  Copyright 2010-2011 Sam Soffes. All rights reserved.
//

#import "NSDate+SSToolkitAdditions.h"
#import "NSBundle+SSToolkitAdditions.h"
#include <time.h>
#include <xlocale.h>

#define ISO8601_MAX_LEN 25

@implementation NSDate (SSToolkitAdditions)

+ (NSDate *)dateFromISO8601String:(NSString *)iso8601 {
	if (!iso8601) {
        return nil;
    }
	
    const char *str = [iso8601 cStringUsingEncoding:NSUTF8StringEncoding];
    char newStr[ISO8601_MAX_LEN];
    bzero(newStr, ISO8601_MAX_LEN);
	
    size_t len = strlen(str);
    if (len == 0) {
        return nil;
    }
	
    // UTC dates ending with Z
    if (len == 20 && str[len - 1] == 'Z') {
        memcpy(newStr, str, len - 1);
	strncpy(newStr + len - 1, "+0000\0", 6);
    }
	
    // Timezone includes a semicolon (not supported by strptime)
    else if (len == 25 && str[22] == ':') { 
        memcpy(newStr, str, 22);    
        memcpy(newStr + 22, str + 23, 2);
    }
	
    // Fallback: date was already well-formatted OR any other case (bad-formatted)
    else { 
        memcpy(newStr, str, len > ISO8601_MAX_LEN - 1 ? ISO8601_MAX_LEN - 1 : len);	
    }
	
  // Add null terminator
  newStr[sizeof(newStr) - 1] = 0;
  
    struct tm tm = {
        .tm_sec = 0,
        .tm_min = 0,
        .tm_hour = 0,
        .tm_mday = 0,
        .tm_mon = 0,
        .tm_year = 0,
        .tm_wday = 0,
        .tm_yday = 0,
        .tm_isdst = -1,
    };
	
    if (strptime_l(newStr, "%FT%T%z", &tm, NULL) == NULL) {
        return nil;
    }

    return [NSDate dateWithTimeIntervalSince1970:mktime(&tm)];
}


- (NSString *)ISO8601String {
	struct tm *timeinfo;
	char buffer[80];
	
	time_t rawtime = (time_t)[self timeIntervalSince1970];
	timeinfo = gmtime(&rawtime);
	
	strftime(buffer, 80, "%Y-%m-%dT%H:%M:%SZ", timeinfo);
	
	return [NSString stringWithCString:buffer encoding:NSUTF8StringEncoding];
}


- (NSString *)briefTimeInWords {
	NSTimeInterval seconds = fabs([self timeIntervalSinceNow]);
	
	static NSNumberFormatter *numberFormatter = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		numberFormatter = [[NSNumberFormatter alloc] init];
		numberFormatter.numberStyle = NSNumberFormatterCurrencyStyle;
		numberFormatter.currencySymbol = @"";
		numberFormatter.maximumFractionDigits = 0;
	});
	
	// Seconds
	if (seconds < 60.0) {
		if (seconds < 2.0) {
			return SSToolkitLocalizedString(@"1s");
		}
		return [NSString stringWithFormat:SSToolkitLocalizedString(@"%ds"), (NSInteger)seconds];
	}
	
	NSTimeInterval minutes = round(seconds / 60.0);
	
	// Minutes
	if (minutes >= 0.0 && minutes < 60.0) {
		if (minutes < 2.0) {
			return SSToolkitLocalizedString(@"1m");
		}
		return [NSString stringWithFormat:SSToolkitLocalizedString(@"%dm"), (NSInteger)minutes];
	}
	
	// Hours
	else if (minutes >= 60.0 && minutes < 1440.0) {
		NSInteger hours = (NSInteger)round(minutes / 60.0);
		if (hours < 2) {
			return SSToolkitLocalizedString(@"1h");
		}
		return [NSString stringWithFormat:SSToolkitLocalizedString(@"%dh"), hours];
	}
	
	// Days
	else if (minutes >= 1440.0 && minutes < 525600.0) {
		NSInteger days = (NSInteger)round(minutes / 1440.0);
		if (days < 2) {
			return SSToolkitLocalizedString(@"1d");
		}
		return [NSString stringWithFormat:SSToolkitLocalizedString(@"%@d"),
				[numberFormatter stringFromNumber:[NSNumber numberWithInteger:days]]];
	}
	
	// Years
	else if (minutes >= 525600.0) {
		NSInteger years = (NSInteger)round(minutes / 525600.0);
		if (years < 2) {
			return SSToolkitLocalizedString(@"1y");
		}
		return [NSString stringWithFormat:SSToolkitLocalizedString(@"%@y"),
				[numberFormatter stringFromNumber:[NSNumber numberWithInteger:years]]];
	}
	
	return nil;
}


+ (NSString *)timeInWordsFromTimeInterval:(NSTimeInterval)intervalInSeconds includingSeconds:(BOOL)includeSeconds {
	NSTimeInterval intervalInMinutes = round(intervalInSeconds / 60.0f);
	
	if (intervalInMinutes >= 0 && intervalInMinutes <= 1) {
		if (!includeSeconds) {
			return intervalInMinutes <= 0 ? SSToolkitLocalizedString(@"less than a minute") : SSToolkitLocalizedString(@"1 minute");
		}
		if (intervalInSeconds >= 0 && intervalInSeconds < 5) {
			return [NSString stringWithFormat:SSToolkitLocalizedString(@"less than %d seconds"), 5];
		} else if (intervalInSeconds >= 5 && intervalInSeconds < 10) {
			return [NSString stringWithFormat:SSToolkitLocalizedString(@"less than %d seconds"), 10];
		} else if (intervalInSeconds >= 10 && intervalInSeconds < 20) {
			return [NSString stringWithFormat:@"%d seconds", 20];
		} else if (intervalInSeconds >= 20 && intervalInSeconds < 40) {
			return SSToolkitLocalizedString(@"half a minute");
		} else if (intervalInSeconds >= 40 && intervalInSeconds < 60) {
			return SSToolkitLocalizedString(@"less than a minute");
	 	} else {
			return SSToolkitLocalizedString(@"1 minute");
		}		
	} else if (intervalInMinutes >= 2 && intervalInMinutes <= 44) {
		return [NSString stringWithFormat:SSToolkitLocalizedString(@"%d minutes"), (NSInteger)intervalInMinutes];
	} else if (intervalInMinutes >= 45 && intervalInMinutes <= 89) {
		return SSToolkitLocalizedString(@"about 1 hour");
	} else if (intervalInMinutes >= 90 && intervalInMinutes <= 1439) {
		return [NSString stringWithFormat:SSToolkitLocalizedString(@"about %d hours"), (NSInteger)round(intervalInMinutes / 60.0f)];
	} else if (intervalInMinutes >= 1440 && intervalInMinutes <= 2879) {
		return SSToolkitLocalizedString(@"1 day");
	} else if (intervalInMinutes >= 2880 && intervalInMinutes <= 43199) {
		return [NSString stringWithFormat:SSToolkitLocalizedString(@"%d days"), (NSInteger)round(intervalInMinutes / 1440.0f)];
	} else if (intervalInMinutes >= 43200 && intervalInMinutes <= 86399) {
		return SSToolkitLocalizedString(@"about 1 month");
	} else if (intervalInMinutes >= 86400 && intervalInMinutes <= 525599) {
		return [NSString stringWithFormat:SSToolkitLocalizedString(@"%d months"), (NSInteger)round(intervalInMinutes / 43200.0f)];
	} else if (intervalInMinutes >= 525600 && intervalInMinutes <= 1051199) {
		return SSToolkitLocalizedString(@"about 1 year");
	} else {
		return [NSString stringWithFormat:SSToolkitLocalizedString(@"over %d years"), (NSInteger)round(intervalInMinutes / 525600.0f)];
	}
	return nil;
}


- (NSString *)timeInWords {
	return [self timeInWordsIncludingSeconds:YES];
}


- (NSString *)timeInWordsIncludingSeconds:(BOOL)includeSeconds {
	return [[self class] timeInWordsFromTimeInterval:fabs([self timeIntervalSinceNow]) includingSeconds:includeSeconds];		
}


- (NSDate *)dateAtMidnight {
	NSCalendar *calendar = [NSCalendar currentCalendar];

	NSDateComponents *dateComponents = [calendar components:(NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit) fromDate:self];
	return [calendar dateFromComponents:dateComponents];
}


+ (NSTimeInterval)unix {
	return [[NSDate date] timeIntervalSince1970];
}


- (NSTimeInterval)secondsInDay {
	NSCalendar *calendar = [NSCalendar currentCalendar];

	NSDateComponents *dayIncrementComponents = [[NSDateComponents alloc] init];
	[dayIncrementComponents setDay:1];
	NSDate *tomorrowMidnight = [[calendar dateByAddingComponents:dayIncrementComponents toDate:self options:0] dateAtMidnight];

	NSDate *midnight = [self dateAtMidnight];

	return [tomorrowMidnight timeIntervalSinceDate:midnight];
}


- (NSTimeInterval)secondsInWeek {
	NSCalendar *calendar = [NSCalendar currentCalendar];

	NSDateComponents *firstWeekDayComponents = [calendar components:(NSYearForWeekOfYearCalendarUnit|NSYearCalendarUnit|NSMonthCalendarUnit|NSWeekCalendarUnit|NSWeekdayCalendarUnit) fromDate:self];
	firstWeekDayComponents.weekday = 1;
	NSDate *firstDayInWeek = [calendar dateFromComponents:firstWeekDayComponents];

	NSDateComponents *weekIncrementComponents = [[NSDateComponents alloc] init];
	[weekIncrementComponents setWeek:1];
	NSDate *lastDayInWeek = [calendar dateByAddingComponents:weekIncrementComponents toDate:firstDayInWeek options:0];

	return [lastDayInWeek timeIntervalSinceDate:firstDayInWeek];
}


- (NSTimeInterval)secondsInMonth {
	NSCalendar *calendar = [NSCalendar currentCalendar];

	NSDateComponents *firstMonthDayComponents = [calendar components:(NSYearForWeekOfYearCalendarUnit|NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit) fromDate:self];
	firstMonthDayComponents.day = 1;
	NSDate *firstDayInMonth = [calendar dateFromComponents:firstMonthDayComponents];

	NSDateComponents *monthIncrementComponents = [[NSDateComponents alloc] init];
	[monthIncrementComponents setMonth:1];
	NSDate *lastDayInMonth = [calendar dateByAddingComponents:monthIncrementComponents toDate:firstDayInMonth options:0];

	return [lastDayInMonth timeIntervalSinceDate:firstDayInMonth];
}


- (NSTimeInterval)secondsInQuarter {
	NSCalendar *calendar = [NSCalendar currentCalendar];

	NSDateComponents *firstQuarterDayComponents = [calendar components:(NSYearCalendarUnit|NSQuarterCalendarUnit|NSDayCalendarUnit) fromDate:self];
	firstQuarterDayComponents.day = 1;
	NSDate *firstDayInQuarter = [calendar dateFromComponents:firstQuarterDayComponents];

	NSDateComponents *quarterIncrementComponents = [[NSDateComponents alloc] init];
	quarterIncrementComponents.month = 3;
	NSDate *lastDayInQuarter = [calendar dateByAddingComponents:quarterIncrementComponents toDate:firstDayInQuarter options:0];

	return [lastDayInQuarter timeIntervalSinceDate:firstDayInQuarter];
}


- (NSTimeInterval)secondsInYear {
	NSCalendar *calendar = [NSCalendar currentCalendar];

	NSDateComponents *firstYearDayComponents = [calendar components:(NSYearForWeekOfYearCalendarUnit|NSYearCalendarUnit|NSDayCalendarUnit) fromDate:self];
	firstYearDayComponents.day = 1;
	NSDate *firstDayInYear = [calendar dateFromComponents:firstYearDayComponents];

	NSDateComponents *yearIncrementComponents = [[NSDateComponents alloc] init];
	[yearIncrementComponents setYear:1];
	NSDate *lastDayInYear = [calendar dateByAddingComponents:yearIncrementComponents toDate:firstDayInYear options:0];

	return [lastDayInYear timeIntervalSinceDate:firstDayInYear];
}


- (BOOL)occursToday {
	NSCalendar *calendar = [NSCalendar currentCalendar];

	NSDateComponents *todayComponents = [calendar components:(NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit) fromDate:[NSDate date]];
	NSDateComponents *dateComponents = [calendar components:(NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit) fromDate:self];

	if (dateComponents.day == todayComponents.day && dateComponents.month == todayComponents.month && dateComponents.year == todayComponents.year) {
		return YES;
	}
	return NO;
}


- (BOOL)occursTomorrow {
	NSCalendar *calendar = [NSCalendar currentCalendar];

	NSDateComponents *dayIncrementComponents = [[NSDateComponents alloc] init];
	[dayIncrementComponents setDay:1];
	NSDate *tomorrow = [calendar dateByAddingComponents:dayIncrementComponents toDate:[NSDate date] options:0];

	NSDateComponents *tomorrowComponents = [calendar components:(NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit) fromDate:tomorrow];
	NSDateComponents *dateComponents = [calendar components:(NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit) fromDate:self];

	if (dateComponents.day == tomorrowComponents.day && dateComponents.month == tomorrowComponents.month && dateComponents.year == tomorrowComponents.year) {
		return YES;
	}
	return NO;
}

@end
