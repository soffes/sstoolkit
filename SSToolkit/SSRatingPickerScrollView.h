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

@interface SSRatingPickerScrollView : UIScrollView <UITextViewDelegate>

@property (nonatomic, retain, readonly) SSRatingPicker *ratingPicker;
@property (nonatomic, retain, readonly) SSTextField *titleTextField;
@property (nonatomic, retain, readonly) SSTextView *reviewTextView;

@end
