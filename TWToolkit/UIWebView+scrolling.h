//
//  UIWebView+scrolling.h
//  TWToolkit
//
//  Created by Sam Soffes on 6/22/09.
//  Copyright 2009 Tasteful Works, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWebView (scrolling)

- (UIScrollView *)scroller;
- (void)scrollRectToVisible:(CGRect)rect animated:(BOOL)animated;
- (void)scrollToTop;
- (void)setScrollingEnabled:(BOOL)enabled;

@end
