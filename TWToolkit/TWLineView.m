//
//  TWLineView.m
//  TWToolkit
//
//  Created by Sam Soffes on 4/12/10.
//  Copyright 2010 Tasteful Works, Inc. All rights reserved.
//

#import "TWLineView.h"

@implementation TWLineView

@synthesize lineColor = _lineColor;
@synthesize insetColor = _insetColor;

#pragma mark -
#pragma mark NSObject
#pragma mark -

- (void)dealloc {
	self.lineColor = nil;
	[super dealloc];
}


#pragma mark -
#pragma mark UIView
#pragma mark -

- (id)initWithFrame:(CGRect)frame {
	if ((self = [super initWithFrame:frame])) {
		self.backgroundColor = [UIColor clearColor];
		self.opaque = NO;
		self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		
		self.lineColor = [UIColor grayColor];
		self.insetColor = [UIColor colorWithWhite:1.0 alpha:0.5];
		
		_hasDrawn = NO;
	}
	return self;
}

- (void)drawRect:(CGRect)rect {
	if (!_hasDrawn) {
		// Add observers
		[self addObserver:self forKeyPath:@"lineColor" options:NSKeyValueObservingOptionNew context:nil];
		[self addObserver:self forKeyPath:@"insetAlpha" options:NSKeyValueObservingOptionNew context:nil];		
		_hasDrawn = YES;
	}
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSaveGState(context);
	CGContextClipToRect(context, rect);
	CGContextSetLineWidth(context, 2.0);

	// Inset
	if (self.insetColor && self.insetAlpha > 0.0) {
		CGContextSetStrokeColorWithColor(context, _insetColor.CGColor);
		CGContextMoveToPoint(context, 0.0, 1.0);
		CGContextAddLineToPoint(context, rect.size.width, 1.0);
		CGContextStrokePath(context);
	}
	
	// Top border
	CGContextSetStrokeColorWithColor(context, _lineColor.CGColor);
	CGContextMoveToPoint(context, 0.0, 0.0);
	CGContextAddLineToPoint(context, rect.size.width, 0.0);
	CGContextStrokePath(context);
}


#pragma mark -
#pragma mark Getters
#pragma mark -

- (CGFloat)insetAlpha {
	return CGColorGetAlpha(_insetColor.CGColor);
}


#pragma mark -
#pragma mark Setters
#pragma mark -

- (void)setInsetAlpha:(CGFloat)alpha {
	CGColorRef cgColor = CGColorCreateCopyWithAlpha(_insetColor.CGColor, alpha);
	self.insetColor = [UIColor colorWithCGColor:cgColor];
	CGColorRelease(cgColor);
	[self setNeedsDisplay];
}


#pragma mark -
#pragma mark Observer
#pragma mark -

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
	// Redraw if colors changed
	if ([keyPath isEqualToString:@"lineColor"] || [keyPath isEqualToString:@"insetAlpha"]) {
		[self setNeedsDisplay];
		return;
	}
	
	[super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
}

@end
