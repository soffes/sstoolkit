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
		
		self.progress = 0.0f;
		self.pieBorderWidth = 2.0f;
		self.pieBorderColor = [UIColor colorWithRed:0.612f green:0.710f blue:0.839f alpha:1.0f];
		self.pieFillColor = [UIColor colorWithRed:0.612f green:0.710f blue:0.839f alpha:1.0f];
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


- (void)willMoveToSuperview:(UIView *)newSuperview {
	if (newSuperview) {
		[self addObserver:self forKeyPath:@"pieBorderWidth" options:NSKeyValueObservingOptionNew context:nil];
		[self addObserver:self forKeyPath:@"pieBorderColor" options:NSKeyValueObservingOptionNew context:nil];
		[self addObserver:self forKeyPath:@"pieFillColor" options:NSKeyValueObservingOptionNew context:nil];
		[self addObserver:self forKeyPath:@"pieBackgroundColor" options:NSKeyValueObservingOptionNew context:nil];
	} else {
		[self removeObserver:self forKeyPath:@"pieBorderWidth"];
		[self removeObserver:self forKeyPath:@"pieBorderColor"];
		[self removeObserver:self forKeyPath:@"pieFillColor"];
		[self removeObserver:self forKeyPath:@"pieBackgroundColor"];
	}
}


#pragma mark Setters

- (void)setProgress:(CGFloat)newProgress {
	_progress = fmaxf(0.0f, fminf(1.0f, newProgress));
	[self setNeedsDisplay];
}


#pragma mark NSKeyValueObserving

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
	// Redraw if attributes changed
	if ([keyPath isEqualToString:@"pieBorderWidth"] || [keyPath isEqualToString:@"pieBorderColor"] || [keyPath isEqualToString:@"pieFillColor"] || [keyPath isEqualToString:@"pieBackgroundColor"]) {
		[self setNeedsDisplay];
		return;
	}
	
	[super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
}

@end
