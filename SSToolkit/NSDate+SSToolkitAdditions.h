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

/**
 Returns a new date represented by an ISO8601 string.
 
 @param iso8601String An ISO8601 string
 
 @return Date represented by the ISO8601 string
 */
+ (NSDate *)dateFromISO8601String:(NSString *)iso8601String;

/**
 Returns a string representation of the receiver in ISO8601 format.
 
 @return A string representation of the receiver in ISO8601 format.
 */
- (NSString *)ISO8601String;


///--------------------
/// @name Time In Words
///--------------------

/**
 Returns a string representing the time interval from now in words (including seconds).
 
 The strings produced by this method will be similar to produced by Twitter for iPhone or Tweetbot in the top right of
 the tweet cells.
 
 Internally, this does not use `timeInWordsFromTimeInterval:includingSeconds:`.
 
 @return A string representing the time interval from now in words
 */
- (NSString *)briefTimeInWords;

/**
 Returns a string representing the time interval from now in words (including seconds).
 
 The strings produced by this method will be similar to produced by ActiveSupport's `time_ago_in_words` helper method.
 
 @return A string representing the time interval from now in words
 
 @see timeInWordsIncludingSeconds:
 @see timeInWordsFromTimeInterval:includingSeconds:
 */
- (NSString *)timeInWords;

/**
 Returns a string representing the time interval from now in words.
 
 The strings produced by this method will be similar to produced by ActiveSupport's `time_ago_in_words` helper method.
 
 @param includeSeconds `YES` if seconds should be included. `NO` if they should not.
 
 @return A string representing the time interval from now in words
 
 @see timeInWordsIncludingSeconds:
 @see timeInWordsFromTimeInterval:includingSeconds:
 */
- (NSString *)timeInWordsIncludingSeconds:(BOOL)includeSeconds;

/**
 Returns a string representing a time interval in words.
 
 The strings produced by this method will be similar to produced by ActiveSupport's `time_ago_in_words` helper method.
 
 @param intervalInSeconds The time interval to convert to a string
 
 @param includeSeconds `YES` if seconds should be included. `NO` if they should not.
 
 @return A string representing the time interval in words
 
 @see timeInWords
 @see timeInWordsIncludingSeconds:
 */
+ (NSString *)timeInWordsFromTimeInterval:(NSTimeInterval)intervalInSeconds includingSeconds:(BOOL)includeSeconds;


///----------------------
/// @name Time In Seconds
///----------------------

/**
 Returns a UNIX timestamp, i.e. the number of seconds from the first instant of 1 January 1970, GMT.

 @return The interval between now and the reference date, 1 January 1970, GMT
 */
+ (NSTimeInterval)unix;

/**
 Returns the number of seconds in a day

 @return Number of seconds in a day
 */
+ (NSTimeInterval)dayInSeconds;

/**
 Returns the number of seconds in a week

 A week is considered to have 7 days, so that the value returned depends on dayInSeconds

 @return Number of seconds in a week
 */
+ (NSTimeInterval)weekInSeconds;

/**
 Returns the number of seconds in a month.

 A month is considered to have 30 days, so that the value returned depends on dayInSeconds

 @return Number of seconds in a month
 */
+ (NSTimeInterval)monthInSeconds;

/**
 Returns the number of seconds in a year.

 A year is considered to have 365 days, so that the value returned depends on dayInSeconds

 @return Number of seconds in a year
 */
+ (NSTimeInterval)yearInSeconds;


///-------------------------
/// @name Occurrence queries
///-------------------------

/**
 Returns a Boolean value that indicates whether a given date occurs today.

 @return YES if the date receiver occurs today, otherwise NO
 */
- (BOOL)occursToday;

/**
 Returns a Boolean value that indicates whether a given date occurs tomorrow.

 @return YES if the date receiver occurs tomorrow, otherwise NO
 */
- (BOOL)occursTomorrow;

@end
