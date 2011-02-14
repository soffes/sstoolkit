//
//  UIColor+SSToolkitAdditions.m
//  SSToolkit
//
//  Created by Sam Soffes on 4/19/10.
//  Copyright 2009-2010 Sam Soffes. All rights reserved.
//

#import "UIColor+SSToolkitAdditions.h"

@implementation UIColor (SSToolkitAdditions)

- (CGFloat)alpha {
	return CGColorGetAlpha(self.CGColor);
}

- (UIColor*) colorFromHex:(int) hexColor
{
	float redComponent = (float)(((hexColor & 0xFF0000) >> 16)/255.0);
	float greenComponent = (float)(((hexColor & 0x00FF00) >> 8)/255.0);
	float blueComponent = (float)((hexColor & 0x0000FF)/255.0);
	
	return [UIColor colorWithRed:redComponent green:greenComponent blue:blueComponent alpha:1.0];
}

@end
