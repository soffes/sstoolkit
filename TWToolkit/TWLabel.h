//
//  TWLabel.h
//  TWToolkit
//
//  Created by Sam Soffes on 7/12/10.
//  Copyright 2010 Tasteful Works, Inc. All rights reserved.
//

typedef enum {
	TWLabelVerticalTextAlignmentCenter = UIControlContentVerticalAlignmentCenter,
	TWLabelVerticalTextAlignmentTop = UIControlContentVerticalAlignmentTop,
	TWLabelVerticalTextAlignmentBottom = UIControlContentVerticalAlignmentBottom
} TWLabelVerticalTextAlignment;

@interface TWLabel : UILabel {
	
	TWLabelVerticalTextAlignment _verticalTextAlignment;
	UIEdgeInsets _textInsets;
}

@property (nonatomic, assign) TWLabelVerticalTextAlignment verticalTextAlignment;
@property (nonatomic, assign) UIEdgeInsets textInsets;

@end
