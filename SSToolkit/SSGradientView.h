//
//  SSGradientView.h
//  SSToolkit
//
//  Created by Sam Soffes on 10/27/09.
//  Copyright 2009-2010 Sam Soffes. All rights reserved.
//
//	Greatly inspired by BWGradientBox. http://brandonwalkin.com/bwtoolkit
//

/** @brief Simple UIView wrapper for CGGradient.
 
 @section known_bugs Known bugs
 
 @li startColor and endColor must be in the same colorspace. The colorspace 
 of the first color is used to draw the gradient. If you did a gradient from 
 white to blue, it would look like a gradient from white to black because the
 first color, white, is in the gray color space, not the RGB color space. 
 If you did it from blue to white, it would look like blue to black because
 white in the gray colorspace isn't a valid color in the RGB colorspace (because
 there are only 2 components in the gray colorspace and 4 in the RGB colorspace).
 Automatic colorspace conversions are planned for the future.
 */
@interface SSGradientView : UIView {
	
	UIColor *_topColor;
	UIColor *_bottomColor;
	UIColor *_topBorderColor;
	UIColor *_bottomBorderColor;
	CGFloat _topInsetAlpha;
	CGFloat _bottomInsetAlpha;	
	BOOL _hasTopBorder;
	BOOL _hasBottomBorder;
	BOOL _showsInsets;
	
@protected
	
	BOOL _hasDrawn;	
	CGGradientRef _gradient;
}

/**
 @brief The top gradient color.
 
 @see defaultTopColor
 */
@property (nonatomic, retain) UIColor *topColor;

/**
 @brief The bottom gradient color.
 
 @see defaultBottomColor
 */
@property (nonatomic, retain) UIColor *bottomColor;

/**
 @brief The top border color.
 
 @see defaultTopBorderColor
 */
@property (nonatomic, retain) UIColor *topBorderColor;

/**
 @brief The bottom border color.
 
 @see defaultBottomColor
 */
@property (nonatomic, retain) UIColor *bottomBorderColor;

/**
 @brief The top border inset alpha.
 
 If the value is less than or equal to 0.0, it will not be drawn. The
 default 0.3.
 
 @see defaultTopInsetAlpha
 */
@property (nonatomic, assign) CGFloat topInsetAlpha;

/**
 @brief The bottom border inset alpha.
 
 If the value is less than or equal to 0.0, it will not be drawn. The
 default 0.0.
 
 @see defaultBottomInsetAlpha
 */
@property (nonatomic, assign) CGFloat bottomInsetAlpha;

/**
 @brief A Boolean value that determines whether showing the top border is enabled.
 */
@property (nonatomic, assign) BOOL hasTopBorder;

/**
 @brief A Boolean value that determines whether showing the bottom border is enabled.
 */
@property (nonatomic, assign) BOOL hasBottomBorder;

/**
 @brief A Boolean value that determines whether the border insets are enabled.
 */
@property (nonatomic, assign) BOOL showsInsets;

/**
 @brief The default top gradient color.
 
 @return A color with its value set to the default top gradient color.
 */
+ (UIColor *)defaultTopColor;

/**
 @brief The default bottom gradient color.
 
 @return A color with its value set to the default bottom gradient color.
 */
+ (UIColor *)defaultBottomColor;

/**
 @brief The default top border color.
 
 @return A color with its value set to the default top border color.
 */
+ (UIColor *)defaultTopBorderColor;

/**
 @brief The default bottom border color.
 
 @return A color with its value set to the default bottom border color.
 */
+ (UIColor *)defaultBottomBorderColor;

/**
 @brief The default top inset alpha.
 
 @return The default top inset alpha.
 */
+ (CGFloat)defaultTopInsetAlpha;

/**
 @brief The default bottom inset alpha.
 
 @return The default bottom inset alpha.
 */
+ (CGFloat)defaultBottomInsetAlpha;

@end
