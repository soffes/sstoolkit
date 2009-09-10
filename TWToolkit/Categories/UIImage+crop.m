//
//  UIImage+crop.m
//  Four80
//
//  Created by Sam Soffes on 8/19/09.
//  Copyright 2009 Sam Soffes. All rights reserved.
//

#import "UIImage+crop.h"

@implementation UIImage (cropToRect)

- (UIImage *)initWithImage:(UIImage *)image croppedToRect:(CGRect)rect {
	CGImageRef imageRef = CGImageCreateWithImageInRect([self CGImage], rect);
	UIImage *cropped = [[UIImage alloc] initWithCGImage:imageRef];
	CGImageRelease(imageRef);
	return cropped; // retained
}

- (UIImage *)cropToRect:(CGRect)rect {
	CGImageRef imageRef = CGImageCreateWithImageInRect([self CGImage], rect);
	UIImage *cropped = [UIImage imageWithCGImage:imageRef];
	CGImageRelease(imageRef);
	return cropped; // autoreleased
}

@end
