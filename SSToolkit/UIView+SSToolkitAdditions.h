//
//  UIView+SSToolkitAdditions.h
//  SSToolkit
//
//  Created by Sam Soffes on 2/15/10.
//  Copyright 2010-2011 Sam Soffes. All rights reserved.
//

/**
 Provides extensions to `UIView` for various common tasks.
 */
@interface UIView (SSToolkitAdditions)

///-------------------------
/// @name Taking Screenshots
///-------------------------

- (UIImage *)imageRepresentation;

///-------------------------
/// @name Hiding and Showing
///-------------------------

- (void)hide;
- (void)show;

///------------------------
/// @name Fading In and Out
///------------------------

- (void)fadeOut;
- (void)fadeOutAndPerformSelector:(SEL)selector;
- (void)fadeOutAndPerformSelector:(SEL)selector withObject:(id)object;

- (void)fadeIn;
- (void)fadeInAndPerformSelector:(SEL)selector;
- (void)fadeInAndPerformSelector:(SEL)selector withObject:(id)object;

- (void)fadeAlphaTo:(CGFloat)targetAlpha;
- (void)fadeAlphaTo:(CGFloat)targetAlpha andPerformSelector:(SEL)selector;
- (void)fadeAlphaTo:(CGFloat)targetAlpha andPerformSelector:(SEL)selector withObject:(id)object;

///----------------------------------
/// @name Managing the View Hierarchy
///----------------------------------

- (NSArray *)superviews;
- (id)firstSuperviewOfClass:(Class)superviewClass;

@end
