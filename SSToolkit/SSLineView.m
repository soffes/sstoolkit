//
//  SSLineView.m
//  SSToolkit
//
//  Created by Sam Soffes on 4/12/10.
//  Copyright 2009-2010 Sam Soffes. All rights reserved.
//

#import "SSLineView.h"

@implementation SSLineView

@synthesize lineColor = _lineColor;
@synthesize insetColor = _insetColor;
@synthesize showInset = _showInset;

#pragma mark NSObject

- (void)dealloc {
	self.lineColor = nil;
	[super dealloc];
}


#pragma mark UIView

- (id)initWithFrame:(CGRect)frame {
	if ((self = [super initWithFrame:frame])) {
		self.backgroundColor = [UIColor clearColor];
		self.opaque = NO;
		self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		
		self.lineColor = [UIColor grayColor];
		self.insetColor = [UIColor colorWithWhite:1.0f alpha:0.5f];
		
		_showInset = YES;
	}
	return self;
}


- (void)drawRect:(CGRect)rect {	
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextClipToRect(context, rect);
	CGContextSetLineWidth(context, 2.0f);

	// Inset
	if (self.showInset && self.insetColor) {
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


- (void)willMoveToSuperview:(UIView *)newSuperview {
	if (newSuperview) {
		[self addObserver:self forKeyPath:@"lineColor" options:NSKeyValueObservingOptionNew context:nil];
		[self addObserver:self forKeyPath:@"insetColor" options:NSKeyValueObservingOptionNew context:nil];
		[self addObserver:self forKeyPath:@"showInset" options:NSKeyValueObservingOptionNew context:nil];		
	} else {
		[self removeObserver:self forKeyPath:@"lineColor"];
		[self removeObserver:self forKeyPath:@"insetColor"];
		[self removeObserver:self forKeyPath:@"showInset"];
	}
}


#pragma mark NSKeyValueObserving

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
	// Redraw if colors changed
	if ([keyPath isEqualToString:@"lineColor"] || [keyPath isEqualToString:@"insetColor"] || [keyPath isEqualToString:@"showInset"]) {
		[self setNeedsDisplay];
		return;
	}
	
	[super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
}

@end
