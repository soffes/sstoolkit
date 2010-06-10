//
//  TWMessagesViewController.m
//  Messages
//
//  Created by Sam Soffes on 3/10/10.
//  Copyright 2010 Tasteful Works. All rights reserved.
//

#import "TWMessagesViewController.h"
#import "TWMessageTableViewCell.h"
#import "TWMessageTableViewCellBubbleView.h"
#import "TWGradientView.h"
#import "TWTextField.h"
#import "UIImage+BundleImage.h"

CGFloat kInputHeight = 40.0;

@implementation TWMessagesViewController

@synthesize tableView = _tableView;

#pragma mark NSObject

- (id)init {
	return [self initWithNibName:nil bundle:nil];
}


- (void)dealloc {
	[_tableView release];
	[_inputView release];
	[_sendButton release];
	[super dealloc];
}

#pragma mark UITableViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nil bundle:nil]) {
		self.view.backgroundColor = [UIColor colorWithRed:0.859 green:0.886 blue:0.929 alpha:1.0];
		
		// Table view
		_tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width, self.view.frame.size.height - kInputHeight) style:UITableViewStylePlain];
		_tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		_tableView.backgroundColor = self.view.backgroundColor;
		_tableView.dataSource = self;
		_tableView.delegate = self;
		_tableView.separatorColor = self.view.backgroundColor;
		[self.view addSubview:_tableView];
		
		// Input
		_inputView = [[TWGradientView alloc] initWithFrame:CGRectMake(0.0, self.view.frame.size.height - 44.0 - kInputHeight, self.view.frame.size.width, kInputHeight)];
		_inputView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		_inputView.hasBottomBorder = NO;
		_inputView.topBorderColor = [UIColor colorWithRed:0.733 green:0.741 blue:0.745 alpha:1.0];
		_inputView.topColor = [UIColor colorWithRed:0.914 green:0.922 blue:0.929 alpha:1.0];
		_inputView.bottomColor = [UIColor colorWithRed:0.765 green:0.773 blue:0.788 alpha:1.0];
		[self.view addSubview:_inputView];
		
		// Text field
		TWTextField *textField = [[TWTextField alloc] initWithFrame:CGRectMake(6.0, 8.0, self.view.frame.size.width - 75.0, 27.0)];
		textField.background = [[UIImage imageNamed:@"images/message-input-box.png" bundle:@"TWToolkit.bundle"] stretchableImageWithLeftCapWidth:12 topCapHeight:0];
		textField.delegate = self;
		textField.font = [UIFont systemFontOfSize:15.0];
		textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
		textField.textInset = UIEdgeInsetsMake(0.0, 12.0, 0.0, 12.0);
		[_inputView addSubview:textField];
		[textField release];
		
		// Send button
		_sendButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
		_sendButton.frame = CGRectMake(self.view.frame.size.width - 65.0, 8.0, 59.0, 27.0);
		_sendButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
		_sendButton.titleLabel.font = [UIFont boldSystemFontOfSize:16.0];
		_sendButton.titleLabel.shadowOffset = CGSizeMake(0.0, -1.0);
		[_sendButton setBackgroundImage:[[UIImage imageNamed:@"images/messages-send-button.png" bundle:@"TWToolkit.bundle"] stretchableImageWithLeftCapWidth:12 topCapHeight:0] forState:UIControlStateNormal];
		[_sendButton setTitle:@"Send" forState:UIControlStateNormal];
		[_sendButton setTitleColor:[UIColor colorWithWhite:1.0 alpha:0.4] forState:UIControlStateNormal];
		[_sendButton setTitleShadowColor:[UIColor colorWithRed:0.325 green:0.463 blue:0.675 alpha:1.0] forState:UIControlStateNormal];
		[_inputView addSubview:_sendButton];
    }
    return self;
}

#pragma mark TWMessagesViewController

// This method is intended to be overridden by subclasses
- (TWMessageTableViewCellMessageStyle)messageStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
	return TWMessageTableViewCellMessageStyleGray;
}

// This method is intended to be overridden by subclasses
- (NSString *)textForRowAtIndexPath:(NSIndexPath *)indexPath {
	return nil;
}

#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"cellIdentifier";
    
    TWMessageTableViewCell *cell = (TWMessageTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[[TWMessageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
    }
	
    cell.messageStyle = [self messageStyleForRowAtIndexPath:indexPath];
	cell.messageText = [self textForRowAtIndexPath:indexPath];
	
    return cell;
}

#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return [TWMessageTableViewCellBubbleView cellHeightForText:[self textForRowAtIndexPath:indexPath]];
}

#pragma mark UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
	[UIView beginAnimations:@"beginEditing" context:_inputView];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationDuration:0.3];
	_tableView.contentInset = UIEdgeInsetsMake(0.0, 0.0, 216.0, 0.0);
	_tableView.scrollIndicatorInsets = _tableView.contentInset;
	_inputView.frame = CGRectMake(0.0, 160.0, self.view.frame.size.width, kInputHeight);
	[_sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[UIView commitAnimations];
}


- (void)textFieldDidEndEditing:(UITextField *)textField {
	[UIView beginAnimations:@"endEditing" context:_inputView];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationDuration:0.3];
	_tableView.contentInset = UIEdgeInsetsZero;
	_tableView.scrollIndicatorInsets = UIEdgeInsetsZero;
	_inputView.frame = CGRectMake(0.0, _tableView.frame.size.height, self.view.frame.size.width, kInputHeight);
	[_sendButton setTitleColor:[UIColor colorWithWhite:1.0 alpha:0.4] forState:UIControlStateNormal];
	[UIView commitAnimations];
}

@end
