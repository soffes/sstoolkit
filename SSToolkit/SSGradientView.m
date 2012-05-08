//
//  SSGradientView.m
//  SSToolkit
//
//  Created by Sam Soffes on 10/27/09.
//  Copyright 2009-2011 Sam Soffes. All rights reserved.
//

#import "SSGradientView.h"
#import "SSDrawingUtilities.h"

@interface SSGradientView ()
- (void)_initialize;
- (void)_refreshGradient;
@end


@implementation SSGradientView {
	CGGradientRef _gradient;
}


#pragma mark - Accessors

@synthesize colors = _colors;
@synthesize locations = _locations;
@synthesize direction = _direction;


- (void)setColors:(NSArray *)colors {
	_colors = colors;
	[self _refreshGradient];
}


- (void)setLocations:(NSArray *)locations {
	_locations = locations;
	[self _refreshGradient];
}


- (void)setDirection:(SSGradientViewDirection)direction {
	_direction = direction;
	[self setNeedsDisplay];
}


#pragma mark - Deprecated Accessors

- (CGFloat)gradientScale {
	if ([self.locations count] == 2) {
		CGFloat top = [[self.locations objectAtIndex:0] floatValue];
		return 1.0f - (2.0f * top);
	}
		
	NSLog(@"[SSGradientView] `gradientScale` is deprecated. Using `gradientScale` with more than one location is not supported.");
	return 0.0f;	
}


- (void)setGradientScale:(CGFloat)gradientScale {
	if ([self.colors count] != 2) {
		return;
	}
	
	CGFloat top = (1.0f - gradientScale) / 2.0f;
	CGFloat bottom = top + gradientScale;
	self.locations = [NSArray arrayWithObjects:[NSNumber numberWithFloat:top], [NSNumber numberWithFloat:bottom], nil];
}


- (UIColor *)topColor {
	if ([self.colors count] >= 1) {
		return [self.colors objectAtIndex:0];
	}
	return nil;
}


- (void)setTopColor:(UIColor *)topColor {
	NSArray *colors = self.colors;
	if ([colors count] >= 1) {
		NSMutableArray *newColors = [colors mutableCopy];
		[newColors replaceObjectAtIndex:0 withObject:topColor];
		self.colors = newColors;
		return;
	}
	
	self.colors = [NSArray arrayWithObject:topColor];
}


- (UIColor *)bottomColor {
	return [self.colors lastObject];
}


- (void)setBottomColor:(UIColor *)bottomColor {
	NSArray *colors = self.colors;
	NSUInteger count = [colors count];
	if (count >= 2) {
		NSMutableArray *newColors = [colors mutableCopy];
		[newColors replaceObjectAtIndex:count - 1 withObject:bottomColor];
		self.colors = newColors;
	} else if (count == 1) {
		self.colors = [NSArray arrayWithObjects:[colors objectAtIndex:0], bottomColor, nil];
	} else {
		self.colors = [NSArray arrayWithObject:bottomColor];
	}
}


#pragma mark - NSObject

- (void)dealloc {
	CGGradientRelease(_gradient);
	_gradient = nil;
}


#pragma mark - UIView

- (id)initWithCoder:(NSCoder *)aDecoder {
	if ((self = [super initWithCoder:aDecoder])) {
		[self _initialize];
	}
	return self;
}


- (id)initWithFrame:(CGRect)frame {
	if ((self = [super initWithFrame:frame])) {
		[self _initialize];
	}
	return self;
}


- (void)drawRect:(CGRect)rect {
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextClipToRect(context, rect);
	
	// Gradient
	if (_gradient) {
		CGPoint start = CGPointMake(0.0f, 0.0f);
		CGPoint end = (_direction == SSGradientViewDirectionVertical ? CGPointMake(0.0f, rect.size.height) :
					   CGPointMake(rect.size.width, 0.0f));
		CGContextDrawLinearGradient(context, _gradient, start, end, 0);
	}
	
	[super drawRect:rect];
}


#pragma mark - Private

- (void)_initialize {
	_direction = SSGradientViewDirectionVertical;
}


- (void)_refreshGradient {
	CGGradientRelease(_gradient);
	_gradient = SSCreateGradientWithColorsAndLocations(_colors, _locations);
	
	// Redraw
	[self setNeedsDisplay];	
}

@end
