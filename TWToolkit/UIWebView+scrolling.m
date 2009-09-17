//
//  UIWebView+scrolling.m
//  TWToolkit
//
//  Created by Sam Soffes on 6/22/09.
//  Copyright 2009 Tasteful Works, Inc. All rights reserved.
//

#import "UIWebView+scrolling.h"
#import "UIScrollView+scroller.h"

@implementation UIWebView (scrolling)

- (UIScrollView *)scroller {
	// This is actually a UIScroller not a UIScrollView
	return (UIScrollView *)[[self subviews] objectAtIndex:0];
}

- (void)scrollRectToVisible:(CGRect)rect animated:(BOOL)animated {
	[[self scroller] scrollRectToVisible:rect animated:animated];
}

- (void)scrollingEnabled:(BOOL)enabled {
	[[self scroller] setAllowsRubberBanding:enabled];
}

@end
