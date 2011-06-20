//
//  SSBordererView.h
//  SSToolkit
//
//  Created by Sam Soffes on 6/17/11.
//  Copyright 2011 Sam Soffes. All rights reserved.
//

/**
 @brief Simple UIView for drawing top and bottom borders with optional insets in a view.
 */

@interface SSBordererView : UIView {
	
@private
	
	UIColor *_topBorderColor;
	UIColor *_topInsetColor;
	UIColor *_bottomInsetColor;
	UIColor *_bottomBorderColor;
}

/**
 @brief The top border color. The default is <code>nil</code>.
 */
@property (nonatomic, retain) UIColor *topBorderColor;

/**
 @brief The top inset color. The default is <code>nil</code>.
 */
@property (nonatomic, retain) UIColor *topInsetColor;

/**
 @brief The bottom inset color. The default is <code>nil</code>.
 */
@property (nonatomic, retain) UIColor *bottomInsetColor;

/**
 @brief The bottom border color. The default is <code>nil</code>.
 */
@property (nonatomic, retain) UIColor *bottomBorderColor;

@end
