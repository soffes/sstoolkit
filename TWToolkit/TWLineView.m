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
@synthesize showInset = _showInset;

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
		
		_showInset = YES;
		_hasDrawn = NO;
	}
	return self;
}

- (void)drawRect:(CGRect)rect {
	if (!_hasDrawn) {
		// Add observers
		[self addObserver:self forKeyPath:@"lineColor" options:NSKeyValueObservingOptionNew context:nil];
		[self addObserver:self forKeyPath:@"insetColor" options:NSKeyValueObservingOptionNew context:nil];		
		[self addObserver:self forKeyPath:@"showInset" options:NSKeyValueObservingOptionNew context:nil];		
		_hasDrawn = YES;
	}
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextClipToRect(context, rect);
	CGContextSetLineWidth(context, 2.0);

	// Inset
	if (self.showInset && self.insetColor) {
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
#pragma mark Observer
#pragma mark -

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
	// Redraw if colors changed
	if ([keyPath isEqualToString:@"lineColor"] || [keyPath isEqualToString:@"insetColor"] || [keyPath isEqualToString:@"showInset"]) {
		[self setNeedsDisplay];
		return;
	}
	
	[super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
}

@end
