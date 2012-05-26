//
//  SSRatingPickerViewController.m
//  SSToolkit
//
//  Created by Sam Soffes on 2/3/11.
//  Copyright 2011 Sam Soffes. All rights reserved.
//

#import "SSRatingPickerViewController.h"
#import "SSRatingPickerScrollView.h"
#import "SSRatingPicker.h"
#import "SSTextField.h"
#import "SSTextView.h"
#import "UIScreen+SSToolkitAdditions.h"

@interface SSRatingPickerViewController ()
@property (nonatomic, strong, readonly) SSRatingPickerScrollView *scrollView;
@end

@implementation SSRatingPickerViewController

#pragma mark - Accessors

- (SSRatingPickerScrollView *)scrollView {
	return (SSRatingPickerScrollView *)self.view;
}


- (SSRatingPicker *)ratingPicker {
	return self.scrollView.ratingPicker;
}


- (SSTextField *)titleTextField {
	return self.scrollView.titleTextField;
}


- (SSTextView *)reviewTextView {
	return self.scrollView.reviewTextView;
}


#pragma mark - UIViewController

- (void)loadView {
	self.view = [[SSRatingPickerScrollView alloc] initWithFrame:CGRectZero];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
		return toInterfaceOrientation != UIInterfaceOrientationPortraitUpsideDown;
	}
	return YES;
}


- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[self.titleTextField becomeFirstResponder];
}


#pragma mark - SSViewController

- (void)layoutViewsWithOrientation:(UIInterfaceOrientation)orientation {
	
	CGSize size = [[UIScreen mainScreen] boundsForOrientation:orientation].size;
	BOOL landscape = UIInterfaceOrientationIsLandscape(orientation);
	size.height -= landscape ? 214.0f : 280.0f;
	
	self.view.frame = CGRectMake(0.0f, 0.0f, size.width, size.height - 10.0f);
}

@end
