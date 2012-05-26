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

@property (nonatomic, strong, readonly) SSRatingPicker *ratingPicker;
@property (nonatomic, strong, readonly) SSTextField *titleTextField;
@property (nonatomic, strong, readonly) SSTextView *reviewTextView;

@end
