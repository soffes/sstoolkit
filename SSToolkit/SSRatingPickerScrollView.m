//
//  SSRatingPickerScrollView.m
//  SSToolkit
//
//  Created by Sam Soffes on 2/4/11.
//  Copyright 2011 Sam Soffes. All rights reserved.
//

#import "SSRatingPickerScrollView.h"
#import "SSGradientView.h"
#import "SSRatingPicker.h"
#import "SSTextField.h"
#import "SSTextView.h"
#import "SSDrawingUtilities.h"

@implementation SSRatingPickerScrollView {
	UIView *_topView;
	SSGradientView *_gradientView;
	UIView *_lineView;
}


#pragma mark - Accessors

@synthesize ratingPicker = _ratingPicker;
@synthesize titleTextField = _titleTextField;
@synthesize reviewTextView = _reviewTextView;


#pragma mark - UIView

- (id)initWithFrame:(CGRect)frame {
	if ((self = [super initWithFrame:frame])) {
		self.backgroundColor = [UIColor whiteColor];
		self.alwaysBounceVertical = YES;
		
		UIFont *font = [UIFont systemFontOfSize:17.0f];
		UIColor *topColor = [UIColor colorWithRed:0.878f green:0.890f blue:0.906f alpha:1.0f];
		UIColor *lineColor = [UIColor colorWithRed:0.839f green:0.839f blue:0.839f alpha:1.0f];
		
		_topView = [[UIView alloc] initWithFrame:CGRectZero];
		_topView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
		_topView.backgroundColor = topColor;
		[self addSubview:_topView];
		
		_gradientView = [[SSGradientView alloc] initWithFrame:CGRectZero];
		_gradientView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
		_gradientView.topColor = topColor;
		_gradientView.bottomColor = [UIColor colorWithRed:0.961f green:0.965f blue:0.973f alpha:1.0f];
		_gradientView.bottomBorderColor = lineColor;
		[self addSubview:_gradientView];
		
		_ratingPicker = [[SSRatingPicker alloc] initWithFrame:CGRectZero];
		_ratingPicker.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
		_ratingPicker.backgroundColor = [UIColor clearColor];
		[_gradientView addSubview:_ratingPicker];
		
		_titleTextField = [[SSTextField alloc] initWithFrame:CGRectZero];
		_titleTextField.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
		_titleTextField.font = font;
		_titleTextField.placeholder = @"Title";
		_titleTextField.textEdgeInsets = UIEdgeInsetsMake(10.0f, 8.0f, 10.0f, 8.0f);
		[self addSubview:_titleTextField];
		
		_lineView = [[UIView alloc] initWithFrame:CGRectZero];
		_lineView.backgroundColor = lineColor;
		_lineView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
		[self addSubview:_lineView];

		_reviewTextView = [[SSTextView alloc] initWithFrame:CGRectZero];
		_reviewTextView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
		_reviewTextView.placeholder = @"Review (Optional)";
		_reviewTextView.font = font;
		_reviewTextView.scrollEnabled = NO;
		_reviewTextView.delegate = self;
		[self addSubview:_reviewTextView];
	}
	return self;
}


- (void)layoutSubviews {
	[super layoutSubviews];
	
	CGFloat height = [_reviewTextView sizeThatFits:CGSizeMake(self.frame.size.width, 2000.0f)].height + 91.0f;
	height = fmaxf(height, 191.0f);
	self.contentSize = CGSizeMake(self.frame.size.width, height);
	
	CGSize size = self.contentSize;

	_topView.frame = CGRectMake(0.0f, -400.0f, size.width, 400.0f);
	_gradientView.frame = CGRectMake(0.0f, 0.0f, size.width, 48.0f);
	_ratingPicker.frame = CGRectMake(0.0f, 0.0f, size.width, 48.0f);
	_titleTextField.frame = CGRectMake(0.0f, 48.0f, size.width, 42.0f);
	_lineView.frame = CGRectMake(0.0f, 90.0f, size.width, 1.0f);
	_reviewTextView.frame = CGRectMake(0.0f, 91.0f, size.width, size.height - 91.0f);
}


#pragma mark - UITextViewDelegate

- (void)textViewDidChange:(UITextView *)textView {
	[self setNeedsDisplay];
}

@end
