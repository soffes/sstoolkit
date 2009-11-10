//
//  TWGradientView.m
//  TWToolkit
//
//  Created by Sam Soffes on 10/27/09.
//  Copyright 2009 Tasteful Works, Inc. All rights reserved.
//

#import "TWGradientView.h"

@interface TWGradientView (PrivateMethods)

- (void)_refreshGradient;

@end


@implementation TWGradientView

@synthesize topColor;
@synthesize bottomColor;
@synthesize topBorderColor;
@synthesize bottomBorderColor;
@synthesize topInsetAlpha;
@synthesize bottomInsetAlpha;	
@synthesize hasTopBorder;
@synthesize hasBottomBorder;

#pragma mark -
#pragma mark Class Methods
#pragma mark -

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


#pragma mark -
#pragma mark NSObject
#pragma mark -

- (void)dealloc {
	[self removeObserver:self forKeyPath:@"topColor"];
	[self removeObserver:self forKeyPath:@"bottomColor"];
	[self removeObserver:self forKeyPath:@"topBorderColor"];
	[self removeObserver:self forKeyPath:@"bottomBorderColor"];
	[self removeObserver:self forKeyPath:@"topInsetAlpha"];
	[self removeObserver:self forKeyPath:@"bottomInsetAlpha"];
	[self removeObserver:self forKeyPath:@"hasTopBorder"];
	[self removeObserver:self forKeyPath:@"hasBottomBorder"];
	CGGradientRelease(gradient);
	[topColor release];
	[bottomColor release];
	[topBorderColor release];
	[bottomBorderColor release];
	[super dealloc];
}


#pragma mark -
#pragma mark UIView
#pragma mark -

- (id)initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:frame]) {
		self.opaque = YES;
		self.topColor = [TWGradientView defaultTopColor];
		self.bottomColor = [TWGradientView defaultBottomColor];
		self.topBorderColor = [TWGradientView defaultTopBorderColor];
		self.bottomBorderColor = [TWGradientView defaultBottomBorderColor];
		self.topInsetAlpha = [TWGradientView defaultTopInsetAlpha];
		self.bottomInsetAlpha = [TWGradientView defaultBottomInsetAlpha];
		self.hasTopBorder = YES;
		self.hasBottomBorder = YES;
		
		// Add observers
		[self addObserver:self forKeyPath:@"topColor" options:NSKeyValueObservingOptionNew context:nil];
		[self addObserver:self forKeyPath:@"bottomColor" options:NSKeyValueObservingOptionNew context:nil];
		[self addObserver:self forKeyPath:@"topBorderColor" options:NSKeyValueObservingOptionNew context:nil];
		[self addObserver:self forKeyPath:@"bottomBorderColor" options:NSKeyValueObservingOptionNew context:nil];
		[self addObserver:self forKeyPath:@"topInsetAlpha" options:NSKeyValueObservingOptionNew context:nil];
		[self addObserver:self forKeyPath:@"bottomInsetAlpha" options:NSKeyValueObservingOptionNew context:nil];
		[self addObserver:self forKeyPath:@"hasTopBorder" options:NSKeyValueObservingOptionNew context:nil];
		[self addObserver:self forKeyPath:@"hasBottomBorder" options:NSKeyValueObservingOptionNew context:nil];
		
		// Draw gradient
		gradient = nil;
		[self _refreshGradient];
		
	}
	return self;
}


- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSaveGState(context);
	CGContextClipToRect(context, rect);
	
	// Gradient
	CGPoint start = CGPointMake(0.0, 0.0);
	CGPoint end = CGPointMake(0.0, rect.size.height);
	CGContextDrawLinearGradient(context, gradient, start, end, 0);
	
	CGContextSetLineWidth(context, 2.0);
	
	if (hasTopBorder) {
		// Top inset
		if (topInsetAlpha > 0) {
			CGContextSetStrokeColorWithColor(context, [UIColor colorWithWhite:1.0 alpha:topInsetAlpha].CGColor);
			CGContextMoveToPoint(context, 0.0, 1.0);
			CGContextAddLineToPoint(context, rect.size.width, 1.0);
			CGContextStrokePath(context);
		}
		
		// Top border
		CGContextSetStrokeColorWithColor(context, topBorderColor.CGColor);
		CGContextMoveToPoint(context, 0.0, 0.0);
		CGContextAddLineToPoint(context, rect.size.width, 0.0);
		CGContextStrokePath(context);
	}
	
	if (hasBottomBorder) {
		// Bottom inset
		if (bottomInsetAlpha > 0) {
			CGContextSetStrokeColorWithColor(context, [UIColor colorWithWhite:1.0 alpha:bottomInsetAlpha].CGColor);
			CGContextMoveToPoint(context, 0.0, rect.size.height - 1.0);
			CGContextAddLineToPoint(context, rect.size.width, rect.size.height - 1.0);
			CGContextStrokePath(context);
		}
		
		// Bottom border
		CGContextSetStrokeColorWithColor(context, bottomBorderColor.CGColor);
		CGContextMoveToPoint(context, 0.0, rect.size.height);
		CGContextAddLineToPoint(context, rect.size.width, rect.size.height);
		CGContextStrokePath(context);
	}
}


#pragma mark -
#pragma mark Gradient Methods
#pragma mark -

- (void)_refreshGradient {
	// TODO: Automatically convert colors into the same colorspace
	CGColorSpaceRef colorSpace = CGColorGetColorSpace(topColor.CGColor);
	NSArray *colors = [NSArray arrayWithObjects:(id)topColor.CGColor, (id)bottomColor.CGColor, nil];
	CGGradientRelease(gradient);
	gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)colors, NULL);
	[self setNeedsDisplay];	
}


#pragma mark -
#pragma mark Observer
#pragma mark -

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
	// Update the gradient and redraw if gradient colors changed
	if ([keyPath isEqualToString:@"topColor"] || [keyPath isEqualToString:@"bottomColor"]) {
		[self _refreshGradient];
		return;
	}
	
	// Redraw if colors or borders changed
	if ([keyPath isEqualToString:@"topBorderColor"] || [keyPath isEqualToString:@"bottomBorderColor"] || 
		[keyPath isEqualToString:@"topInsetAlpha"] || [keyPath isEqualToString:@"bottomInsetAlpha"] || 
		[keyPath isEqualToString:@"hasTopBorder"] || [keyPath isEqualToString:@"hasBottomBorder"]) {
		[self setNeedsDisplay];
		return;
	}
	
	[super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
}

@end
