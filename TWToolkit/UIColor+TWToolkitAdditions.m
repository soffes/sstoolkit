//
//  UIColor+TWToolkitAdditions.m
//  TWToolkit
//
//  Created by Sam Soffes on 4/19/10.
//  Copyright 2010 Tasteful Works, Inc. All rights reserved.
//

#import "UIColor+TWToolkitAdditions.h"

@implementation UIColor (TWToolkitAdditions)

- (CGFloat)alpha {
	return CGColorGetAlpha(self.CGColor);
}

@end
