//
//  NSDate+TWToolkitAdditions.h
//  TWToolkit
//
//  Created by Sam Soffes on 5/26/10.
//  Copyright 2010 Tasteful Works, Inc. All rights reserved.
//

@interface NSDate (TWToolkitAdditions)

+ (NSDate *)dateFromISO8601String:(NSString *)string;
- (NSString *)ISO8601String;

//	Adapted from http://github.com/gabriel/gh-kit/blob/master/Classes/GHNSString+TimeInterval.m
- (NSString *)timeAgoInWords;
- (NSString *)timeAgoInWordsIncludingSeconds:(BOOL)includeSeconds;

@end
