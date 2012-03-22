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
	strncpy(newStr + len - 1, "+0000", 5);
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


- (NSString *)briefTimeAgoInWords {
	NSTimeInterval seconds = fabs([self timeIntervalSinceNow]);
	
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
		return [NSString stringWithFormat:SSToolkitLocalizedString(@"%dd"), days];
	}
	
	// Years
	else if (minutes >= 525600.0) {
		NSInteger years = (NSInteger)round(minutes / 525600.0);
		if (years < 2) {
			return SSToolkitLocalizedString(@"1y");
		}
		return [NSString stringWithFormat:SSToolkitLocalizedString(@"%dy"), years];
	}
	
	return nil;
}


+ (NSString *)timeAgoInWordsFromTimeInterval:(NSTimeInterval)intervalInSeconds includingSeconds:(BOOL)includeSeconds {
	NSTimeInterval intervalInMinutes = round(intervalInSeconds / 60.0f);
	
	if (intervalInMinutes >= 0 && intervalInMinutes <= 1) {
		if (!includeSeconds) {
			return intervalInMinutes <= 0 ? @"less than a minute" : @"1 minute";
		}
		if (intervalInSeconds >= 0 && intervalInSeconds < 5) {
			return [NSString stringWithFormat:@"less than %d seconds", 5];
		} else if (intervalInSeconds >= 5 && intervalInSeconds < 10) {
			return [NSString stringWithFormat:@"less than %d seconds", 10];
		} else if (intervalInSeconds >= 10 && intervalInSeconds < 20) {
			return [NSString stringWithFormat:@"less than %d seconds", 20];
		} else if (intervalInSeconds >= 20 && intervalInSeconds < 40) {
			return @"half a minute";
		} else if (intervalInSeconds >= 40 && intervalInSeconds < 60) {
			return @"less than a minute";
	 	} else {
			return @"1 minute";
		}		
	} else if (intervalInMinutes >= 2 && intervalInMinutes <= 44) {
		return [NSString stringWithFormat:@"%.0f minutes", intervalInMinutes];
	} else if (intervalInMinutes >= 45 && intervalInMinutes <= 89) {
		return @"about 1 hour";
	} else if (intervalInMinutes >= 90 && intervalInMinutes <= 1439) {
		return [NSString stringWithFormat:@"about %.0f hours", round(intervalInMinutes / 60.0f)];
	} else if (intervalInMinutes >= 1440 && intervalInMinutes <= 2879) {
		return @"1 day";
	} else if (intervalInMinutes >= 2880 && intervalInMinutes <= 43199) {
		return [NSString stringWithFormat:@"%.0f days", round(intervalInMinutes / 1440.0f)];
	} else if (intervalInMinutes >= 43200 && intervalInMinutes <= 86399) {
		return @"about 1 month";
	} else if (intervalInMinutes >= 86400 && intervalInMinutes <= 525599) {
		return [NSString stringWithFormat:@"%.0f months", round(intervalInMinutes / 43200.0f)];
	} else if (intervalInMinutes >= 525600 && intervalInMinutes <= 1051199) {
		return @"about 1 year";
	} else {
		return [NSString stringWithFormat:@"over %.0f years", round(intervalInMinutes / 525600.0f)];
	}
	return nil;
}


- (NSString *)timeAgoInWords {
	return [self timeAgoInWordsIncludingSeconds:YES];
}


- (NSString *)timeAgoInWordsIncludingSeconds:(BOOL)includeSeconds {
	return [[self class] timeAgoInWordsFromTimeInterval:fabs([self timeIntervalSinceNow]) includingSeconds:includeSeconds];		
}


@end
