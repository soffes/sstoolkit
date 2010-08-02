//
//  NSDate+TWToolkitAdditions.m
//  TWToolkit
//
//  Created by Sam Soffes on 5/26/10.
//  Copyright 2010 Tasteful Works, Inc. All rights reserved.
//

#import "NSDate+TWToolkitAdditions.h"

@implementation NSDate (TWToolkitAdditions)

+ (NSDate *)dateFromISO8601String:(NSString *)string {
	NSDateFormatter* dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
	[dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'"];
    return [dateFormatter dateFromString:string];
}


- (NSString *)ISO8601String {
	NSDateFormatter* dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
	[dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'"];
	return [dateFormatter stringFromDate:self];
}


- (NSString *)timeAgoInWords {
	return [self timeAgoInWordsIncludingSeconds:YES];
}


- (NSString *)timeAgoInWordsIncludingSeconds:(BOOL)includeSeconds {
	NSTimeInterval intervalInSeconds = fabs([self timeIntervalSinceNow]);
	double intervalInMinutes = round(intervalInSeconds / 60.0);
	
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
		return [NSString stringWithFormat:@"about %.0f hours", round(intervalInMinutes/60.0)];
	} else if (intervalInMinutes >= 1440 && intervalInMinutes <= 2879) {
		return @"1 day";
	} else if (intervalInMinutes >= 2880 && intervalInMinutes <= 43199) {
		return [NSString stringWithFormat:@"%.0f days", round(intervalInMinutes/1440.0)];
	} else if (intervalInMinutes >= 43200 && intervalInMinutes <= 86399) {
		return @"about 1 month";
	} else if (intervalInMinutes >= 86400 && intervalInMinutes <= 525599) {
		return [NSString stringWithFormat:@"%.0f months", round(intervalInMinutes/43200.0)];
	} else if (intervalInMinutes >= 525600 && intervalInMinutes <= 1051199) {
		return @"about 1 year";
	} else {
		return [NSString stringWithFormat:@"over %.0f years", round(intervalInMinutes/525600.0)];
	}
	return nil;
}

@end
