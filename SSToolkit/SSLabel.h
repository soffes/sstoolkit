//
//  SSLabel.h
//  SSToolkit
//
//  Created by Sam Soffes on 7/12/10.
//  Copyright 2010-2011 Sam Soffes. All rights reserved.
//

/**
 The vertical alignment of text within a label.
 */
typedef enum {
	/** Aligns the text vertically at the top in the label (the default). */
	SSLabelVerticalTextAlignmentTop = UIControlContentVerticalAlignmentTop,
	
	/** Aligns the text vertically in the center of the label. */
	SSLabelVerticalTextAlignmentMiddle = UIControlContentVerticalAlignmentCenter,
	
	/** Aligns the text vertically at the bottom in the label. */
	SSLabelVerticalTextAlignmentBottom = UIControlContentVerticalAlignmentBottom
} SSLabelVerticalTextAlignment;

/**
 Simple label subclass that adds the ability to align your text to the top or bottom.
 */
@interface SSLabel : UILabel

/**
 The vertical text alignment of the receiver.
 
 The default is `SSLabelVerticalTextAlignmentMiddle` to match `UILabel`.
 */
@property (nonatomic, assign) SSLabelVerticalTextAlignment verticalTextAlignment;

/**
 The edge insets of the text.
 
 The default is `UIEdgeInsetsZero` so it behaves like `UILabel` by default.
 */
@property (nonatomic, assign) UIEdgeInsets textEdgeInsets;

@end
