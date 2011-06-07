//
//  SSRatingPickerViewController.h
//  SSToolkit
//
//  Created by Sam Soffes on 2/3/11.
//  Copyright 2011 Sam Soffes. All rights reserved.
//

@class SSRatingPickerScrollView;
@class SSRatingPicker;
@class SSTextField;
@class SSTextView;

@interface SSRatingPickerViewController : UIViewController {

@private
	
    SSRatingPickerScrollView *_scrollView;
}

@property (nonatomic, retain, readonly) UIScrollView *scrollView;
@property (nonatomic, retain, readonly) SSRatingPicker *ratingPicker;
@property (nonatomic, retain, readonly) SSTextField *titleTextField;
@property (nonatomic, retain, readonly) SSTextView *reviewTextField;

@end
