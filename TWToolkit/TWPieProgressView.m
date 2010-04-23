//
//  TWPieProgressView.m
//  TWToolkit
//
//  Created by Sam Soffes on 4/22/10.
//  Copyright 2010 Tasteful Works, Inc. All rights reserved.
//

#import "TWPieProgressView.h"
#import "TWDrawingMacros.h"

#define kAngleOffset -90.0

@implementation TWPieProgressView

@synthesize progress = _progress;
@synthesize pieBorderWidth = _pieBorderWidth;
@synthesize pieBorderColor = _pieBorderColor;
@synthesize pieFillColor = _pieFillColor;
@synthesize pieBackgroundColor = _pieBackgroundColor;

#pragma mark -
#pragma mark NSObject
#pragma mark -

- (void)dealloc {
	self.pieBorderColor = nil;
	self.pieFillColor = nil;
	self.pieBackgroundColor = nil;
	[super dealloc];
}


#pragma mark -
#pragma mark UIView
#pragma mark -

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
	CGContextSetLineWidth(context, 1.0);
	CGPoint center = CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
	CGFloat radius = center.y;
	CGFloat angle = DEGREES_TO_RADIANS((360.0 * _progress) + kAngleOffset);
	CGPoint p[3] = {
		CGPointMake(center.x, 0.0),
		center,
		CGPointMake(center.x + radius * cos(angle), center.y + radius * sin(angle))
	};
	CGContextAddLines(context, p, sizeof(p)/sizeof(p[0]));
	CGContextAddArc(context, center.x, center.y, radius, DEGREES_TO_RADIANS(kAngleOffset), angle, false);
	CGContextDrawPath(context, kCGPathEOFill);
	
	// Border
	[_pieBorderColor set];
	CGContextSetLineWidth(context, _pieBorderWidth);
	CGRect pieInnerRect = CGRectMake(_pieBorderWidth / 2.0, _pieBorderWidth / 2.0, rect.size.width - _pieBorderWidth, rect.size.height - _pieBorderWidth);
	CGContextStrokeEllipseInRect(context, pieInnerRect);	
}


#pragma mark -
#pragma mark Setters
#pragma mark -

- (void)setProgress:(CGFloat)newProgress {
	_progress = fmax(0.0, fmin(1.0, newProgress));
	[self setNeedsDisplay];
}


#pragma mark -
#pragma mark Observer
#pragma mark -

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
	// Redraw if attributes changed
	if ([keyPath isEqualToString:@"pieBorderWidth"] || [keyPath isEqualToString:@"pieBorderColor"] || [keyPath isEqualToString:@"pieFillColor"] || [keyPath isEqualToString:@"pieBackgroundColor"]) {
		[self setNeedsDisplay];
		return;
	}
	
	[super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
}

@end
