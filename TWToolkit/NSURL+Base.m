//
//  NSURL+Base.m
//  TWToolkit
//
//  Created by Sam Soffes on 11/17/08.
//  Copyright 2009 Tasteful Works, Inc. All rights reserved.
//

#import "NSURL+Base.h"

@implementation NSURL (OABaseAdditions)

- (NSString *)URLStringWithoutQuery  {
    return [[[self absoluteString] componentsSeparatedByString:@"?"] objectAtIndex:0];
}

@end
