//
//  SSDrawingUtilities.h
//  SSToolkit
//
//  Created by Sam Soffes on 4/22/10.
//  Copyright 2010-2011 Sam Soffes. All rights reserved.
//

#ifndef SSDRAWINGUTILITIES
#define SSDRAWINGUTILITIES

/**
 A macro that converts a number from degress to radians.
 @param d number in degrees
 @returns The number converted to radians.
 */
#define DEGREES_TO_RADIANS(d) ((d) * 0.0174532925199432958f)

/**
 A macro that converts a number from radians to degrees.
 @param r number in radians
 @returns The number converted to degrees.
 */
#define RADIANS_TO_DEGREES(r) ((r) * 57.29577951308232f)

#endif

extern CGFloat SSFLimit(CGFloat f, CGFloat min, CGFloat max);

extern CGRect CGRectSetX(CGRect rect, CGFloat x);
extern CGRect CGRectSetY(CGRect rect, CGFloat y);
extern CGRect CGRectSetWidth(CGRect rect, CGFloat width);
extern CGRect CGRectSetHeight(CGRect rect, CGFloat height);
extern CGRect CGRectSetOrigin(CGRect rect, CGPoint origin);
extern CGRect CGRectSetSize(CGRect rect, CGSize size);
extern CGRect CGRectSetZeroOrigin(CGRect rect);
extern CGRect CGRectSetZeroSize(CGRect rect);
extern CGSize CGSizeAspectScaleToSize(CGSize size, CGSize toSize);
extern CGRect CGRectAddPoint(CGRect rect, CGPoint point);

extern void SSDrawRoundedRect(CGContextRef context, CGRect rect, CGFloat cornerRadius);
extern CGGradientRef SSGradientWithColors(UIColor *topColor, UIColor *bottomColor);
extern CGGradientRef SSGradientWithColorsAndLocations(UIColor *topColor, UIColor *bottomColor, CGFloat topLocation, CGFloat bottomLocation);
extern void SSDrawGradientInRect(CGContextRef context, CGGradientRef gradient, CGRect rect);
