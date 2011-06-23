//
//  SSLineView.h
//  SSToolkit
//
//  Created by Sam Soffes on 4/12/10.
//  Copyright 2010-2011 Sam Soffes. All rights reserved.
//

/**
 @brief Don't under estimate this class. It draws lines, but they are awesome.
 
 The recommended height is 2 points if you are using the inset and 1 if you are not.
 
 The inset is drawn under the line if showInset is set to YES.
 */
@interface SSLineView : UIView {

@private
	
	UIColor *_lineColor;
	UIColor *_insetColor;
	BOOL _showInset;
	NSArray *_dashLengths;
}

/**
 @brief The primary color of the line.
 */
@property (nonatomic, retain) UIColor *lineColor;

/**
 @brief The color of the line inset. The default is 50% opaque white.
 */
@property (nonatomic, retain) UIColor *insetColor;

/**
 @brief A Boolean value that determines whether showing the inset is enabled. The default is <code>YES</code>.
 */
@property (nonatomic, assign) BOOL showInset;

/**
 @brief An array of values that specify the lengths of the painted segments and unpainted segments, respectively, of the
 dash pattern—or <code>nil</code> for no dash pattern.
 
 For example, passing an array with the values [2,3] sets a dash pattern that alternates between a 2 point long painted
 segment and a 3 point long unpainted segment. Passing the values [1,3,4,2] sets the pattern to a 1 point painted
 segment, a 3 point unpainted segment, a 4 oiunt painted segment, and a 2 point unpainted segment.
 
 The default is <code>nil</code>.
 */
@property (nonatomic, copy) NSArray *dashLengths;

@end
