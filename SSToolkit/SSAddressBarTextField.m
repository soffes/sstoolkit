//
//  SSAddressBarTextField.m
//  SSToolkit
//
//  Created by Sam Soffes on 2/8/11.
//  Copyright 2011 Sam Soffes. All rights reserved.
//

#import "SSAddressBarTextField.h"
#import "SSAddressBarTextFieldBackgroundView.h"
#import "SSDrawingUtilities.h"
#import "UIImage+SSToolkitAdditions.h"

@implementation SSAddressBarTextField

@synthesize loading = _loading;
@synthesize reloadButton = _reloadButton;
@synthesize stopButton = _stopButton;

#pragma mark NSObject

- (void)dealloc {
	self.reloadButton = nil;
	self.stopButton = nil;
	[_textFieldBackgroundView release];
	[super dealloc];
}

#pragma mark UIView

- (id)initWithFrame:(CGRect)aFrame {
	if ((self = [super initWithFrame:aFrame])) {
		
		// Configure text field
		self.borderStyle = UITextBorderStyleRoundedRect;
		self.textColor = [UIColor colorWithWhite:0.180f alpha:1.0f];
		self.font = [UIFont systemFontOfSize:15.0f];
		self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
		self.autocapitalizationType = UITextAutocapitalizationTypeNone;
		self.autocorrectionType = UITextAutocorrectionTypeNo;
		self.keyboardType = UIKeyboardTypeURL;
		self.returnKeyType = UIReturnKeyGo;
		self.clearButtonMode = UITextFieldViewModeWhileEditing;
		self.enablesReturnKeyAutomatically = YES;
		self.rightViewMode = UITextFieldViewModeUnlessEditing;
		self.textEdgeInsets = UIEdgeInsetsMake(0.0f, 5.0f, 0.0f, 26.0f);
		
		// Background view
		_textFieldBackgroundView = [[SSAddressBarTextFieldBackgroundView alloc] initWithFrame:CGRectZero];
		[self insertSubview:_textFieldBackgroundView aboveSubview:[[self subviews] objectAtIndex:0]];
		
		// Refresh button
		UIButton *aReloadButton = [UIButton buttonWithType:UIButtonTypeCustom];
		aReloadButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
		aReloadButton.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
		[aReloadButton setImage:[UIImage imageNamed:@"SSAddressBarTextFieldReload.png" bundle:kSSToolkitBundleName] forState:UIControlStateNormal];
		self.reloadButton = aReloadButton;
		self.rightView = _reloadButton;
		
		// Stop button
		UIButton *aStopButton = [UIButton buttonWithType:UIButtonTypeCustom];
		aStopButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
		aStopButton.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
		[aStopButton setImage:[UIImage imageNamed:@"SSAddressBarTextFieldStop.png" bundle:kSSToolkitBundleName] forState:UIControlStateNormal];
		self.stopButton = aStopButton;
		
		self.loading = NO;
	}
	return self;
}


- (void)layoutSubviews {
	[super layoutSubviews];
	
	CGSize size = self.frame.size;
	_textFieldBackgroundView.frame = CGRectMake(1.0f, 1.0f, size.width - 2.0f, size.height - 2.0f);
}


#pragma mark UITextField

- (CGRect)rightViewRectForBounds:(CGRect)bounds {
	CGSize size = self.frame.size;
	return CGRectMake(size.width - 24.0f, roundf((size.height - 18.0f) / 2.0f), 16.0f, 18.0f);
}


#pragma mark Setters

- (void)setLoading:(BOOL)isLoading {
	if (_loading == isLoading) {
		return;
	}
	_loading = isLoading;
	
	self.rightView = _loading ? _stopButton : _reloadButton;
	_textFieldBackgroundView.loading = _loading;
}

@end
