//
//  UIScrollView+SSToolkitAdditions.h
//  SSToolkit
//
//  Created by Sam Soffes on 4/12/10.
//  Copyright 2010-2011 Sam Soffes. All rights reserved.
//

/**
 Provides extensions to `UIScrollView` for various common tasks.
 */
@interface UIScrollView (SSToolkitAdditions)

///----------------
/// @name Scrolling
///----------------

/**
 Scroll to the top of the receiver without animation.
 */
- (void)scrollToTop;

/**
 Scroll to the top of the receiver.
 
 @param animated `YES` to animate the transition at a constant velocity to the new offset, `NO` to make the transition immediate.
 */
- (void)scrollToTopAnimated:(BOOL)animated;

@end
