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

- (void)setTopBorderColor:(UIColor *)topBorderColor {
	_topBorderColor = topBorderColor;
	[self setNeedsDisplay];
}


- (void)setTopInsetColor:(UIColor *)topInsetColor {
	_topInsetColor = topInsetColor;
	[self setNeedsDisplay];
}


- (void)setRightBorderColor:(UIColor *)rightBorderColor {
	_rightBorderColor = rightBorderColor;
	[self setNeedsDisplay];
}


- (void)setRightInsetColor:(UIColor *)rightInsetColor {
	_rightInsetColor = rightInsetColor;
	[self setNeedsDisplay];
}


- (void)setBottomBorderColor:(UIColor *)bottomBorderColor {
	_bottomBorderColor = bottomBorderColor;
	[self setNeedsDisplay];
}


- (void)setBottomInsetColor:(UIColor *)bottomInsetColor {
	_bottomInsetColor = bottomInsetColor;
	[self setNeedsDisplay];
}


- (void)setLeftBorderColor:(UIColor *)leftBorderColor {
	_leftBorderColor = leftBorderColor;
	[self setNeedsDisplay];
}


- (void)setLeftInsetColor:(UIColor *)leftInsetColor {
	_leftInsetColor = leftInsetColor;
	[self setNeedsDisplay];
}


#pragma mark - UIView

- (id)initWithFrame:(CGRect)frame {
	if ((self = [super initWithFrame:frame])) {
		self.contentMode = UIViewContentModeRedraw;
	}
	return self;
}


- (void)drawRect:(CGRect)rect {
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextClipToRect(context, rect);

	CGSize size = rect.size;

	// Top
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

	CGFloat sideY = _topBorderColor ? 1.0f : 0.0f;
	CGFloat sideHeight = size.height;
	if (_topBorderColor) {
		sideHeight -= 1.0f;
	}

	if (_bottomBorderColor) {
		sideHeight -= 1.0f;
	}

	// Right
	if (_rightBorderColor) {
		// Right inset
		if (_rightInsetColor) {
			CGContextSetFillColorWithColor(context, _rightInsetColor.CGColor);
			CGContextFillRect(context, CGRectMake(size.width - 2.0f, sideY, 1.0f, sideHeight));
		}

		// Right border
		CGContextSetFillColorWithColor(context, _rightBorderColor.CGColor);
		CGContextFillRect(context, CGRectMake(size.width - 1.0f, sideY, 1.0f, sideHeight));
	}

	// Bottom
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

	// Left
	if (_leftBorderColor) {
		// Left inset
		if (_leftInsetColor) {
			CGContextSetFillColorWithColor(context, _leftInsetColor.CGColor);
			CGContextFillRect(context, CGRectMake(1.0f, sideY, 1.0f, sideHeight));
		}

		// Left border
		CGContextSetFillColorWithColor(context, _leftBorderColor.CGColor);
		CGContextFillRect(context, CGRectMake(0.0f, sideY, 1.0f, sideHeight));
	}
}

@end
