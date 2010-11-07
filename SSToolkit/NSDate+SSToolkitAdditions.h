//
//  NSDate+SSToolkitAdditions.h
//  SSToolkit
//
//  Created by Sam Soffes on 5/26/10.
//  Copyright 2009-2010 Sam Soffes. All rights reserved.
//

@interface NSDate (SSToolkitAdditions)

+ (NSDate *)dateFromISO8601String:(NSString *)string;
- (NSString *)ISO8601String;


// Adjusts for the current time zone
- (NSDate *)adjustedDate;

+ (NSString *)timeAgoInWordsFromTimeInterval:(NSTimeInterval)intervalInSeconds includingSeconds:(BOOL)includeSeconds;
- (NSString *)timeAgoInWords;
- (NSString *)timeAgoInWordsIncludingSeconds:(BOOL)includeSeconds;
- (NSString *)adjustedTimeAgoInWords;
- (NSString *)adjustedTimeAgoInWordsIncludingSeconds:(BOOL)includeSeconds;

@end
