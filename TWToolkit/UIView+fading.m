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
	[UIView beginAnimations:@"fadeout" context:nil];
	self.alpha = 0.0;
	[UIView commitAnimations];
}

- (void)fadeIn {
	[UIView beginAnimations:@"fadein" context:nil];
	self.alpha = 1.0;
	[UIView commitAnimations];
}

- (void)fadeAlphaTo:(CGFloat)value {
	[UIView beginAnimations:@"fadealpha" context:nil];
	self.alpha = value;
	[UIView commitAnimations];
}

@end
