//
//  SSRatingPickerScrollView.h
//  SSToolkit
//
//  Created by Sam Soffes on 2/4/11.
//  Copyright 2011 Sam Soffes. All rights reserved.
//

@class SSGradientView;
@class SSRatingPicker;
@class SSTextField;
@class SSTextView;

@interface SSRatingPickerScrollView : UIScrollView <UITextViewDelegate> {
    
@private
	
	UIView *_topView;
	SSGradientView *_gradientView;
	SSRatingPicker *_ratingPicker;
	SSTextField *_titleTextField;
	UIView *_lineView;
	SSTextView *_reviewTextView;
}

@property (nonatomic, retain, readonly) SSRatingPicker *ratingPicker;
@property (nonatomic, retain, readonly) SSTextField *titleTextField;
@property (nonatomic, retain, readonly) SSTextView *reviewTextField;

@end
