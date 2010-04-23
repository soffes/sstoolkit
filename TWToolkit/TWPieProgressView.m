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
		self.pieBorderWidth = 2.0;
		self.pieBorderColor = [UIColor colorWithRed:0.612 green:0.710 blue:0.839 alpha:1.0];
		self.pieFillColor = [UIColor colorWithRed:0.612 green:0.710 blue:0.839 alpha:1.0];
		self.pieBackgroundColor = [UIColor whiteColor];
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
	if (!_hasDrawn) {
		// TODO: Add observers
		_hasDrawn = YES;
	}
	
	CGContextRef context = UIGraphicsGetCurrentContext();
//	CGContextClipToRect(context, rect);
	CGPoint center = CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
	
	// Background
	[_pieBackgroundColor set];
	CGContextFillEllipseInRect(context, rect);
	
	// Fill
	[_pieFillColor set];
	CGContextSetLineWidth(context, 1.0);
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
	[self setProgress:newProgress animated:YES];
}


- (void)setProgress:(CGFloat)newProgress animated:(BOOL)animated {
	_progress = fmax(0.0, fmin(1.0, newProgress));
	
	if (animated) {
		[UIView beginAnimations:@"animateProgress" context:self];
	}
	
	[self setNeedsDisplay];
	
	if (animated) {
		[UIView commitAnimations];
	}
}

@end
