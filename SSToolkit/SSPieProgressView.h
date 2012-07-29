//
//  SSPieProgressView.h
//  SSToolkit
//
//  Created by Sam Soffes on 4/22/10.
//  Copyright 2010-2011 Sam Soffes. All rights reserved.
//

/**
 Pie chart style progress pie chart similar to the one in Xcode 3's status bar.
 */
@interface SSPieProgressView : UIView

///--------------------------------
///@name Configuring drawing of Pie
///--------------------------------

/**
 The angle offset from which to begin drawing the pie.
 
 This is an angle, in degrees, to offset the default starting
 point of the pie arc.
 
 Default is 0.0 (top/center).
 Negative values offset position to left, counterclockwise.
 Positive values to the right, clockwise.
 */
@property (nonatomic, assign) CGFloat angleOffset;

/**
 The minimum value represented by the pie.
 Defaults to 0.0
 */
@property (nonatomic, assign) CGFloat progressMin;

/**
 The maximum value represented by the pie.
 
 This is especially useful for when you need to show the user
 progress, but 100% does not mean a full revolution of the pie,
 but rather a partiar revolution.
 
 Setting progressMin to 0 and progressMax to 0.5 will result
 in the pie rendering a quarter-circle for a progress of 0.5 and
 a half-circle for a progress of 1
 
 Defaults to 1.0
 */
@property (nonatomic, assign) CGFloat progressMax;

///---------------------------
///@name Managing the Progress
///---------------------------

/**
 The current progress shown by the receiver.
 
 The current progress is represented by a floating-point value between `0.0` and `1.0`, inclusive, where `1.0` indicates
 the completion of the task. Values less than `0.0` and greater than `1.0` are pinned to those limits.
 
 The default value is `0.0`.
 */
@property (nonatomic, assign) CGFloat progress;

///-------------------------------------
/// @name Configuring the Pie Appearance
///-------------------------------------

/**
 The outer border width.
 
 The default is `2.0`.
 */
@property (nonatomic, assign) CGFloat pieBorderWidth;

/**
 The border color.
 
 @see defaultPieColor
 */
@property (nonatomic, strong) UIColor *pieBorderColor;

/**
 The fill color.
 
 @see defaultPieColor
 */
@property (nonatomic, strong) UIColor *pieFillColor;

/**
 The background color.
 
 The default is white.
 */
@property (nonatomic, strong) UIColor *pieBackgroundColor;


///---------------
/// @name Defaults
///---------------

/**
 The default value of `pieBorderColor` and `pieFillColor`.
 */
+ (UIColor *)defaultPieColor;

@end
