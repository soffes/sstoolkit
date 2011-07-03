//
//  SSLineView.m
//  SSToolkit
//
//  Created by Sam Soffes on 4/12/10.
//  Copyright 2010-2011 Sam Soffes. All rights reserved.
//

#import "SSLineView.h"

@implementation SSLineView

@synthesize lineColor = _lineColor;

- (void)setLineColor:(UIColor *)lineColor {
	[_lineColor release];
	_lineColor = [lineColor retain];
	
	[self setNeedsDisplay];
}


@synthesize insetColor = _insetColor;

- (void)setInsetColor:(UIColor *)insetColor {
	[_insetColor release];
	_insetColor = [insetColor retain];
	
	[self setNeedsDisplay];
}


@synthesize dashPhase = _dashPhase;

- (void)setDashPhase:(CGFloat)dashPhase {
	_dashPhase = dashPhase;
	
	[self setNeedsDisplay];
}


@synthesize dashLengths = _dashLengths;

- (void)setDashLengths:(NSArray *)dashLengths {
	[_dashLengths release];
	_dashLengths = [dashLengths copy];
	
	[self setNeedsDisplay];
}


#pragma mark - NSObject

- (void)dealloc {
	[_lineColor release];
	[_insetColor release];
	[_dashLengths release];
	[super dealloc];
}


#pragma mark - UIView

- (id)initWithFrame:(CGRect)frame {
	if ((self = [super initWithFrame:frame])) {
		self.backgroundColor = [UIColor clearColor];
		self.opaque = NO;
		self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		
		self.lineColor = [UIColor grayColor];
		self.insetColor = [UIColor colorWithWhite:1.0f alpha:0.5f];
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

@end
