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

@end
