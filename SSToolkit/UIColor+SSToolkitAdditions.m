//
//  UIColor+SSToolkitAdditions.m
//  SSToolkit
//
//  Created by Sam Soffes on 4/19/10.
//  Copyright 2010-2011 Sam Soffes. All rights reserved.
//

#import "UIColor+SSToolkitAdditions.h"

static NSUInteger integerFromHexString(NSString *string) {
	NSUInteger result = 0;
	sscanf([string UTF8String], "%x", &result);
	return result;
}

@implementation UIColor (SSToolkitAdditions)

// Adapted from https://github.com/Cocoanetics/NSAttributedString-Additions-for-HTML
+ (UIColor *)colorWithHex:(NSString *)hex {
	// Remove `#`
	if ([[hex substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"#"]) {
		hex = [hex substringFromIndex:1];
	}
	
	// Invalid if not 3, or 6 characters
	NSUInteger length = [hex length];
	if (length != 3 && length != 6) {
		return nil;
	}
		
	NSUInteger digits = length / 3;
	CGFloat maxValue = (digits == 1) ? 15.0f : 255.0f;
	
	CGFloat red = integerFromHexString([hex substringWithRange:NSMakeRange(0, digits)]) / maxValue;
	CGFloat green = integerFromHexString([hex substringWithRange:NSMakeRange(digits, digits)]) / maxValue;
	CGFloat blue = integerFromHexString([hex substringWithRange:NSMakeRange(2 * digits, digits)]) / maxValue;
		
	return [UIColor colorWithRed:red green:green blue:blue alpha:1.0f];
}


// Inspired by https://github.com/Cocoanetics/NSAttributedString-Additions-for-HTML
- (NSString *)hexValue {
	CGColorRef color = self.CGColor;
	size_t count = CGColorGetNumberOfComponents(color);
	const CGFloat *components = CGColorGetComponents(color);
	
	static NSString *stringFormat = @"%02x%02x%02x";
	
	// Grayscale
	if (count == 2) {
		NSUInteger white = (NSUInteger)(components[0] * (CGFloat)255);
		return [NSString stringWithFormat:stringFormat, white, white, white];
	}
	
	// RGB
	else if (count == 4) {
		return [NSString stringWithFormat:stringFormat, (NSUInteger)(components[0] * (CGFloat)255),
				(NSUInteger)(components[1] * (CGFloat)255), (NSUInteger)(components[2] * (CGFloat)255)];
	}
	
	// Unsupported color space
	return nil;
}


- (CGFloat)red {
	CGColorRef color = self.CGColor;
	if (CGColorSpaceGetModel(CGColorGetColorSpace(color)) != kCGColorSpaceModelRGB) {
		return -1.0f;
	}
	CGFloat const *components = CGColorGetComponents(color);
	return components[0];
}


- (CGFloat)green {
	CGColorRef color = self.CGColor;
	if (CGColorSpaceGetModel(CGColorGetColorSpace(color)) != kCGColorSpaceModelRGB) {
		return -1.0f;
	}
	CGFloat const *components = CGColorGetComponents(color);
	return components[1];
}


- (CGFloat)blue {
	CGColorRef color = self.CGColor;
	if (CGColorSpaceGetModel(CGColorGetColorSpace(color)) != kCGColorSpaceModelRGB) {
		return -1.0f;
	}
	CGFloat const *components = CGColorGetComponents(color);
	return components[2];
}


- (CGFloat)alpha {
	return CGColorGetAlpha(self.CGColor);
}

@end
