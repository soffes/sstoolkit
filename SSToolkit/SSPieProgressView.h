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
 The outer border color.
 
 @see defaultPieColor
 */
@property (nonatomic, strong) UIColor *pieBorderColor;

/**
 The inner border width.

 The default is `2.0`.
 */
@property (nonatomic, assign) CGFloat pieInnerBorderWidth;

/**
 The inner border color.

 @see defaultPieColor
 */
@property (nonatomic, strong) UIColor *pieInnerBorderColor;

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
