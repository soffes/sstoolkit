//
//  UIScreen+SSToolkitAdditions.m
//  SSToolkit
//
//  Created by Sam Soffes on 2/4/11.
//  Copyright 2011 Sam Soffes. All rights reserved.
//

#import "UIScreen+SSToolkitAdditions.h"

@implementation UIScreen (SSToolkitAdditions)

- (CGRect)currentBounds {
	return [self boundsForOrientation:[[UIApplication sharedApplication] statusBarOrientation]];
}


- (CGRect)boundsForOrientation:(UIInterfaceOrientation)orientation {
	CGRect bounds = [self bounds];

	if (UIInterfaceOrientationIsLandscape(orientation)) {
		CGFloat buffer = bounds.size.width;

		bounds.size.width = bounds.size.height;
		bounds.size.height = buffer;
	}
	return bounds;
}

- (BOOL)isRetinaDisplay {
	static dispatch_once_t predicate;
	static BOOL answer;

	dispatch_once(&predicate, ^{
		answer = ([self respondsToSelector:@selector(scale)] && [self scale] == 2);
	});
	return answer;
}

@end
