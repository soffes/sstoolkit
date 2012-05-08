//
//  SSLineView.m
//  SSToolkit
//
//  Created by Sam Soffes on 4/12/10.
//  Copyright 2010-2011 Sam Soffes. All rights reserved.
//

#import "SSLineView.h"

@interface SSLineView ()
- (void)_initialize;
@end

@implementation SSLineView

@synthesize lineColor = _lineColor;
@synthesize insetColor = _insetColor;
@synthesize dashPhase = _dashPhase;
@synthesize dashLengths = _dashLengths;

- (void)setLineColor:(UIColor *)lineColor {
	_lineColor = lineColor;
	[self setNeedsDisplay];
}


- (void)setInsetColor:(UIColor *)insetColor {
	_insetColor = insetColor;	
	[self setNeedsDisplay];
}


- (void)setDashPhase:(CGFloat)dashPhase {
	_dashPhase = dashPhase;
	[self setNeedsDisplay];
}


- (void)setDashLengths:(NSArray *)dashLengths {
	_dashLengths = [dashLengths copy];
	[self setNeedsDisplay];
}


#pragma mark - UIView

- (id)initWithCoder:(NSCoder *)aDecoder {
	if ((self = [super initWithCoder:aDecoder])) {
		[self _initialize];
	}
	return self;
}

- (id)initWithFrame:(CGRect)frame {
	if ((self = [super initWithFrame:frame])) {
		[self _initialize];
	}
	return self;
}


- (void)drawRect:(CGRect)rect {	
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextClipToRect(context, rect);
	CGContextSetLineWidth(context, 2.0f);
	
	if (_dashLengths) {
		NSUInteger dashLengthsCount = [_dashLengths count];
		CGFloat *lengths = (CGFloat *)malloc(sizeof(CGFloat) * dashLengthsCount);
		for (NSUInteger i = 0; i < dashLengthsCount; i++) {
			lengths[i] = [[_dashLengths objectAtIndex:i] floatValue];
		}
		
		CGContextSetLineDash(context, _dashPhase, lengths, dashLengthsCount);
		
		free(lengths);
	}

	// Inset
	if (_insetColor) {
		CGContextSetStrokeColorWithColor(context, _insetColor.CGColor);
		CGContextMoveToPoint(context, 0.0f, 1.0f);
		CGContextAddLineToPoint(context, rect.size.width, 1.0f);
		CGContextStrokePath(context);
	}
	
	// Top border
	CGContextSetStrokeColorWithColor(context, _lineColor.CGColor);
	CGContextMoveToPoint(context, 0.0f, 0.0f);
	CGContextAddLineToPoint(context, rect.size.width, 0.0f);
	CGContextStrokePath(context);
}


#pragma mark - Private

- (void)_initialize {
	self.backgroundColor = [UIColor clearColor];
	self.opaque = NO;
	self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
	
	self.lineColor = [UIColor grayColor];
	self.insetColor = [UIColor colorWithWhite:1.0f alpha:0.5f];
}

@end
