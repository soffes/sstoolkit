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

@implementation SSPieProgressView

#pragma mark - Accessors

@synthesize progress = _progress;

- (void)setProgress:(CGFloat)newProgress {
	_progress = fmaxf(0.0f, fminf(1.0f, newProgress));
	[self setNeedsDisplay];
}


@synthesize pieBorderWidth = _pieBorderWidth;

- (void)setPieBorderWidth:(CGFloat)pieBorderWidth {
	_pieBorderWidth = pieBorderWidth;
	
	[self setNeedsDisplay];
}


@synthesize pieBorderColor = _pieBorderColor;

- (void)setPieBorderColor:(UIColor *)pieBorderColor {
	[pieBorderColor retain];
	[_pieBorderColor release];
	_pieBorderColor = pieBorderColor;
	
	[self setNeedsDisplay];
}


@synthesize pieFillColor = _pieFillColor;

- (void)setPieFillColor:(UIColor *)pieFillColor {
	[pieFillColor retain];
	[_pieFillColor release];
	_pieFillColor = pieFillColor;
	
	[self setNeedsDisplay];
}


@synthesize pieBackgroundColor = _pieBackgroundColor;

- (void)setPieBackgroundColor:(UIColor *)pieBackgroundColor {
	[pieBackgroundColor retain];
	[_pieBackgroundColor release];
	_pieBackgroundColor = pieBackgroundColor;
	
	[self setNeedsDisplay];
}


#pragma mark - Class Methods

+ (UIColor *)defaultPieColor {
	return [UIColor colorWithRed:0.612f green:0.710f blue:0.839f alpha:1.0f];
}


#pragma mark - NSObject

- (void)dealloc {
	[_pieBorderColor release];
	[_pieFillColor release];
	[_pieBackgroundColor release];
	[super dealloc];
}


#pragma mark - UIView

- (id)initWithFrame:(CGRect)aFrame {
    if ((self = [super initWithFrame:aFrame])) {
		self.backgroundColor = [UIColor clearColor];
		
		self.progress = 0.0f;
		self.pieBorderWidth = 2.0f;
		self.pieBorderColor = [[self class] defaultPieColor];
		self.pieFillColor = self.pieBorderColor;
		self.pieBackgroundColor = [UIColor whiteColor];
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextClipToRect(context, rect);
	
	// Background
	[_pieBackgroundColor set];
	CGContextFillEllipseInRect(context, rect);
	
	// Fill
	[_pieFillColor set];
	if (_progress > 0.0f) {
		CGPoint center = CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
		CGFloat radius = center.y;
		CGFloat angle = DEGREES_TO_RADIANS((360.0f * _progress) + kAngleOffset);
		CGPoint points[3] = {
			CGPointMake(center.x, 0.0f),
			center,
			CGPointMake(center.x + radius * cosf(angle), center.y + radius * sinf(angle))
		};
		CGContextAddLines(context, points, sizeof(points) / sizeof(points[0]));
		CGContextAddArc(context, center.x, center.y, radius, DEGREES_TO_RADIANS(kAngleOffset), angle, false);
		CGContextDrawPath(context, kCGPathEOFill);
	}
	
	// Border
	[_pieBorderColor set];
	CGContextSetLineWidth(context, _pieBorderWidth);
	CGRect pieInnerRect = CGRectMake(_pieBorderWidth / 2.0f, _pieBorderWidth / 2.0f, rect.size.width - _pieBorderWidth, rect.size.height - _pieBorderWidth);
	CGContextStrokeEllipseInRect(context, pieInnerRect);	
}

@end
