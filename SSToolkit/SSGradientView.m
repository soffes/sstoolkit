//
//  SSGradientView.m
//  SSToolkit
//
//  Created by Sam Soffes on 10/27/09.
//  Copyright 2009-2011 Sam Soffes. All rights reserved.
//

#import "SSGradientView.h"
#import "SSDrawingUtilities.h"

@interface SSGradientView (PrivateMethods)

- (void)_refreshGradient;

@end


@implementation SSGradientView

#pragma mark -
#pragma mark Accessors

@synthesize topColor = _topColor;
@synthesize bottomColor = _bottomColor;
@synthesize topBorderColor = _topBorderColor;
@synthesize bottomBorderColor = _bottomBorderColor;
@synthesize topInsetAlpha = _topInsetAlpha;
@synthesize bottomInsetAlpha = _bottomInsetAlpha;
@synthesize gradientScale = _gradientScale;


#pragma mark -
#pragma mark NSObject

- (void)dealloc {
	self.topColor = nil;
	self.bottomColor = nil;
	self.topBorderColor = nil;
	self.bottomBorderColor = nil;
	[super dealloc];
}


#pragma mark -
#pragma mark UIView

- (id)initWithFrame:(CGRect)frame {
	if ((self = [super initWithFrame:frame])) {
		self.opaque = YES;
		
		// Defaults
		self.gradientScale = 1.0f;
		self.topInsetAlpha = 0.0f;
		self.bottomInsetAlpha = 0.0f;
		
		_gradient = nil;		
	}
	return self;
}


- (void)drawRect:(CGRect)rect {
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextClipToRect(context, rect);
	
	// Gradient
	if (_gradient) {
		CGPoint start = CGPointMake(0.0f, 0.0f);
		CGPoint end = CGPointMake(0.0f, rect.size.height);
		CGContextDrawLinearGradient(context, _gradient, start, end, 0);
	}
	
	CGContextSetLineWidth(context, 1.0f);
	
	if (_topBorderColor) {
		// Top inset
		if (_topInsetAlpha > 0.0f) {
			CGContextSetStrokeColorWithColor(context, [UIColor colorWithWhite:1.0f alpha:_topInsetAlpha].CGColor);
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
		if (_bottomInsetAlpha > 0.0f) {
			CGContextSetStrokeColorWithColor(context, [UIColor colorWithWhite:1.0f alpha:_bottomInsetAlpha].CGColor);
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
		[self addObserver:self forKeyPath:@"topColor" options:NSKeyValueObservingOptionNew context:nil];
		[self addObserver:self forKeyPath:@"bottomColor" options:NSKeyValueObservingOptionNew context:nil];
		[self addObserver:self forKeyPath:@"topBorderColor" options:NSKeyValueObservingOptionNew context:nil];
		[self addObserver:self forKeyPath:@"bottomBorderColor" options:NSKeyValueObservingOptionNew context:nil];
		[self addObserver:self forKeyPath:@"topInsetAlpha" options:NSKeyValueObservingOptionNew context:nil];
		[self addObserver:self forKeyPath:@"bottomInsetAlpha" options:NSKeyValueObservingOptionNew context:nil];
		[self addObserver:self forKeyPath:@"gradientScale" options:NSKeyValueObservingOptionNew context:nil];
		[self addObserver:self forKeyPath:@"hasTopBorder" options:NSKeyValueObservingOptionNew context:nil];
		[self addObserver:self forKeyPath:@"hasBottomBorder" options:NSKeyValueObservingOptionNew context:nil];
		[self addObserver:self forKeyPath:@"showsInsets" options:NSKeyValueObservingOptionNew context:nil];
		
		// Draw gradient
		[self _refreshGradient];
	} else {
		// Remove observers
		[self removeObserver:self forKeyPath:@"topColor"];
		[self removeObserver:self forKeyPath:@"bottomColor"];
		[self removeObserver:self forKeyPath:@"topBorderColor"];
		[self removeObserver:self forKeyPath:@"bottomBorderColor"];
		[self removeObserver:self forKeyPath:@"topInsetAlpha"];
		[self removeObserver:self forKeyPath:@"bottomInsetAlpha"];
		[self removeObserver:self forKeyPath:@"gradientScale"];
		[self removeObserver:self forKeyPath:@"hasTopBorder"];
		[self removeObserver:self forKeyPath:@"hasBottomBorder"];
		[self removeObserver:self forKeyPath:@"showsInsets"];
		
		// Release gradient
		CGGradientRelease(_gradient);
		_gradient = nil;
	}
}


#pragma mark -
#pragma mark Gradient Methods

- (void)_refreshGradient {
	CGGradientRelease(_gradient);
	_gradient = nil;
	
	if (_topColor && _bottomColor) {
		// Calculate locations based on scale
		CGFloat top = (1.0f - _gradientScale) / 2.0f;
		
		// Create gradient
		_gradient = SSGradientWithColorsAndLocations(_topColor, _bottomColor, top, top + _gradientScale);
	}
	
	// Redraw
	[self setNeedsDisplay];	
}


#pragma mark -
#pragma mark NSKeyValueObserving

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
	// Update the gradient and redraw if gradient colors changed
	if ([keyPath isEqualToString:@"topColor"] || [keyPath isEqualToString:@"bottomColor"] ||
		[keyPath isEqualToString:@"gradientScale"]) {
		[self _refreshGradient];
		return;
	}
	
	// Redraw if colors or borders changed
	if ([keyPath isEqualToString:@"topBorderColor"] || [keyPath isEqualToString:@"bottomBorderColor"] || 
		[keyPath isEqualToString:@"topInsetAlpha"] || [keyPath isEqualToString:@"bottomInsetAlpha"] || 
		[keyPath isEqualToString:@"hasTopBorder"] || [keyPath isEqualToString:@"hasBottomBorder"] ||
		[keyPath isEqualToString:@"showsInsets"]) {
		[self setNeedsDisplay];
		return;
	}
	
	[super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
}

@end
