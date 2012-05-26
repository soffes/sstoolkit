//
//  SSGradientView.h
//  SSToolkit
//
//  Created by Sam Soffes on 10/27/09.
//  Copyright 2009-2011 Sam Soffes. All rights reserved.
//

#import "SSBorderedView.h"

/**
 The direction the gradient.
 */
typedef enum {
	/** The gradient is horizontal. */
	SSGradientViewDirectionHorizontal,
	
	/** The gradient is verticle. */
	SSGradientViewDirectionVertical
} SSGradientViewDirection;

/**
 Simple `UIView` wrapper for `CGGradient`.
 */
@interface SSGradientView : SSBorderedView

///---------------------------
/// @name Drawing the Gradient
///---------------------------

/**
 An array of `UIColor` objects used to draw the gradient. If the value is `nil`, the `backgroundColor` will be drawn
 instead of a gradient.
 
 The default is `nil`.
 */
@property (nonatomic, copy) NSArray *colors;

/**
 An optional array of `NSNumber` objects defining the location of each gradient stop.
 
 The gradient stops are specified as values between `0` and `1`. The values must be monotonically
 increasing. If `nil`, the stops are spread uniformly across the range. Defaults to `nil`.
 */
@property (nonatomic, copy) NSArray *locations;

/**
 The direction of the gradient.
 
 The default is `SSGradientViewDirectionVertical`.
 */
@property (nonatomic, assign) SSGradientViewDirection direction;


///-------------------------
/// @name Deprecated Methods
///-------------------------

/**
 The top gradient color. This method is deprecated.
 
 The default is `nil`.
 */
@property (nonatomic, strong) UIColor *topColor;

/**
 The bottom gradient color. This method is deprecated.
 
 The default is `nil`.
 */
@property (nonatomic, strong) UIColor *bottomColor;

/** The scale of the gradient. This method is deprecated.
 
 The default is `1.0`.
 */
@property (nonatomic, assign) CGFloat gradientScale;

@end
