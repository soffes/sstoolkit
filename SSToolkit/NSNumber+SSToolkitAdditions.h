//
//  NSNumber+SSToolkitAdditions.h
//  SSToolkit
//
//  Created by Alexander Zats on 5/22/12.
//  Copyright (c) 2012 Sam Soffes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumber (SSToolkitAdditions)

///--------------
/// @name Date from timestamp
///--------------

/**
 Creates an instance of `NSDate` using current number as timestamp.
 @return NSDate with current number as unix timestamp or `nil` if current number contains 0.
 */
- (NSDate *)dateValue;

@end
