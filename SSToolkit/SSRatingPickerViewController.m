//
//  SSRatingPickerViewController.m
//  SSToolkit
//
//  Created by Sam Soffes on 2/3/11.
//  Copyright 2011 Sam Soffes. All rights reserved.
//

#import "SSRatingPickerViewController.h"
#import "SSGradientView.h"
#import "SSRatingPicker.h"
#import "SSTextField.h"
#import "SSTextView.h"
#import "SSDrawingMacros.h"

@implementation SSRatingPickerViewController

@synthesize ratingPicker = _ratingPicker;
@synthesize titleTextField = _titleTextField;
@synthesize reviewTextField = _reviewTextField;

#pragma mark NSObject

- (void)dealloc {
	[_scrollView release];
	[_ratingPicker release];
	[_titleTextField release];
	[_reviewTextField release];
	[super dealloc];
}


#pragma mark UIViewController

- (void)loadView {
	[super loadView];
	
	self.view.backgroundColor = [UIColor whiteColor];
	
	UIFont *font = [UIFont systemFontOfSize:17.0f];
	UIColor *topColor = [UIColor colorWithRed:0.878f green:0.890f blue:0.906f alpha:1.0f];
	UIColor *lineColor = [UIColor colorWithRed:0.839f green:0.839f blue:0.839f alpha:1.0f];
	
	_scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 190.0f)];
	_scrollView.backgroundColor = [UIColor whiteColor];
	_scrollView.contentSize = CGSizeMake(320.0f, 191.0f);
	[self.view addSubview:_scrollView];
	
	UIView *top = [[UIView alloc] initWithFrame:CGRectMake(0.0f, -400.0f, 320.0f, 400.0f)];
	top.backgroundColor = topColor;
	[_scrollView addSubview:top];
	[top release];
	
	SSGradientView *gradientView = [[SSGradientView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 48.0f)];
	gradientView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
	gradientView.topColor = topColor;
	gradientView.bottomColor = [UIColor colorWithRed:0.961f green:0.965f blue:0.973f alpha:1.0f];
	gradientView.bottomBorderColor = lineColor;
	gradientView.hasTopBorder = NO;
	gradientView.hasBottomBorder = YES;
	gradientView.showsInsets = NO;	
	[_scrollView addSubview:gradientView];
	
	SSRatingPicker *picker = [[SSRatingPicker alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 48.0f)];
	picker.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
	picker.backgroundColor = [UIColor clearColor];
	[gradientView addSubview:picker];
	[picker release];
	[gradientView release];	

	_titleTextField = [[SSTextField alloc] initWithFrame:CGRectMake(0.0f, 48.0f, 320.0f, 42.0f)];
	_titleTextField.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
	_titleTextField.font = font;
	_titleTextField.placeholder = @"Title";
	_titleTextField.textEdgeInsets = UIEdgeInsetsMake(10.0f, 8.0f, 10.0f, 8.0f);
	[_scrollView addSubview:_titleTextField];
	
	UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 90.0f, 320.0f, 1.0f)];
	line.backgroundColor = lineColor;
	line.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
	[_scrollView addSubview:line];
	[line release];
	
	_reviewTextView = [[SSTextView alloc] initWithFrame:CGRectMake(0.0f, 91.0f, 320.0f, 99.0f)];
	_reviewTextView.placeholder = @"Review (Optional)";
	_reviewTextView.font = font;
	_reviewTextView.scrollEnabled = NO;
	_reviewTextView.delegate = self;
	[_scrollView addSubview:_reviewTextView];	
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
		return toInterfaceOrientation != UIInterfaceOrientationPortraitUpsideDown;
	}
	return YES;
}


- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[_titleTextField becomeFirstResponder];
}


#pragma mark UITextViewDelegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
	if (range.location == [textView.text length] - 1) {
		[_scrollView scrollRectToVisible:CGRectMake(0.0f, _scrollView.contentSize.height, 320.0f, 1.0f) animated:YES];
	}
	
	return YES;
}


- (void)textViewDidChange:(UITextView *)textView {
	CGFloat height = [textView sizeThatFits:CGSizeMake(_scrollView.frame.size.width, 2000.0f)].height + 91.0f;
	height = fmax(height, 191.0f);
	_scrollView.contentSize = CGSizeMake(320.0f, height);
	_reviewTextView.frame = CGRectSetHeight(_reviewTextView.frame, height - 91.0f);
}

@end
