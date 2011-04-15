//
//  NSDate+SSToolkitAdditions.m
//  SSToolkit
//
//  Created by Sam Soffes on 5/26/10.
//  Copyright 2010-2011 Sam Soffes. All rights reserved.
//

#import "NSDate+SSToolkitAdditions.h"
#include <time.h>

@implementation NSDate (SSToolkitAdditions)

+ (NSDate *)dateFromISO8601String:(NSString *)string {
	if (!string) {
		return nil;
	}
	
	struct tm tm;
	strptime([string cStringUsingEncoding:NSUTF8StringEncoding], "%Y-%m-%dT%H:%M:%S%z", &tm);
//	tm.tm_isdst = -1;
	time_t t = mktime(&tm);
	
	return [NSDate dateWithTimeIntervalSince1970:t + [[NSTimeZone localTimeZone] secondsFromGMT]];
}


- (NSString *)ISO8601String {
	struct tm *timeinfo;
	char buffer[80];
	
	time_t rawtime = (time_t)[self timeIntervalSince1970];
	timeinfo = gmtime(&rawtime);
	
	strftime(buffer, 80, "%Y-%m-%dT%H:%M:%SZ", timeinfo);
	
	return [NSString stringWithCString:buffer encoding:NSUTF8StringEncoding];
}


//	Adapted from http://github.com/gabriel/gh-kit/blob/master/Classes/GHNSString+TimeInterval.m
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


- (NSString *)briefTimeAgoInWords {
	NSTimeInterval intervalInSeconds = fabs([self timeIntervalSinceNow]);
	NSTimeInterval intervalInMinutes = round(intervalInSeconds / 60.0f);
	
	if (intervalInMinutes >= 0 && intervalInMinutes <= 1) {
		return @"1 min";		
	} else if (intervalInMinutes >= 2 && intervalInMinutes < 60) {
		return [NSString stringWithFormat:@"%.0f mins", intervalInMinutes];
	} else if (intervalInMinutes >= 60 && intervalInMinutes < 61) {
		return @"1 hour";
	} else if (intervalInMinutes > 60 && intervalInMinutes < 1440) {
		return [NSString stringWithFormat:@"%.0f hours", round(intervalInMinutes/60.0f)];
	} else if (intervalInMinutes >= 1440 && intervalInMinutes <= 2879) {
		return @"1 day";
	} else if (intervalInMinutes >= 2880 && intervalInMinutes <= 43199) {
		return [NSString stringWithFormat:@"%.0f days", round(intervalInMinutes/1440.0f)];
	} else if (intervalInMinutes >= 43200 && intervalInMinutes <= 86399) {
		return @"1 month";
	} else if (intervalInMinutes >= 86400 && intervalInMinutes <= 525599) {
		return [NSString stringWithFormat:@"%.0f months", round(intervalInMinutes/43200.0f)];
	} else if (intervalInMinutes >= 525600 && intervalInMinutes <= 1051199) {
		return @"1 year";
	} else {
		return [NSString stringWithFormat:@"%.0f years", round(intervalInMinutes/525600.0f)];
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
