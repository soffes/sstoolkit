//
//  SSLabel.h
//  SSToolkit
//
//  Created by Sam Soffes on 7/12/10.
//  Copyright 2009-2010 Sam Soffes. All rights reserved.
//

typedef enum {
	SSLabelVerticalTextAlignmentMiddle = UIControlContentVerticalAlignmentCenter,
	SSLabelVerticalTextAlignmentTop = UIControlContentVerticalAlignmentTop,
	SSLabelVerticalTextAlignmentBottom = UIControlContentVerticalAlignmentBottom
} SSLabelVerticalTextAlignment;

@interface SSLabel : UILabel {
	
	SSLabelVerticalTextAlignment _verticalTextAlignment;
	UIEdgeInsets _textInsets;
}

@property (nonatomic, assign) SSLabelVerticalTextAlignment verticalTextAlignment;
@property (nonatomic, assign) UIEdgeInsets textInsets;

@end
