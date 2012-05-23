//
//  UIControl+SSToolkitAdditions.m
//  SSToolkit
//
//  Created by Sam Soffes on 4/19/10.
//  Copyright 2010-2011 Sam Soffes. All rights reserved.
//

#import "UIControl+SSToolkitAdditions.h"

@implementation UIControl (SSToolkitAdditions)

- (void)removeAllTargets {
	[[self allTargets] enumerateObjectsUsingBlock:^(id object, BOOL *stop) {
		[self removeTarget:object action:NULL forControlEvents:UIControlEventAllEvents];
	}];
}

- (void)setTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents
{
	NSSet *targets = [self allTargets];
	[targets enumerateObjectsUsingBlock:^(id target, BOOL *stop) {
		NSArray *actions = [self actionsForTarget:target forControlEvent:controlEvents];
		[actions enumerateObjectsUsingBlock:^(NSString *action, NSUInteger idx, BOOL *stop) {
			[self removeTarget:target action:NSSelectorFromString(action) forControlEvents:controlEvents];
		}];
	}];
	[self addTarget:target action:action forControlEvents:controlEvents];
}

@end
