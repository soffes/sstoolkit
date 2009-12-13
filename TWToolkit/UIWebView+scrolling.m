//
//  UIWebView+scrolling.m
//  TWToolkit
//
//  Created by Sam Soffes on 6/22/09.
//  Copyright 2009 Tasteful Works, Inc. All rights reserved.
//

#import "UIWebView+scrolling.h"

@implementation UIWebView (scrolling)

- (UIScrollView *)scroller {
	// This is actually a UIScroller not a UIScrollView
	return (UIScrollView *)[[self subviews] objectAtIndex:0];
}

@end
