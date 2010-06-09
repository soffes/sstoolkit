//
//  NSDate+timeAgoInWords.h
//  TWToolkit
//
//  Created by Sam Soffes on 5/26/10.
//  Copyright 2010 Tasteful Works, Inc. All rights reserved.
//
//	Adapted from http://github.com/gabriel/gh-kit/blob/master/Classes/GHNSString+TimeInterval.m
//

@interface NSDate (timeAgoInWords)

- (NSString *)timeAgoInWords;
- (NSString *)timeAgoInWordsIncludingSeconds:(BOOL)includeSeconds;

@end
