//
//  UIImage+BundleImage.m
//  TWToolkit
//
//  Created by Sam Soffes on 11/17/09.
//  Copyright 2009 Tasteful Works, Inc. All rights reserved.
//

#import "UIImage+BundleImage.h"

@implementation UIImage (BundleImage)

+ (UIImage *)imageNamed:(NSString *)imageName bundle:(NSString *)bundleName {
	NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
	NSString *bundlePath = [resourcePath stringByAppendingPathComponent:bundleName];
	NSString *imagePath = [bundlePath stringByAppendingPathComponent:imageName];
	return [UIImage imageWithContentsOfFile:imagePath];
}

@end
