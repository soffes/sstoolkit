//
//  UIView+SSToolkitAdditions.m
//  SSToolkit
//
//  Created by Sam Soffes on 2/15/10.
//  Copyright 2010-2011 Sam Soffes. All rights reserved.
//

#import "UIView+SSToolkitAdditions.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIView (SSToolkitAdditions)

- (UIImage *)imageRepresentation {
	UIGraphicsBeginImageContext(self.bounds.size);
	[self.layer renderInContext:UIGraphicsGetCurrentContext()];
	UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return image;
}


- (void)hide {
	self.alpha = 0.0f;
}


- (void)show {
	self.alpha = 1.0f;
}


- (void)fadeOut {
	UIView *view = [self retain];
	[UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
		view.alpha = 0.0f;
	} completion:nil];
	[view autorelease];
}


- (void)fadeOutAndRemoveFromSuperview {
	UIView *view = [self retain];
	[UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
		view.alpha = 0.0f;
	} completion:^(BOOL finished) {
		[view removeFromSuperview];
	}];
	[view autorelease];
}


- (void)fadeIn {
	UIView *view = [self retain];
	[UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
		view.alpha = 1.0f;
	} completion:nil];
	[view autorelease];
}


- (NSArray *)superviews {
	NSMutableArray *superviews = [[NSMutableArray alloc] init];

	UIView *view = self;
	UIView *superview = nil;
	while (view) {
		superview = [view superview];
		if (!superview) {
			break;
		}

		[superviews addObject:superview];
		view = superview;
	}

	return [superviews autorelease];
}


- (id)firstSuperviewOfClass:(Class)superviewClass {
	UIView *view = self;
	UIView *superview = nil;
	while (view) {
		superview = [view superview];
		if ([superview isKindOfClass:superviewClass]) {
			return superview;
		}
		view = superview;
	}
	return nil;
}

@end
