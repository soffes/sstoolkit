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

 @bug [Issue #56](https://github.com/samsoffes/sstoolkit/issues/56): Currently this method doesn't work with
 strings that include a timezone as anything other than "Z" like this one
 "2011-02-01T10:57:55-08:00".
 */
+ (NSDate *)dateFromISO8601String:(NSString *)iso8601String;

/**
 Returns a string representation of the receiver in ISO8601 format.

 @return A string representation of the receiver in ISO8601 format.
 */
- (NSString *)ISO8601String;


///---------------
/// @name Time Ago
///---------------

/**
 Returns a string representing a time interval in words.

 The strings produced by this method will be similar to produced by ActiveSupport's `time_ago_in_words` helper method.

 @param intervalInSeconds The time interval to convert to a string

 @param includeSeconds `YES` if seconds should be included. `NO` if they should not.

 @return A string representing the time interval in words

 @see timeAgoInWords
 @see timeAgoInWordsIncludingSeconds:
 */
+ (NSString *)timeAgoInWordsFromTimeInterval:(NSTimeInterval)intervalInSeconds includingSeconds:(BOOL)includeSeconds;

/**
 Returns a string representing the time interval from now in words (including seconds).

 The strings produced by this method will be similar to produced by ActiveSupport's `time_ago_in_words` helper method.

 @return A string representing the time interval from now in words

 @see timeAgoInWordsIncludingSeconds:
 @see timeAgoInWordsFromTimeInterval:includingSeconds:
 */
- (NSString *)timeAgoInWords;

/**
 Returns a string representing the time interval from now in words.

 The strings produced by this method will be similar to produced by ActiveSupport's `time_ago_in_words` helper method.

 @param includeSeconds `YES` if seconds should be included. `NO` if they should not.

 @return A string representing the time interval from now in words

 @see timeAgoInWordsIncludingSeconds:
 @see timeAgoInWordsFromTimeInterval:includingSeconds:
 */
- (NSString *)timeAgoInWordsIncludingSeconds:(BOOL)includeSeconds;

/**
 Returns a string representing the time interval from now in words.

 The strings produced by this method will be similar to produced by Twitter for iPhone in the top right of cells.
 Internally, this does not use `timeAgoInWordsFromTimeInterval:includingSeconds:`.

 @return A string representing the time interval from now in words
 */
- (NSString *)briefTimeAgoInWords;

@end
