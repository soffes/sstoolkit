//
//  NSBundle+SSToolkitAdditions.m
//  SSToolkit
//
//  Created by Sam Soffes on 3/22/12.
//  Copyright (c) 2012 Sam Soffes. All rights reserved.
//

#import "NSBundle+SSToolkitAdditions.h"

@implementation NSBundle (SSToolkitAdditions)

+ (NSBundle *)ssToolkitBundle {
	static NSBundle *ssToolkitBundle = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		NSString *bundlePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"SSToolkitResources.bundle"];
		ssToolkitBundle = [[NSBundle alloc] initWithPath:bundlePath];
	});
	return ssToolkitBundle;
}

@end
