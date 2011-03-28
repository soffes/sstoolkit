//
//  UIColor+SSToolkitAdditions.m
//  SSToolkit
//
//  Created by Sam Soffes on 4/19/10.
//  Copyright 2010-2011 Sam Soffes. All rights reserved.
//

#import "UIColor+SSToolkitAdditions.h"

@implementation UIColor (SSToolkitAdditions)

- (CGFloat)alpha {
	return CGColorGetAlpha(self.CGColor);
}

@end
