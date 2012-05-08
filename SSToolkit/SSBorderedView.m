//
//  SSBorderedView.m
//  SSToolkit
//
//  Created by Sam Soffes on 6/17/11.
//  Copyright 2011 Sam Soffes. All rights reserved.
//

#import "SSBorderedView.h"
#import "SSDrawingUtilities.h"

@implementation SSBorderedView

#pragma mark - Accessors

@synthesize topBorderColor = _topBorderColor;
@synthesize topInsetColor = _topInsetColor;
@synthesize bottomInsetColor = _bottomInsetColor;
@synthesize bottomBorderColor = _bottomBorderColor;


- (void)setTopBorderColor:(UIColor *)topBorderColor {
	_topBorderColor = topBorderColor;
	[self setNeedsDisplay];
}


- (void)setTopInsetColor:(UIColor *)topInsetColor {
	_topInsetColor = topInsetColor;
	[self setNeedsDisplay];
}


- (void)setBottomInsetColor:(UIColor *)bottomInsetColor {
	_bottomInsetColor = bottomInsetColor;	
	[self setNeedsDisplay];
}


- (void)setBottomBorderColor:(UIColor *)bottomBorderColor {
	_bottomBorderColor = bottomBorderColor;	
	[self setNeedsDisplay];
}


#pragma mark - UIView

- (void)drawRect:(CGRect)rect {
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextClipToRect(context, rect);
		
	CGSize size = rect.size;
	
	if (_topBorderColor) {
		// Top inset
		if (_topInsetColor) {
			CGContextSetFillColorWithColor(context, _topInsetColor.CGColor);
			CGContextFillRect(context, CGRectMake(0.0f, 1.0f, size.width, 1.0f));
		}
		
		// Top border
		CGContextSetFillColorWithColor(context, _topBorderColor.CGColor);
		CGContextFillRect(context, CGRectMake(0.0f, 0.0f, size.width, 1.0f));
	}
	
	if (_bottomBorderColor) {
		// Bottom inset
		if (_bottomInsetColor) {
			CGContextSetFillColorWithColor(context, _bottomInsetColor.CGColor);
			CGContextFillRect(context, CGRectMake(0.0f, rect.size.height - 2.0f, size.width, 1.0f));
		}
		
		// Bottom border
		CGContextSetFillColorWithColor(context, _bottomBorderColor.CGColor);
		CGContextFillRect(context, CGRectMake(0.0f, rect.size.height - 1.0f, size.width, 1.0f));
	}
}

@end
