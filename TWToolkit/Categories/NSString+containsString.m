//
//  NSString+containsString.m
//  Four80
//
//  Created by Sam Soffes on 6/22/09.
//  Copyright 2009 Sam Soffes. All rights reserved.
//

#import "NSString+containsString.h"

@implementation NSString (containsString)

- (BOOL)containsString:(NSString *)string {
	return !NSEqualRanges([self rangeOfString:string], NSMakeRange(NSNotFound, 0));
}

@end
