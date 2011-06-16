//
//  SSGradientView.m
//  SSToolkit
//
//  Created by Sam Soffes on 10/27/09.
//  Copyright 2009-2011 Sam Soffes. All rights reserved.
//

#import "SSGradientView.h"
#import "SSDrawingUtilities.h"
#import "UIColor+SSToolkitAdditions.h"
#import <QuartzCore/QuartzCore.h>

@interface SSGradientView ()
@property (nonatomic, retain, readonly) CAGradientLayer *gradientLayer;
@property (nonatomic, retain) CALayer *topBorderLayer;
@property (nonatomic, retain) CALayer *topInsetLayer;
@property (nonatomic, retain) CALayer *bottomInsetLayer;
@property (nonatomic, retain) CALayer *bottomBorderLayer;
@end

@implementation SSGradientView

#pragma mark -
#pragma mark Private Accessors

- (CAGradientLayer *)gradientLayer {
	return (CAGradientLayer *)self.layer;
}


@synthesize topBorderLayer;

- (CALayer *)topBorderLayer {
	if (!_topBorderLayer) {
		_topBorderLayer = [[CALayer alloc] init];
		[self.layer addSublayer:_topBorderLayer];
	}
	return _topBorderLayer;
}


@synthesize topInsetLayer;

- (CALayer *)topInsetLayer {
	if (!_topInsetLayer) {
		_topInsetLayer = [[CALayer alloc] init];
		[self.layer addSublayer:_topInsetLayer];
	}
	return _topInsetLayer;
}


@synthesize bottomInsetLayer;

- (CALayer *)bottomInsetLayer {
	if (!_bottomInsetLayer) {
		_bottomInsetLayer = [[CALayer alloc] init];
		[self.layer addSublayer:_bottomInsetLayer];
	}
	return _bottomInsetLayer;
}


@synthesize bottomBorderLayer;

- (CALayer *)bottomBorderLayer {
	if (!_bottomBorderLayer) {
		_bottomBorderLayer = [[CALayer alloc] init];
		[self.layer addSublayer:_bottomBorderLayer];
	}
	return _bottomBorderLayer;
}


#pragma mark -
#pragma mark Public Accessors


- (NSArray *)colors {
	NSArray *cgColors = self.gradientLayer.colors;
	if (!cgColors || [cgColors count] == 0) {
		return nil;
	}
	
	NSMutableArray *uiColors = [[NSMutableArray alloc] initWithCapacity:[cgColors count]];
	for (id cgColor in cgColors) {
		UIColor *uiColor = [[UIColor alloc] initWithCGColor:(CGColorRef)cgColor];
		[uiColors addObject:uiColor];
		[uiColor release];
	}
	return [uiColors autorelease];
}


- (void)setColors:(NSArray *)colors {
	NSLog(@"settings colors: %@", colors);
	
	if (!colors || [colors count] == 0) {
		self.gradientLayer.colors = nil;
		return;
	}
	
	NSMutableArray *cgColors = [[NSMutableArray alloc] initWithCapacity:[colors count]];
	for (UIColor *color in colors) {
		[cgColors addObject:(id)color.CGColor];
	}
	self.gradientLayer.colors = cgColors;
	[cgColors release];
}


- (NSArray *)locations {
	return self.gradientLayer.locations;
}


- (void)setLocations:(NSArray *)locations {
	self.gradientLayer.locations = locations;
}


- (UIColor *)topBorderColor {
	if (!_topBorderLayer) {
		return nil;
	}
	return [UIColor colorWithCGColor:_topBorderLayer.backgroundColor];
}


- (void)setTopBorderColor:(UIColor *)topBorderColor {
	self.topBorderLayer.backgroundColor = topBorderColor.CGColor;
}


- (UIColor *)topInsetColor {
	if (!_topInsetLayer) {
		return nil;
	}
	return [UIColor colorWithCGColor:_topInsetLayer.backgroundColor];
}


- (void)setTopInsetColor:(UIColor *)topInsetColor {
	self.topInsetLayer.backgroundColor = topInsetColor.CGColor;
}


- (UIColor *)bottomInsetColor {
	if (!_bottomInsetLayer) {
		return nil;
	}
	return [UIColor colorWithCGColor:_bottomInsetLayer.backgroundColor];
}


- (void)setBottomInsetColor:(UIColor *)bottomInsetColor {
	self.bottomInsetLayer.backgroundColor = bottomInsetColor.CGColor;
}


- (UIColor *)bottomBorderColor {
	if (!_bottomBorderLayer) {
		return nil;
	}
	return [UIColor colorWithCGColor:_bottomBorderLayer.backgroundColor];
}


- (void)setBottomBorderColor:(UIColor *)bottomBorderColor {
	self.bottomBorderLayer.backgroundColor = bottomBorderColor.CGColor;
}


#pragma mark -
#pragma mark Deprecated Accessors

- (CGFloat)gradientScale {
	// TODO
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


- (CGFloat)topInsetAlpha {
	return self.topBorderColor.alpha;
}


- (void)setTopInsetAlpha:(CGFloat)topInsetAlpha {
	UIColor *color = self.topBorderColor;
	if (!color) {
		self.topBorderColor = [UIColor colorWithWhite:1.0f alpha:topInsetAlpha];
	} else {
		self.topBorderColor = [color colorWithAlphaComponent:topInsetAlpha];
	}
}


- (CGFloat)bottomInsetAlpha {
	return self.bottomBorderColor.alpha;
}


- (void)setBottomInsetAlpha:(CGFloat)bottomInsetAlpha {
	UIColor *color = self.bottomBorderColor;
	if (!color) {
		self.bottomBorderColor = [UIColor colorWithWhite:1.0f alpha:bottomInsetAlpha];
	} else {
		self.bottomBorderColor = [color colorWithAlphaComponent:bottomInsetAlpha];
	}
}


#pragma mark -
#pragma mark NSObject

- (void)dealloc {
	self.topBorderLayer = nil;
	self.topInsetLayer = nil;
	self.bottomInsetLayer = nil;
	self.bottomBorderLayer = nil;
	[super dealloc];
}


#pragma mark -
#pragma mark UIView

+ (Class)layerClass {
	return [CAGradientLayer class];
}


- (id)initWithFrame:(CGRect)frame {
	if ((self = [super initWithFrame:frame])) {
		self.opaque = YES;
		self.backgroundColor = [UIColor whiteColor];
		self.layer.masksToBounds = YES;
	}
	return self;
}


- (void)layoutSubviews {
	CGSize size = self.frame.size;
	_topBorderLayer.frame = CGRectMake(0.0f, 0.0f, size.width, 1.0f);
	_topInsetLayer.frame = CGRectMake(0.0f, 1.0f, size.width, 1.0f);
	_bottomInsetLayer.frame = CGRectMake(0.0f, size.height - 2.0f, size.width, 1.0f);
	_bottomBorderLayer.frame = CGRectMake(0.0f, size.height - 1.0f, size.width, 1.0f);
}

@end
