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
- (void)_refreshGradient;
@end


@implementation SSGradientView

#pragma mark -
#pragma mark Accessors

@synthesize colors = _colors;

- (void)setColors:(NSArray *)colors {
	[_colors release];
	_colors = [colors retain];
	[self _refreshGradient];
}


@synthesize locations = _locations;

- (void)setLocations:(NSArray *)locations {
	[_locations release];
	_locations = [locations retain];
	[self _refreshGradient];
}


#pragma mark -
#pragma mark Deprecated Accessors

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
		[newColors release];
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
		[newColors release];
	} else if (count == 1) {
		self.colors = [NSArray arrayWithObjects:[colors objectAtIndex:0], bottomColor, nil];
	} else {
		self.colors = [NSArray arrayWithObject:bottomColor];
	}
}


#pragma mark -
#pragma mark NSObject

- (void)dealloc {
	[_colors release];
	[_locations release];
	
	CGGradientRelease(_gradient);
	_gradient = nil;

	[super dealloc];
}


#pragma mark -
#pragma mark UIView

- (void)drawRect:(CGRect)rect {
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextClipToRect(context, rect);
	
	// Gradient
	if (_gradient) {
		CGPoint start = CGPointMake(0.0f, 0.0f);
		CGPoint end = CGPointMake(0.0f, rect.size.height);
		CGContextDrawLinearGradient(context, _gradient, start, end, 0);
	}
	
	[super drawRect:rect];
}


#pragma mark -
#pragma mark Gradient Methods

- (void)_refreshGradient {
	CGGradientRelease(_gradient);
	_gradient = SSCreateGradientWithColorsAndLocations(_colors, _locations);
	
	// Redraw
	[self setNeedsDisplay];	
}

@end
