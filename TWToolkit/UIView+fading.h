//
//  UIView+fading.h
//  TWToolkit
//
//  Created by Sam Soffes on 6/22/09.
//  Copyright 2009 Tasteful Works, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (fading)

- (void)hide;
- (void)show;

- (void)fadeOut;
- (void)fadeOutAndPerformSelector:(SEL)selector;
- (void)fadeOutAndPerformSelector:(SEL)selector withObject:(id)object;

- (void)fadeIn;
- (void)fadeInAndPerformSelector:(SEL)selector;
- (void)fadeInAndPerformSelector:(SEL)selector withObject:(id)object;

- (void)fadeAlphaTo:(CGFloat)targetAlpha;
- (void)fadeAlphaTo:(CGFloat)targetAlpha andPerformSelector:(SEL)selector;
- (void)fadeAlphaTo:(CGFloat)targetAlpha andPerformSelector:(SEL)selector withObject:(id)object;

@end
