//
//  UIImage+SSToolkitAdditions.m
//  SSToolkit
//
//  Created by Sam Soffes on 11/17/09.
//  Copyright 2009-2011 Sam Soffes. All rights reserved.
//

#import "UIImage+SSToolkitAdditions.h"

@implementation UIImage (SSToolkitAdditions)

+ (UIImage *)imageNamed:(NSString *)imageName bundle:(NSString *)bundleName {
	NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
	NSString *bundlePath = [resourcePath stringByAppendingPathComponent:bundleName];
	NSString *imagePath = [bundlePath stringByAppendingPathComponent:imageName];
	return [UIImage imageWithContentsOfFile:imagePath];
}


+ (NSArray *)animationImagesWithBaseName:(NSString *)baseName start:(NSUInteger)start end:(NSUInteger)end {
	NSMutableArray *images = [[NSMutableArray alloc] initWithCapacity:(end - start) + 1];
	
	for (NSUInteger i = start; i < end; i++) {
		UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%@%04d.png", baseName, i]];
		if (image) {
			[images addObject:image];
		}
	}
	
	return [images autorelease];	
}


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
	CGFloat shortestSide = (self.size.width <= self.size.height ? self.size.width : self.size.height) * self.scale;
	return [self imageCroppedToRect:CGRectMake(0.0f, 0.0f, shortestSide, shortestSide)];
}


- (NSInteger)rightCapWidth {
	return (NSInteger)self.size.width - (self.leftCapWidth + 1);
}

@end
