//
//  UIScrollView+scrollToTop.m
//  TWToolkit
//
//  Created by Sam Soffes on 4/12/10.
//  Copyright 2010 Tasteful Works, Inc. All rights reserved.
//

#import "UIScrollView+scrollToTop.h"

@implementation UIScrollView (scrollToTop)

- (void)scrollToTop {
	[self scrollToTopAnimated:NO];
}


- (void)scrollToTopAnimated:(BOOL)animated {
	[self setContentOffset:CGPointMake(0.0, 0.0) animated:animated];
}

@end
