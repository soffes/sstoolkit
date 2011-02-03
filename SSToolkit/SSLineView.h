//
//  SSLineView.h
//  SSToolkit
//
//  Created by Sam Soffes on 4/12/10.
//  Copyright 2009-2010 Sam Soffes. All rights reserved.
//

/**
 @brief Don't under estimate this class. It draws lines, but they are awesome.
 
 The recommended height is 2 points if you are using the inset and 1 if you are not.
 
 The inset is drawn under the line if showInset is set to YES.
 */
@interface SSLineView : UIView {

	UIColor *_lineColor;
	UIColor *_insetColor;
	BOOL _showInset;
}

/**
 @brief The primary color of the line.
 */
@property (nonatomic, retain) UIColor *lineColor;

/**
 @brief The color of the line inset.
 */
@property (nonatomic, retain) UIColor *insetColor;

/**
 @brief A Boolean value that determines whether showing the inset is enabled.
 */
@property (nonatomic, assign) BOOL showInset;

@end
