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
	[topBorderColor retain];
	[_topBorderColor release];
	_topBorderColor = topBorderColor;
	
	[self setNeedsDisplay];
}


- (void)setTopInsetColor:(UIColor *)topInsetColor {
	[topInsetColor retain];
	[_topInsetColor release];
	_topInsetColor = topInsetColor;
	
	[self setNeedsDisplay];
}


- (void)setBottomInsetColor:(UIColor *)bottomInsetColor {
	[bottomInsetColor retain];
	[_bottomInsetColor release];
	_bottomInsetColor = bottomInsetColor;
	
	[self setNeedsDisplay];
}


- (void)setBottomBorderColor:(UIColor *)bottomBorderColor {
	[bottomBorderColor retain];
	[_bottomBorderColor release];
	_bottomBorderColor = bottomBorderColor;
	
	[self setNeedsDisplay];
}


#pragma mark - NSObject

- (void)dealloc {
	[_topBorderColor release];
	[_topInsetColor release];
	[_bottomInsetColor release];
	[_bottomBorderColor release];
	[super dealloc];
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
