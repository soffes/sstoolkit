//
//  UIView+fading.h
//  Four80
//
//  Created by Sam Soffes on 6/22/09.
//  Copyright 2009 Sam Soffes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (fading)

- (void)fadeOut;
- (void)fadeIn;
- (void)fadeAlphaTo:(CGFloat)value;

@end
