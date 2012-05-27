//
//  UIControl+SSToolkitAdditions.h
//  SSToolkit
//
//  Created by Sam Soffes on 4/19/10.
//  Copyright 2010-2011 Sam Soffes. All rights reserved.
//

/**
 Provides extensions to `UIControl` for various common tasks.
 */
@interface UIControl (SSToolkitAdditions)

/**
 Removes all targets and actions for all events from an internal dispatch table.
 */
- (void)removeAllTargets;

/**
 Sets exclusive target for specified event, all previous targets will be removed, usefull for table cells etc
 */
- (void)setTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;

@end
