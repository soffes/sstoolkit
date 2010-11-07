//
//  SSGradientView.m
//  SSToolkit
//
//  Created by Sam Soffes on 10/27/09.
//  Copyright 2009-2010 Sam Soffes. All rights reserved.
//

#import "SSGradientView.h"

@interface SSGradientView (PrivateMethods)

- (void)_refreshGradient;

@end


@implementation SSGradientView

@synthesize topColor = _topColor;
@synthesize bottomColor = _bottomColor;
@synthesize topBorderColor = _topBorderColor;
@synthesize bottomBorderColor = _bottomBorderColor;
@synthesize topInsetAlpha = _topInsetAlpha;
@synthesize bottomInsetAlpha = _bottomInsetAlpha;	
@synthesize hasTopBorder = _hasTopBorder;
@synthesize hasBottomBorder = _hasBottomBorder;
@synthesize showsInsets = _showsInsets;

#pragma mark Class Methods

+ (UIColor *)defaultTopColor {
	return [UIColor colorWithRed:0.676 green:0.722 blue:0.765 alpha:1.0];
}


+ (UIColor *)defaultBottomColor {
	return [UIColor colorWithRed:0.514 green:0.568 blue:0.617 alpha:1.0];
}


+ (UIColor *)defaultTopBorderColor {
	return [UIColor colorWithRed:0.558 green:0.599 blue:0.643 alpha:1.0];
}


+ (UIColor *)defaultBottomBorderColor {
	return [UIColor colorWithRed:0.428 green:0.479 blue:0.520 alpha:1.0];
}


+ (CGFloat)defaultTopInsetAlpha {
	return 0.3;
}


+ (CGFloat)defaultBottomInsetAlpha {
	return 0.0;
}

#pragma mark NSObject

- (void)dealloc {
	if (_hasDrawn) {
		[self removeObserver:self forKeyPath:@"topColor"];
		[self removeObserver:self forKeyPath:@"bottomColor"];
		[self removeObserver:self forKeyPath:@"topBorderColor"];
		[self removeObserver:self forKeyPath:@"bottomBorderColor"];
		[self removeObserver:self forKeyPath:@"topInsetAlpha"];
		[self removeObserver:self forKeyPath:@"bottomInsetAlpha"];
		[self removeObserver:self forKeyPath:@"hasTopBorder"];
		[self removeObserver:self forKeyPath:@"hasBottomBorder"];
		[self removeObserver:self forKeyPath:@"showsInsets"];
		CGGradientRelease(_gradient);
	}
	self.topColor = nil;
	self.bottomColor = nil;
	self.topBorderColor = nil;
	self.bottomBorderColor = nil;
	[super dealloc];
}

#pragma mark UIView

- (id)initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:frame]) {
		self.opaque = YES;
		
		// Defaults
		self.topColor = [SSGradientView defaultTopColor];
		self.bottomColor = [SSGradientView defaultBottomColor];
		self.topBorderColor = [SSGradientView defaultTopBorderColor];
		self.bottomBorderColor = [SSGradientView defaultBottomBorderColor];
		self.topInsetAlpha = [SSGradientView defaultTopInsetAlpha];
		self.bottomInsetAlpha = [SSGradientView defaultBottomInsetAlpha];
		self.hasTopBorder = YES;
		self.hasBottomBorder = YES;
		self.showsInsets = YES;
		
		_hasDrawn = NO;
		_gradient = nil;		
	}
	return self;
}


- (void)drawRect:(CGRect)rect {
	if (!_hasDrawn) {
		// Add observers
		[self addObserver:self forKeyPath:@"topColor" options:NSKeyValueObservingOptionNew context:nil];
		[self addObserver:self forKeyPath:@"bottomColor" options:NSKeyValueObservingOptionNew context:nil];
		[self addObserver:self forKeyPath:@"topBorderColor" options:NSKeyValueObservingOptionNew context:nil];
		[self addObserver:self forKeyPath:@"bottomBorderColor" options:NSKeyValueObservingOptionNew context:nil];
		[self addObserver:self forKeyPath:@"topInsetAlpha" options:NSKeyValueObservingOptionNew context:nil];
		[self addObserver:self forKeyPath:@"bottomInsetAlpha" options:NSKeyValueObservingOptionNew context:nil];
		[self addObserver:self forKeyPath:@"hasTopBorder" options:NSKeyValueObservingOptionNew context:nil];
		[self addObserver:self forKeyPath:@"hasBottomBorder" options:NSKeyValueObservingOptionNew context:nil];
		[self addObserver:self forKeyPath:@"showsInsets" options:NSKeyValueObservingOptionNew context:nil];
		
		// Draw gradient
		[self _refreshGradient];
		
		_hasDrawn = YES;
	}
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextClipToRect(context, rect);
	
	// Gradient
	CGPoint start = CGPointMake(0.0, 0.0);
	CGPoint end = CGPointMake(0.0, rect.size.height);
	CGContextDrawLinearGradient(context, _gradient, start, end, 0);
	
	CGContextSetLineWidth(context, 2.0);
	
	if (_hasTopBorder) {
		// Top inset
		if (_showsInsets && _topInsetAlpha > 0.0) {
			CGContextSetStrokeColorWithColor(context, [UIColor colorWithWhite:1.0 alpha:_topInsetAlpha].CGColor);
			CGContextMoveToPoint(context, 0.0, 1.0);
			CGContextAddLineToPoint(context, rect.size.width, 1.0);
			CGContextStrokePath(context);
		}
		
		// Top border
		CGContextSetStrokeColorWithColor(context, _topBorderColor.CGColor);
		CGContextMoveToPoint(context, 0.0, 0.0);
		CGContextAddLineToPoint(context, rect.size.width, 0.0);
		CGContextStrokePath(context);
	}
	
	if (_hasBottomBorder) {
		// Bottom inset
		if (_showsInsets && _bottomInsetAlpha > 0.0) {
			CGContextSetStrokeColorWithColor(context, [UIColor colorWithWhite:1.0 alpha:_bottomInsetAlpha].CGColor);
			CGContextMoveToPoint(context, 0.0, rect.size.height - 1.0);
			CGContextAddLineToPoint(context, rect.size.width, rect.size.height - 1.0);
			CGContextStrokePath(context);
		}
		
		// Bottom border
		CGContextSetStrokeColorWithColor(context, _bottomBorderColor.CGColor);
		CGContextMoveToPoint(context, 0.0, rect.size.height);
		CGContextAddLineToPoint(context, rect.size.width, rect.size.height);
		CGContextStrokePath(context);
	}
}

#pragma mark Gradient Methods

- (void)_refreshGradient {
	// TODO: Automatically convert colors into the same colorspace
	CGColorSpaceRef colorSpace = CGColorGetColorSpace(_topColor.CGColor);
	NSArray *colors = [NSArray arrayWithObjects:(id)_topColor.CGColor, (id)_bottomColor.CGColor, nil];
	CGGradientRelease(_gradient);
	_gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)colors, NULL);
	[self setNeedsDisplay];	
}

#pragma mark Observer

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
	// Update the gradient and redraw if gradient colors changed
	if ([keyPath isEqualToString:@"topColor"] || [keyPath isEqualToString:@"bottomColor"]) {
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
