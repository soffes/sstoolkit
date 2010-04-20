//
//  UIImage+crop.m
//  TWToolkit
//
//  Created by Sam Soffes on 8/19/09.
//  Copyright 2009 Tasteful Works, Inc. All rights reserved.
//

#import "UIImage+crop.h"

@implementation UIImage (cropToRect)

- (UIImage *)initWithImage:(UIImage *)image croppedToRect:(CGRect)rect {
	CGImageRef imageRef = CGImageCreateWithImageInRect([self CGImage], rect);
	UIImage *cropped = [[UIImage alloc] initWithCGImage:imageRef];
	CGImageRelease(imageRef);
	return cropped; // retained
}


- (UIImage *)imageCroppedToRect:(CGRect)rect {
	CGImageRef imageRef = CGImageCreateWithImageInRect([self CGImage], rect);
	UIImage *cropped = [UIImage imageWithCGImage:imageRef];
	CGImageRelease(imageRef);
	return cropped; // autoreleased
}


- (UIImage *)squareImage {
	CGFloat shortestSide = self.size.width <= self.size.height ? self.size.width : self.size.height;	
	return [self imageCroppedToRect:CGRectMake(0.0, 0.0, shortestSide, shortestSide)];
}

@end
