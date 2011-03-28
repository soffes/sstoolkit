//
//  SSLabel.h
//  SSToolkit
//
//  Created by Sam Soffes on 7/12/10.
//  Copyright 2010-2011 Sam Soffes. All rights reserved.
//

typedef enum {
	SSLabelVerticalTextAlignmentTop = UIControlContentVerticalAlignmentTop,
	SSLabelVerticalTextAlignmentMiddle = UIControlContentVerticalAlignmentCenter,
	SSLabelVerticalTextAlignmentBottom = UIControlContentVerticalAlignmentBottom
} SSLabelVerticalTextAlignment;

/**
 @brief Simple label subclass that adds the ability to align your text
 to the top or bottom.
 */
@interface SSLabel : UILabel {
	
@private
	
	SSLabelVerticalTextAlignment _verticalTextAlignment;
	UIEdgeInsets _textEdgeInsets;
}

/**
 @brief The vertical text alignment of the receiver.
 
 The default is SSLabelVerticalTextAlignmentMiddle to match UILabel.
 */
@property (nonatomic, assign) SSLabelVerticalTextAlignment verticalTextAlignment;

/**
 @brief The edge insets of the text.
 
 The default is UIEdgeInsetsZero so it behaves like UILabel by default.
 */
@property (nonatomic, assign) UIEdgeInsets textEdgeInsets;

@end
