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

@implementation NSDate (SSToolkitAdditions)

+ (NSDate *)dateFromISO8601String:(NSString *)iso8601 {
	if (!iso8601) {
		return nil;
	}

	const char *str = [iso8601 cStringUsingEncoding:NSUTF8StringEncoding];
	char newStr[25];

	struct tm tm;
	size_t len = strlen(str);
	if (len == 0) {
		return nil;
	}

	// UTC
	if (len == 20 && str[len - 1] == 'Z') {
		strncpy(newStr, str, len - 1);
		strncpy(newStr + len - 1, "+0000", 5);
	}

	// Timezone
	else if (len == 24 && str[22] == ':') {
		strncpy(newStr, str, 22);    
		strncpy(newStr + 22, str + 23, 2);
	}

	// Poorly formatted timezone
	else {
		strncpy(newStr, str, len > 24 ? 24 : len);
	}

  // Add null terminator
  newStr[sizeof(newStr) - 1] = 0;
  
	if (strptime(newStr, "%FT%T%z", &tm) == NULL) {
		return nil;
	}

	time_t t; 
	t = mktime(&tm);

	return [NSDate dateWithTimeIntervalSince1970:t];
}


- (NSString *)ISO8601String {
	struct tm *timeinfo;
	char buffer[80];
	
	time_t rawtime = (time_t)[self timeIntervalSince1970];
	timeinfo = gmtime(&rawtime);
	
	strftime(buffer, 80, "%Y-%m-%@T%H:%M:%SZ", timeinfo);
	
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


@end
