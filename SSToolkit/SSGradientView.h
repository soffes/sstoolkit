//
//  SSGradientView.h
//  SSToolkit
//
//  Created by Sam Soffes on 10/27/09.
//  Copyright 2009-2011 Sam Soffes. All rights reserved.
//

/**
 @brief Simple UIView wrapper for drawing gradients. Greatly inspired by BWGradientBox.
 
 @section known_bugs Known bugs
 
 @li <code>startColor</code> and <code>endColor</code> must be in the same colorspace. The colorspace of the first color
 is used to draw the gradient. If you did a gradient from white to blue, it would look like a gradient from white to
 black because the first color, white, is in the gray color space, not the RGB color space. If you did it from blue to
 white, it would look like blue to black because white in the gray colorspace isn't a valid color in the RGB colorspace
 (because there are only 2 components in the gray colorspace and 4 in the RGB colorspace). Automatic colorspace
 conversions are planned for the future.
 */
@interface SSGradientView : UIView {
	
@private
	
	CALayer *_topBorderLayer;
	CALayer *_topInsetLayer;
	CALayer *_bottomInsetLayer;
	CALayer *_bottomBorderLayer;
}

/**
 @brief An array of <code>UIColor</code> objects used to draw the gradient. If the value is <code>nil</code>, the
 <code>backgroundColor</code> will be drawn instead of a gradient. The default is <code>nil</code>.
 */
@property (nonatomic, copy) NSArray *colors;

/**
 @brief An optional array of NSNumber objects defining the location of each gradient stop.
 
 The gradient stops are specified as values between <code>0</code> and <code>1</code>. The values must be monotonically
 increasing. If <code>nil</code>, the stops are spread uniformly across the range. Defaults to <code>nil</code>.
 */
@property (nonatomic, copy) NSArray *locations;

/**
 @brief The top border color. The default is <code>nil</code>.
 */
@property (nonatomic, retain) UIColor *topBorderColor;

/**
 @brief The bottom border color. The default is <code>nil</code>.
 */
@property (nonatomic, retain) UIColor *bottomBorderColor;

/**
 @brief The top border inset color. The default is <code>nil</code>.
 */
@property (nonatomic, retain) UIColor *topInsetColor;

/**
 @brief The bottom border inset color. The default is <code>nil</code>.
 */
@property (nonatomic, retain) UIColor *bottomInsetColor;


#pragma mark -
#pragma mark Deprecated

/**
 @brief The scale of the gradient.
 
 The default is <code>1.0</code>. DEPRECATED.
 */
@property (nonatomic, assign) CGFloat gradientScale;

/**
 @brief The top gradient color. The default is <code>nil</code>. DEPRECATED.
 */
@property (nonatomic, retain) UIColor *topColor;

/**
 @brief The bottom gradient color. The default is <code>nil</code>. DEPRECATED.
 */
@property (nonatomic, retain) UIColor *bottomColor;

/**
 @brief The top border inset alpha. DEPRECATED.
 
 If the value is less than or equal to <code>0.0</code>, it will not be drawn. The default is <code>0.0</code>.
 */
@property (nonatomic, assign) CGFloat topInsetAlpha;

/**
 @brief The bottom border inset alpha. DEPRECATED.
 
 If the value is less than or equal to <code>0.0</code>, it will not be drawn. The default is <code>0.0</code>.
 */
@property (nonatomic, assign) CGFloat bottomInsetAlpha;

@end
