//
//  SSBordererView.m
//  SSToolkit
//
//  Created by Sam Soffes on 6/17/11.
//  Copyright 2011 Sam Soffes. All rights reserved.
//

#import "SSBordererView.h"
#import "SSDrawingUtilities.h"

@implementation SSBordererView

#pragma mark -
#pragma mark Accessors

@synthesize topBorderColor = _topBorderColor;

- (void)setTopBorderColor:(UIColor *)topBorderColor {
	[_topBorderColor release];
	_topBorderColor = [topBorderColor retain];
	
	[self setNeedsDisplay];
}


@synthesize topInsetColor = _topInsetColor;

- (void)setTopInsetColor:(UIColor *)topInsetColor {
	[_topInsetColor release];
	_topInsetColor = [topInsetColor retain];
	
	[self setNeedsDisplay];
}


@synthesize bottomInsetColor = _bottomInsetColor;

- (void)setBottomInsetColor:(UIColor *)bottomInsetColor {
	[_bottomInsetColor release];
	_bottomInsetColor = [bottomInsetColor retain];
	
	[self setNeedsDisplay];
}


@synthesize bottomBorderColor = _bottomBorderColor;

- (void)setBottomBorderColor:(UIColor *)bottomBorderColor {
	[_bottomBorderColor release];
	_bottomBorderColor = [bottomBorderColor retain];
	
	[self setNeedsDisplay];
}


#pragma mark -
#pragma mark NSObject

- (void)dealloc {
	[_topBorderColor release];
	[_topInsetColor release];
	[_bottomInsetColor release];
	[_bottomBorderColor release];
	[super dealloc];
}


#pragma mark -
#pragma mark UIView

- (void)drawRect:(CGRect)rect {
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextClipToRect(context, rect);
		
	CGContextSetLineWidth(context, 1.0f);
	
	if (_topBorderColor) {
		// Top inset
		if (_topInsetColor) {
			CGContextSetStrokeColorWithColor(context, _topInsetColor.CGColor);
			CGContextMoveToPoint(context, 0.0f, 1.5f);
			CGContextAddLineToPoint(context, rect.size.width, 1.0f);
			CGContextStrokePath(context);
		}
		
		// Top border
		CGContextSetStrokeColorWithColor(context, _topBorderColor.CGColor);
		CGContextMoveToPoint(context, 0.0f, 0.5f);
		CGContextAddLineToPoint(context, rect.size.width, 0.0f);
		CGContextStrokePath(context);
	}
	
	if (_bottomBorderColor) {
		// Bottom inset
		if (_bottomInsetColor) {
			CGContextSetStrokeColorWithColor(context, _bottomInsetColor.CGColor);
			CGContextMoveToPoint(context, 0.0f, rect.size.height - 1.5f);
			CGContextAddLineToPoint(context, rect.size.width, rect.size.height - 1.0f);
			CGContextStrokePath(context);
		}
		
		// Bottom border
		CGContextSetStrokeColorWithColor(context, _bottomBorderColor.CGColor);
		CGContextMoveToPoint(context, 0.0f, rect.size.height - 0.5f);
		CGContextAddLineToPoint(context, rect.size.width, rect.size.height);
		CGContextStrokePath(context);
	}
}

@end
