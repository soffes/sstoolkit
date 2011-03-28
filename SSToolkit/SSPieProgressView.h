//
//  SSPieProgressView.h
//  SSToolkit
//
//  Created by Sam Soffes on 4/22/10.
//  Copyright 2010-2011 Sam Soffes. All rights reserved.
//

/**
 @brief Pie chart style progress bar similar to the one in Xcode 3's status bar
 */
@interface SSPieProgressView : UIView {

@private
	
	CGFloat _progress;
	CGFloat _pieBorderWidth;
	UIColor *_pieBorderColor;
	UIColor *_pieFillColor;
	UIColor *_pieBackgroundColor;
}

/**
 @brief The current progress shown by the receiver.
 
 The current progress is represented by a floating-point value between 0.0 and 
 1.0f, inclusive, where 1.0 indicates the completion of the task. The default 
 value is 0.0. Values less than 0.0 and greater than 1.0 are pinned to those limits.
 */
@property (nonatomic, assign) CGFloat progress;

/**
 @brief The outer border width.
 */
@property (nonatomic, assign) CGFloat pieBorderWidth;

/**
 @brief The border color.
 */
@property (nonatomic, retain) UIColor *pieBorderColor;

/**
 @brief The fill color.
 */
@property (nonatomic, retain) UIColor *pieFillColor;

/**
 @brief The background color.
 */
@property (nonatomic, retain) UIColor *pieBackgroundColor;

@end
