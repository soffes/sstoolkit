//
//  SSStripView.m
//  Four80
//
//  Created by Sam Soffes on 8/18/08.
//  Copyright 2008 Trimonix LLC. All rights reserved.
//

#import "SSStripView.h"

@implementation SSStripView

@synthesize borderColor, startColor, endColor, borderHeight, style;

#pragma mark -
#pragma mark Init Methods
#pragma mark -

- (id)initWithFrame:(CGRect)aRect {
	if(self = [super initWithFrame:aRect]) {
		self.userInteractionEnabled = NO;

		// Defaults
		self.borderHeight = 1;
		self.style = SSStripViewStyleDefault;
		self.contentMode = UIViewContentModeTop;
	}
	return self;
}

#pragma mark -
#pragma mark Style Methods
#pragma mark -

- (void)setStyle:(SSStripViewStyle)aStyle {
	style = aStyle;
	
	if (aStyle == SSStripViewStyleBlue) {
		self.borderColor = [UIColor colorWithRed:32.0 / 255.0 green:36.0 / 255.0 blue:42.0 / 255.0 alpha:1.0];
		self.startColor = [UIColor colorWithRed:127.0 / 255.0 green:141.0 / 255.0 blue:157.0 / 255.0 alpha:1.0];
		self.endColor = [UIColor colorWithRed:66.0 / 255.0 green:80.0 / 255.0 blue:99.0 / 255.0 alpha:1.0];
		[self refreshBackground];
	} else if(aStyle == SSStripViewStyleLight) {
		self.borderColor = [UIColor colorWithRed:169.0 / 255.0 green:174.0 / 255.0 blue:183.0 / 255.0 alpha:1.0];
		self.startColor = [UIColor colorWithRed:222.0 / 255.0 green:222.0 / 255.0 blue:222.0 / 255.0 alpha:1.0];
		self.endColor = [UIColor colorWithRed:190.0 / 255.0 green:190.0 / 255.0 blue:190.0 / 255.0 alpha:1.0];
		[self refreshBackground];
	} else if (aStyle == SSStripViewStyleDark) {
		self.borderColor = [UIColor colorWithRed:50.0 / 255.0 green:50.0 / 255.0 blue:50.0 / 255.0 alpha:1.0];
		self.startColor = [UIColor colorWithRed:37.0 / 255.0 green:37.0 / 255.0 blue:37.0 / 255.0 alpha:1.0];
		self.endColor = [UIColor colorWithRed:20.0 / 255.0 green:20.0 / 255.0 blue:20.0 / 255.0 alpha:1.0];
		[self refreshBackground];
	}
}

- (void)refreshBackground {
	CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
	NSArray *colors = [NSArray arrayWithObjects:(id)startColor.CGColor, (id)endColor.CGColor, nil];
	CGGradientRelease(gradient);
	gradient = CGGradientCreateWithColors(rgb, (CFArrayRef)colors, NULL);
	CGColorSpaceRelease(rgb);

	[self setNeedsDisplay];
}
#pragma mark -
#pragma mark Drawing Methods
#pragma mark -

- (void)drawRect:(CGRect)rect {

	context = UIGraphicsGetCurrentContext();
	CGContextSaveGState(context);
	CGContextClipToRect(context, self.bounds);

	CGPoint start = CGPointMake(self.bounds.origin.x, self.bounds.origin.y);
	CGPoint end = CGPointMake(self.bounds.origin.x, self.bounds.origin.y + self.bounds.size.height);

	CGContextDrawLinearGradient(context, gradient, start, end, 0);

	CGContextSetStrokeColorWithColor(context, borderColor.CGColor);

	CGContextSetLineWidth(context, borderHeight * 2); // multiply by because half of the border is on the outside of the rect
	CGContextMoveToPoint(context, 0.0, self.bounds.size.height);
	CGContextAddLineToPoint(context, self.bounds.size.width, self.bounds.size.height);
	CGContextStrokePath(context);
}

- (void)dealloc {
	CGGradientRelease(gradient);
	[super dealloc];
}

@end
