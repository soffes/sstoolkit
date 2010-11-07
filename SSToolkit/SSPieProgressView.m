//
//  SSPieProgressView.m
//  SSToolkit
//
//  Created by Sam Soffes on 4/22/10.
//  Copyright 2009-2010 Sam Soffes. All rights reserved.
//

#import "SSPieProgressView.h"
#import "SSDrawingMacros.h"

#define kAngleOffset -90.0

@implementation SSPieProgressView

@synthesize progress = _progress;
@synthesize pieBorderWidth = _pieBorderWidth;
@synthesize pieBorderColor = _pieBorderColor;
@synthesize pieFillColor = _pieFillColor;
@synthesize pieBackgroundColor = _pieBackgroundColor;

#pragma mark NSObject

- (void)dealloc {
	self.pieBorderColor = nil;
	self.pieFillColor = nil;
	self.pieBackgroundColor = nil;
	[super dealloc];
}

#pragma mark UIView

- (id)initWithFrame:(CGRect)aFrame {
    if ((self = [super initWithFrame:aFrame])) {
		self.backgroundColor = [UIColor clearColor];
		
		self.progress = 0.0;
		self.pieBorderWidth = 4.0;
		self.pieBorderColor = [UIColor colorWithRed:0.612 green:0.710 blue:0.839 alpha:1.0];
		self.pieFillColor = [UIColor colorWithRed:0.612 green:0.710 blue:0.839 alpha:1.0];
		self.pieBackgroundColor = [UIColor whiteColor];
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
	if (!_hasDrawn) {
		[self addObserver:self forKeyPath:@"pieBorderWidth" options:NSKeyValueObservingOptionNew context:nil];
		[self addObserver:self forKeyPath:@"pieBorderColor" options:NSKeyValueObservingOptionNew context:nil];
		[self addObserver:self forKeyPath:@"pieFillColor" options:NSKeyValueObservingOptionNew context:nil];
		[self addObserver:self forKeyPath:@"pieBackgroundColor" options:NSKeyValueObservingOptionNew context:nil];
		_hasDrawn = YES;
	}
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextClipToRect(context, rect);
	
	// Background
	[_pieBackgroundColor set];
	CGContextFillEllipseInRect(context, rect);
	
	// Fill
	[_pieFillColor set];
	if (_progress > 0.0) {
		CGPoint center = CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
		CGFloat radius = center.y;
		CGFloat angle = DEGREES_TO_RADIANS((360.0 * _progress) + kAngleOffset);
		CGPoint points[3] = {
			CGPointMake(center.x, 0.0),
			center,
			CGPointMake(center.x + radius * cos(angle), center.y + radius * sin(angle))
		};
		CGContextAddLines(context, points, sizeof(points) / sizeof(points[0]));
		CGContextAddArc(context, center.x, center.y, radius, DEGREES_TO_RADIANS(kAngleOffset), angle, false);
		CGContextDrawPath(context, kCGPathEOFill);
	}
	
	// Border
	[_pieBorderColor set];
	CGContextSetLineWidth(context, _pieBorderWidth);
	CGRect pieInnerRect = CGRectMake(_pieBorderWidth / 2.0, _pieBorderWidth / 2.0, rect.size.width - _pieBorderWidth, rect.size.height - _pieBorderWidth);
	CGContextStrokeEllipseInRect(context, pieInnerRect);	
}

#pragma mark Setters

- (void)setProgress:(CGFloat)newProgress {
	_progress = fmax(0.0, fmin(1.0, newProgress));
	[self setNeedsDisplay];
}

#pragma mark Observer

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
	// Redraw if attributes changed
	if ([keyPath isEqualToString:@"pieBorderWidth"] || [keyPath isEqualToString:@"pieBorderColor"] || [keyPath isEqualToString:@"pieFillColor"] || [keyPath isEqualToString:@"pieBackgroundColor"]) {
		[self setNeedsDisplay];
		return;
	}
	
	[super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
}

@end
