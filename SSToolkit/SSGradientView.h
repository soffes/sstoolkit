//
//  SSGradientView.h
//  SSToolkit
//
//  Created by Sam Soffes on 10/27/09.
//  Copyright 2009-2011 Sam Soffes. All rights reserved.
//
//	Greatly inspired by BWGradientBox. http://brandonwalkin.com/bwtoolkit
//

/**
 @brief Simple UIView wrapper for CGGradient.
 
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
	
	UIColor *_topColor;
	UIColor *_bottomColor;
	UIColor *_topBorderColor;
	UIColor *_bottomBorderColor;
	CGFloat _topInsetAlpha;
	CGFloat _bottomInsetAlpha;
	CGFloat _gradientScale;
	
	CGGradientRef _gradient;
}

/**
 @brief The top gradient color. The default is <code>nil</code>.
 */
@property (nonatomic, retain) UIColor *topColor;

/**
 @brief The bottom gradient color. The default is <code>nil</code>.
 */
@property (nonatomic, retain) UIColor *bottomColor;

/**
 @brief The top border color. The default is <code>nil</code>.
 */
@property (nonatomic, retain) UIColor *topBorderColor;

/**
 @brief The bottom border color. The default is <code>nil</code>.
 */
@property (nonatomic, retain) UIColor *bottomBorderColor;

/**
 @brief The top border inset alpha.
 
 If the value is less than or equal to <code>0.0</code>, it will not be drawn. The default is <code>0.0</code>.
 
 @see defaultTopInsetAlpha
 */
@property (nonatomic, assign) CGFloat topInsetAlpha;

/**
 @brief The bottom border inset alpha.
 
 If the value is less than or equal to <code>0.0</code>, it will not be drawn. The default is <code>0.0</code>.
 */
@property (nonatomic, assign) CGFloat bottomInsetAlpha;

/**
 @brief The scale of the gradient.
 
 The default is <code>1.0</code>.
 */
@property (nonatomic, assign) CGFloat gradientScale;

@end
