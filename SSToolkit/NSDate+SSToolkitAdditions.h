//
//  NSDate+SSToolkitAdditions.h
//  SSToolkit
//
//  Created by Sam Soffes on 5/26/10.
//  Copyright 2010-2011 Sam Soffes. All rights reserved.
//

/**
 Provides extensions to `NSDate` for various common tasks.
 */
@interface NSDate (SSToolkitAdditions)

///---------------
/// @name ISO 8601
///---------------

+ (NSDate *)dateFromISO8601String:(NSString *)string;
- (NSString *)ISO8601String;

///---------------
/// @name Time Ago
///---------------

+ (NSString *)timeAgoInWordsFromTimeInterval:(NSTimeInterval)intervalInSeconds includingSeconds:(BOOL)includeSeconds;
- (NSString *)timeAgoInWords;
- (NSString *)timeAgoInWordsIncludingSeconds:(BOOL)includeSeconds;
- (NSString *)briefTimeAgoInWords;

@end
