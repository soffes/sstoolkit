//
//  UIScrollView+SSToolkitAdditions.m
//  SSToolkit
//
//  Created by Sam Soffes on 4/12/10.
//  Copyright 2010 Sam Soffes, Inc. All rights reserved.
//

#import "UIScrollView+SSToolkitAdditions.h"

@implementation UIScrollView (SSToolkitAdditions)

- (void)scrollToTop {
	[self scrollToTopAnimated:NO];
}


- (void)scrollToTopAnimated:(BOOL)animated {
	[self setContentOffset:CGPointMake(0.0, 0.0) animated:animated];
}

@end
