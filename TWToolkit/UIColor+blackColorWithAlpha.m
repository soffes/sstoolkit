//
//  UIColor+blackColorWithAlpha.m
//  TWToolkit
//
//  Created by Sam Soffes on 7/22/09.
//  Copyright 2009 Sam Soffes. All rights reserved.
//

#import "UIColor+blackColorWithAlpha.h"

@implementation UIColor (blackColorWithAlpha)

+ (UIColor *)blackColorWithAlpha:(CGFloat)alpha {
	return [[[UIColor alloc] initWithRed:0.0 green:0.0 blue:0.0 alpha:alpha] autorelease];
}

@end
