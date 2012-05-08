//
//  SSDrawingUtilities.m
//  SSToolkit
//
//  Created by Sam Soffes on 8/20/10.
//  Copyright 2010-2011 Sam Soffes. All rights reserved.
//

#import "SSDrawingUtilities.h"

CGFloat SSFLimit(CGFloat f, CGFloat min, CGFloat max) {
	return fminf(fmaxf(f, min), max);
}


CGRect CGRectSetX(CGRect rect, CGFloat x) {
	return CGRectMake(x, rect.origin.y, rect.size.width, rect.size.height);
}


CGRect CGRectSetY(CGRect rect, CGFloat y) {
	return CGRectMake(rect.origin.x, y, rect.size.width, rect.size.height);
}


CGRect CGRectSetWidth(CGRect rect, CGFloat width) {
	return CGRectMake(rect.origin.x, rect.origin.y, width, rect.size.height);
}


CGRect CGRectSetHeight(CGRect rect, CGFloat height) {
	return CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, height);
}


CGRect CGRectSetOrigin(CGRect rect, CGPoint origin) {
	return CGRectMake(origin.x, origin.y, rect.size.width, rect.size.height);
}


CGRect CGRectSetSize(CGRect rect, CGSize size) {
	return CGRectMake(rect.origin.x, rect.origin.y, size.width, size.height);
}


CGRect CGRectSetZeroOrigin(CGRect rect) {
	return CGRectMake(0.0f, 0.0f, rect.size.width, rect.size.height);
}


CGRect CGRectSetZeroSize(CGRect rect) {
	return CGRectMake(rect.origin.x, rect.origin.y, 0.0f, 0.0f);
}


CGSize CGSizeAspectScaleToSize(CGSize size, CGSize toSize) {
	// Probably a more efficient way to do this...
	CGFloat aspect = 1.0f;
	
	if (size.width > toSize.width) {
		aspect = toSize.width / size.width;
	}
	
	if (size.height > toSize.height) {
		aspect = fminf(toSize.height / size.height, aspect);
	}
	
	return CGSizeMake(size.width * aspect, size.height * aspect);
}


CGRect CGRectAddPoint(CGRect rect, CGPoint point) {
	return CGRectMake(rect.origin.x + point.x, rect.origin.y + point.y, rect.size.width, rect.size.height);
}


void SSDrawRoundedRect(CGContextRef context, CGRect rect, CGFloat cornerRadius) {
	CGPoint min = CGPointMake(CGRectGetMinX(rect), CGRectGetMinY(rect));
	CGPoint mid = CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
	CGPoint max = CGPointMake(CGRectGetMaxX(rect), CGRectGetMaxY(rect));
	
	CGContextMoveToPoint(context, min.x, mid.y);
	CGContextAddArcToPoint(context, min.x, min.y, mid.x, min.y, cornerRadius);
	CGContextAddArcToPoint(context, max.x, min.y, max.x, mid.y, cornerRadius);
	CGContextAddArcToPoint(context, max.x, max.y, mid.x, max.y, cornerRadius);
	CGContextAddArcToPoint(context, min.x, max.y, min.x, mid.y, cornerRadius);
	
	CGContextClosePath(context);
	CGContextFillPath(context);
}


CGGradientRef SSCreateGradientWithColors(NSArray *colors) {
	return SSCreateGradientWithColorsAndLocations(colors, nil);
}


CGGradientRef SSCreateGradientWithColorsAndLocations(NSArray *colors, NSArray *locations) {
	NSUInteger colorsCount = [colors count];
	if (colorsCount < 2) {
		return nil;
	}
	
	CGColorSpaceRef colorSpace = CGColorGetColorSpace([[colors objectAtIndex:0] CGColor]);
	
	CGFloat *gradientLocations = NULL;
	NSUInteger locationsCount = [locations count];
	if (locationsCount == colorsCount) {
		gradientLocations = (CGFloat *)malloc(sizeof(CGFloat) * locationsCount);
		for (NSUInteger i = 0; i < locationsCount; i++) {
			gradientLocations[i] = [[locations objectAtIndex:i] floatValue];
		}
	}
	
	NSMutableArray *gradientColors = [[NSMutableArray alloc] initWithCapacity:colorsCount];
	[colors enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop) {
		[gradientColors addObject:(id)[(UIColor *)object CGColor]];
	}];
	
	CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)gradientColors, gradientLocations);
	
	if (gradientLocations) {
		free(gradientLocations);
	}
	
	return gradient;
}


void SSDrawGradientInRect(CGContextRef context, CGGradientRef gradient, CGRect rect) {
	CGContextSaveGState(context);
	CGContextClipToRect(context, rect);
	CGPoint start = CGPointMake(rect.origin.x, rect.origin.y);
	CGPoint end = CGPointMake(rect.origin.x, rect.origin.y + rect.size.height);
	CGContextDrawLinearGradient(context, gradient, start, end, 0);
	CGContextRestoreGState(context);
}
