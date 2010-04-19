//
//  UIView+fading.m
//  TWToolkit
//
//  Created by Sam Soffes on 6/22/09.
//  Copyright 2009 Tasteful Works, Inc. All rights reserved.
//

#import "UIView+fading.h"

@implementation UIView (fading)

- (void)fadeOut {
	[self fadeAlphaTo:0.0 andPerformSelector:NULL withObject:nil];
}


- (void)fadeOutAndPerformSelector:(SEL)selector {
	[self fadeAlphaTo:0.0 andPerformSelector:selector withObject:nil];
}


- (void)fadeOutAndPerformSelector:(SEL)selector withObject:(id)object {
	[self fadeAlphaTo:0.0 andPerformSelector:selector withObject:object];
}


- (void)fadeIn {
	[self fadeAlphaTo:1.0 andPerformSelector:NULL withObject:nil];
}


- (void)fadeInAndPerformSelector:(SEL)selector {
	[self fadeAlphaTo:1.0 andPerformSelector:selector withObject:nil];
}


- (void)fadeInAndPerformSelector:(SEL)selector withObject:(id)object {
	[self fadeAlphaTo:1.0 andPerformSelector:selector withObject:object];
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

@end
