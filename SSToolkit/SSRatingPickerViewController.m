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

@implementation SSRatingPickerViewController

@synthesize scrollView = _scrollView;

#pragma mark NSObject

- (void)dealloc {
	[_scrollView release];
	[super dealloc];
}


#pragma mark UIViewController

- (void)loadView {
	[super loadView];
	
	self.view.backgroundColor = [UIColor whiteColor];
	self.view.autoresizesSubviews = NO;
	
	_scrollView = [[SSRatingPickerScrollView alloc] initWithFrame:CGRectZero];
	[self.view addSubview:_scrollView];
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


#pragma mark SSViewController

- (void)layoutViewsWithOrientation:(UIInterfaceOrientation)orientation {
	
	CGSize size = [[UIScreen mainScreen] boundsForOrientation:orientation].size;
	BOOL landscape = UIInterfaceOrientationIsLandscape(orientation);
	size.height -= landscape ? 214.0f : 280.0f;
	
	_scrollView.frame = CGRectMake(0.0f, 0.0f, size.width, size.height - 10.0f);
}


#pragma mark Getters

- (SSRatingPicker *)ratingPicker {
	return _scrollView.ratingPicker;
}


- (SSTextField *)titleTextField {
	return _scrollView.titleTextField;
}


- (SSTextView *)reviewTextField {
	return _scrollView.reviewTextField;
}

@end
