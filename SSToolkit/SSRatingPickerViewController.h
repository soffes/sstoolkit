//
//  SSRatingPickerViewController.h
//  SSToolkit
//
//  Created by Sam Soffes on 2/3/11.
//  Copyright 2011 Sam Soffes. All rights reserved.
//

@class SSRatingPicker;
@class SSTextField;
@class SSTextView;

@interface SSRatingPickerViewController : UIViewController <UITextViewDelegate> {

@private
	
    UIScrollView *_scrollView;
	SSRatingPicker *_ratingPicker;
	SSTextField *_titleTextField;
	SSTextView *_reviewTextView;
}

@property (nonatomic, retain) SSRatingPicker *ratingPicker;
@property (nonatomic, retain) SSTextField *titleTextField;
@property (nonatomic, retain) SSTextView *reviewTextField;

@end
