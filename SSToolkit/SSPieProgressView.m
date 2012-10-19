//
//  SSPieProgressView.m
//  SSToolkit
//
//  Created by Sam Soffes on 4/22/10.
//  Copyright 2010-2011 Sam Soffes. All rights reserved.
//

#import "SSPieProgressView.h"
#import "SSDrawingUtilities.h"

CGFloat const kAngleOffset = -90.0f;

@interface SSPieProgressView ()
- (void)_initialize;
@end

@implementation SSPieProgressView

#pragma mark - Accessors

@synthesize progress = _progress;
@synthesize pieBorderWidth = _pieBorderWidth;
@synthesize pieBorderColor = _pieBorderColor;
@synthesize pieInnerBorderWidth = _pieInnerBorderWidth;
@synthesize pieInnerBorderColor = _pieInnerBorderColor;
@synthesize pieFillColor = _pieFillColor;
@synthesize pieBackgroundColor = _pieBackgroundColor;

- (void)setProgress:(CGFloat)newProgress {
	_progress = fmaxf(0.0f, fminf(1.0f, newProgress));
	[self setNeedsDisplay];
}


- (void)setPieBorderWidth:(CGFloat)pieBorderWidth {
	_pieBorderWidth = pieBorderWidth;
	[self setNeedsDisplay];
}


- (void)setPieBorderColor:(UIColor *)pieBorderColor {
	_pieBorderColor = pieBorderColor;
	[self setNeedsDisplay];
}


- (void)setPieInnerBorderWidth:(CGFloat)pieInnerBorderWidth {
	_pieInnerBorderWidth = pieInnerBorderWidth;
	[self setNeedsDisplay];
}


- (void)setPieInnerBorderColor:(UIColor *)pieInnerBorderColor {
	_pieInnerBorderColor = pieInnerBorderColor;
	[self setNeedsDisplay];
}


- (void)setPieFillColor:(UIColor *)pieFillColor {
	_pieFillColor = pieFillColor;
	[self setNeedsDisplay];
}


- (void)setPieBackgroundColor:(UIColor *)pieBackgroundColor {
	_pieBackgroundColor = pieBackgroundColor;
	[self setNeedsDisplay];
}


#pragma mark - Class Methods

+ (UIColor *)defaultPieColor {
	return [UIColor colorWithRed:0.612f green:0.710f blue:0.839f alpha:1.0f];
}


#pragma mark - UIView

- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
		[self _initialize];
    }
    return self;
}


- (id)initWithFrame:(CGRect)aFrame {
    if ((self = [super initWithFrame:aFrame])) {
		[self _initialize];
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	// Background
	if (_pieBackgroundColor) {
		[_pieBackgroundColor set];
		CGContextFillEllipseInRect(context, rect);
	}

	// Math
	CGPoint center = CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
	CGFloat radius = center.y;
	CGFloat angle = DEGREES_TO_RADIANS((360.0f * _progress) + kAngleOffset);
	CGPoint points[3] = {
		CGPointMake(center.x, 0.0f),
		center,
		CGPointMake(center.x + radius * cosf(angle), center.y + radius * sinf(angle))
	};

	// Fill
	if (_pieFillColor) {
		[_pieFillColor set];
		if (_progress > 0.0f) {
			CGContextAddLines(context, points, sizeof(points) / sizeof(points[0]));
			CGContextAddArc(context, center.x, center.y, radius, DEGREES_TO_RADIANS(kAngleOffset), angle, false);
			CGContextDrawPath(context, kCGPathEOFill);
		}
	}

	// Inner Border
	if (_progress < 0.99f && _pieInnerBorderColor && _pieInnerBorderWidth > 0.0f) {
		[_pieInnerBorderColor set];
		CGContextAddLines(context, points, sizeof(points) / sizeof(points[0]));
		CGContextDrawPath(context, kCGPathStroke);
	}

	// Outer Border
	if (_pieBorderColor && _pieBorderWidth > 0.0f) {
		[_pieBorderColor set];
		CGContextSetLineWidth(context, _pieBorderWidth);
		CGRect pieInnerRect = CGRectMake(_pieBorderWidth / 2.0f, _pieBorderWidth / 2.0f, rect.size.width - _pieBorderWidth, rect.size.height - _pieBorderWidth);
		CGContextStrokeEllipseInRect(context, pieInnerRect);
	}
}


#pragma mark - Private

- (void)_initialize {
	self.backgroundColor = [UIColor clearColor];
	
	self.progress = 0.0f;
	self.pieBorderWidth = 2.0f;
	self.pieBorderColor = [[self class] defaultPieColor];
	self.pieFillColor = self.pieBorderColor;
	self.pieBackgroundColor = [UIColor whiteColor];
}

@end
