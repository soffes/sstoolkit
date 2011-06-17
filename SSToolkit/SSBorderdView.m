//
//  SSBorderdView.m
//  SSToolkit
//
//  Created by Sam Soffes on 6/17/11.
//  Copyright 2011 Sam Soffes. All rights reserved.
//

#import "SSBorderdView.h"
#import "SSDrawingUtilities.h"

@implementation SSBorderdView

#pragma mark -
#pragma mark Accessors

@synthesize topBorderColor = _topBorderColor;
@synthesize topInsetColor = _topInsetColor;
@synthesize bottomInsetColor = _bottomInsetColor;
@synthesize bottomBorderColor = _bottomBorderColor;


#pragma mark -
#pragma mark NSObject

- (void)dealloc {
	self.topBorderColor = nil;
	self.topInsetColor = nil;
	self.bottomInsetColor = nil;
	self.bottomBorderColor = nil;
	[super dealloc];
}


#pragma mark -
#pragma mark UIView

- (void)drawRect:(CGRect)rect {
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextClipToRect(context, rect);
		
	CGContextSetLineWidth(context, 1.0f);
	
	if (_topBorderColor) {
		// Top inset
		if (_topInsetColor) {
			CGContextSetStrokeColorWithColor(context, _topInsetColor.CGColor);
			CGContextMoveToPoint(context, 0.0f, 1.5f);
			CGContextAddLineToPoint(context, rect.size.width, 1.0f);
			CGContextStrokePath(context);
		}
		
		// Top border
		CGContextSetStrokeColorWithColor(context, _topBorderColor.CGColor);
		CGContextMoveToPoint(context, 0.0f, 0.5f);
		CGContextAddLineToPoint(context, rect.size.width, 0.0f);
		CGContextStrokePath(context);
	}
	
	if (_bottomBorderColor) {
		// Bottom inset
		if (_bottomInsetColor) {
			CGContextSetStrokeColorWithColor(context, _bottomInsetColor.CGColor);
			CGContextMoveToPoint(context, 0.0f, rect.size.height - 1.5f);
			CGContextAddLineToPoint(context, rect.size.width, rect.size.height - 1.0f);
			CGContextStrokePath(context);
		}
		
		// Bottom border
		CGContextSetStrokeColorWithColor(context, _bottomBorderColor.CGColor);
		CGContextMoveToPoint(context, 0.0f, rect.size.height - 0.5f);
		CGContextAddLineToPoint(context, rect.size.width, rect.size.height);
		CGContextStrokePath(context);
	}
}


- (void)willMoveToSuperview:(UIView *)newSuperview {
	if (newSuperview) {
		// Add observers
		[self addObserver:self forKeyPath:@"topBorderColor" options:NSKeyValueObservingOptionNew context:nil];
		[self addObserver:self forKeyPath:@"topInsetColor" options:NSKeyValueObservingOptionNew context:nil];
		[self addObserver:self forKeyPath:@"bottomInsetColor" options:NSKeyValueObservingOptionNew context:nil];
		[self addObserver:self forKeyPath:@"bottomBorderColor" options:NSKeyValueObservingOptionNew context:nil];
	} else {
		// Remove observers
		[self removeObserver:self forKeyPath:@"topBorderColor"];
		[self removeObserver:self forKeyPath:@"topInsetColor"];
		[self removeObserver:self forKeyPath:@"bottomInsetColor"];
		[self removeObserver:self forKeyPath:@"bottomBorderColor"];
	}
}


#pragma mark -
#pragma mark NSKeyValueObserving

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
	// Redraw if colors changed
	if ([keyPath isEqualToString:@"topBorderColor"] || [keyPath isEqualToString:@"bottomBorderColor"] || 
		[keyPath isEqualToString:@"topInsetColor"] || [keyPath isEqualToString:@"bottomInsetColor"]) {
		[self setNeedsDisplay];
		return;
	}
	
	[super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
}

@end
