//
//  UIView+fading.h
//  TWToolkit
//
//  Created by Sam Soffes on 6/22/09.
//  Copyright 2009 Tasteful Works, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (fading)

- (void)fadeOut;
- (void)fadeIn;
- (void)fadeAlphaTo:(CGFloat)value;

@end
