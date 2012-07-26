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

@synthesize angleOffset = _angleOffset;
@synthesize progress = _progress;
@synthesize progressMin = _progressMin;
@synthesize progressMax = _progressMax;
@synthesize pieBorderWidth = _pieBorderWidth;
@synthesize pieBorderColor = _pieBorderColor;
@synthesize pieFillColor = _pieFillColor;
@synthesize pieBackgroundColor = _pieBackgroundColor;

- (void)setProgress:(CGFloat)newProgress {
    
    // scale the progress property to fit within our min/max values.
    // e.g. if a progress of 1.0f is given, but our max = 0.7f, then scale 1.0 -> 0.7f;
    CGFloat scaledProgress = (newProgress / ((1.0f - 0.0f) / (self.progressMax - self.progressMin))) + self.progressMin;

    _progress = fmaxf(self.progressMin, fminf(self.progressMax, scaledProgress));
    [self setNeedsDisplay];
}

- (void)setProgressMin:(CGFloat)progressMin {
    _progressMin = fmaxf(0.0f, fminf(1.0f, progressMin));
}

- (void)setProgressMax:(CGFloat)progressMax {
    _progressMax = fmaxf(0.0f, fminf(1.0f, progressMax));
}


- (void)setPieBorderWidth:(CGFloat)pieBorderWidth {
	_pieBorderWidth = pieBorderWidth;
	[self setNeedsDisplay];
}


- (void)setPieBorderColor:(UIColor *)pieBorderColor {
	_pieBorderColor = pieBorderColor;
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
	CGContextClipToRect(context, rect);
	
	// Background
	[_pieBackgroundColor set];
	CGContextFillEllipseInRect(context, rect);
	
	// Fill
	[_pieFillColor set];
	if (_progress > 0.0f) {
		CGPoint center = CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
		CGFloat radius = center.y;
		CGFloat angle = DEGREES_TO_RADIANS((360.0f * _progress) + kAngleOffset + self.angleOffset);
		CGPoint points[3] = {
			//CGPointMake(center.x, 0.0f), // top/center
			CGPointMake(center.x + radius * cosf(DEGREES_TO_RADIANS(kAngleOffset + self.angleOffset)), center.y + radius * sinf(DEGREES_TO_RADIANS(kAngleOffset + self.angleOffset))),
			center,
			CGPointMake(center.x + radius * cosf(angle), center.y + radius * sinf(angle))
		};
		CGContextAddLines(context, points, sizeof(points) / sizeof(points[0]));
		CGContextAddArc(context, center.x, center.y, radius, DEGREES_TO_RADIANS(kAngleOffset + self.angleOffset), angle, false);
		CGContextDrawPath(context, kCGPathEOFill);
	}
	
	// Border
	[_pieBorderColor set];
	CGContextSetLineWidth(context, _pieBorderWidth);
	CGRect pieInnerRect = CGRectMake(_pieBorderWidth / 2.0f, _pieBorderWidth / 2.0f, rect.size.width - _pieBorderWidth, rect.size.height - _pieBorderWidth);
	CGContextStrokeEllipseInRect(context, pieInnerRect);	
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
