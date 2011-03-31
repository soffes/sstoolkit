//
//  SSTextField.h
//  SSToolkit
//
//  Created by Sam Soffes on 3/11/10.
//  Copyright 2010-2011 Sam Soffes. All rights reserved.
//

/**
 @brief Simple UITextField subclass to adds text insets.
 */
@interface SSTextField : UITextField {

@private
	
	UIEdgeInsets _textEdgeInsets;
	UIEdgeInsets _clearButtonEdgeInsets;
}

/**
 @brief The inset or outset margins for the edges of the text content drawing rectangle.
 
 Use this property to resize and reposition the effective drawing rectangle for the text content. You can specify a
 different value for each of the four insets (top, left, bottom, right). A positive value shrinks, or insets, that
 edge—moving it closer to the center of the button. A negative value expands, or outsets, that edge. Use the
 UIEdgeInsetsMake function to construct a value for this property. The default value is UIEdgeInsetsZero.
 */
@property (nonatomic, assign) UIEdgeInsets textEdgeInsets;

/**
 @brief The inset or outset margins for the edges of the clear button drawing rectangle.
 
 Use this property to resize and reposition the effective drawing rectangle for the clear button content. You can
 specify a different value for each of the four insets (top, left, bottom, right), but only the top and right insets are
 respected. A positive value will move the clear button farther away from the top right corner. Use the UIEdgeInsetsMake
 function to construct a value for this property. The default value is UIEdgeInsetsZero.
 */
@property (nonatomic, assign) UIEdgeInsets clearButtonEdgeInsets;

@end
