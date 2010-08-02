//
//  UIControl+TWToolkitAdditions.m
//  TWToolkit
//
//  Created by Sam Soffes on 4/19/10.
//  Copyright 2010 Tasteful Works, Inc. All rights reserved.
//

#import "UIControl+TWToolkitAdditions.h"

@implementation UIControl (TWToolkitAdditions)

- (void)removeAllTargets {
	for (id target in [self allTargets]) {
		[self removeTarget:target action:NULL forControlEvents:UIControlEventAllEvents];
	}
}

@end
