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
	[self fadeAlphaTo:0.0f andPerformSelector:NULL withObject:nil];
}


- (void)fadeOutAndPerformSelector:(SEL)selector {
	[self fadeAlphaTo:0.0f andPerformSelector:selector withObject:nil];
}


- (void)fadeOutAndPerformSelector:(SEL)selector withObject:(id)object {
	[self fadeAlphaTo:0.0f andPerformSelector:selector withObject:object];
}


- (void)fadeIn {
	[self fadeAlphaTo:1.0f andPerformSelector:NULL withObject:nil];
}


- (void)fadeInAndPerformSelector:(SEL)selector {
	[self fadeAlphaTo:1.0f andPerformSelector:selector withObject:nil];
}


- (void)fadeInAndPerformSelector:(SEL)selector withObject:(id)object {
	[self fadeAlphaTo:1.0f andPerformSelector:selector withObject:object];
}


- (void)fadeAlphaTo:(CGFloat)targetAlpha {
	[self fadeAlphaTo:targetAlpha andPerformSelector:NULL withObject:nil];
}


- (void)fadeAlphaTo:(CGFloat)targetAlpha andPerformSelector:(SEL)selector {
	[self fadeAlphaTo:targetAlpha andPerformSelector:selector withObject:nil];
}


- (void)fadeAlphaTo:(CGFloat)targetAlpha andPerformSelector:(SEL)selector withObject:(id)object {
	// Don't fade and perform selector if alpha is already target alpha
	if (self.alpha == targetAlpha) {
		return;
	}
	
	// Perform fade
	[UIView beginAnimations:@"fadealpha" context:nil];
	self.alpha = targetAlpha;
	[UIView commitAnimations];
	
	// Perform selector after animation
	if (selector) {
		[self performSelector:selector withObject:object afterDelay:0.21];
	}
}


- (NSArray *)superviews {
	NSMutableArray *superviews = [[NSMutableArray alloc] init];
	
	UIView *view = self;
	UIView *superview = nil;
	while (view) {
		superview = [view superview];
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
