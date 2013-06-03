//
//  SSBorderedView.h
//  SSToolkit
//
//  Created by Sam Soffes on 6/17/11.
//  Copyright 2011 Sam Soffes. All rights reserved.
//

/**
 Simple UIView for drawing top and bottom borders with optional insets in a view.
 */
@interface SSBorderedView : UIView

///--------------------------
/// @name Drawing the Borders
///--------------------------

/**
 The top border color. The default is `nil`.

 @see topInsetColor
 */
@property (nonatomic, strong) UIColor *topBorderColor;

/**
 The top inset color. The default is `nil`.

 @see topBorderColor
 */
@property (nonatomic, strong) UIColor *topInsetColor;

/**
 The right border color. The default is `nil`.

 @see rightInsetColor
 */
@property (nonatomic, strong) UIColor *rightBorderColor;

/**
 The right inset color. The default is `nil`.

 @see rightBorderColor
 */
@property (nonatomic, strong) UIColor *rightInsetColor;

/**
 The bottom border color. The default is `nil`.

 @see bottomInsetColor
 */
@property (nonatomic, strong) UIColor *bottomBorderColor;

/**
 The bottom inset color. The default is `nil`.

 @see bottomBorderColor
 */
@property (nonatomic, strong) UIColor *bottomInsetColor;

/**
 The left border color. The default is `nil`.

 @see leftInsetColor
 */
@property (nonatomic, strong) UIColor *leftBorderColor;

/**
 The left inset color. The default is `nil`.

 @see leftBorderColor
 */
@property (nonatomic, strong) UIColor *leftInsetColor;

@end
