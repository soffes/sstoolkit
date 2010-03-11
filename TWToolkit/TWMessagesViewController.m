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
#import "UIImage+BundleImage.h"

#define kInputHeight 40.0

@implementation TWMessagesViewController

@synthesize tableView = _tableView;

#pragma mark -
#pragma mark NSObject
#pragma mark -

- (id)init {
	return [self initWithNibName:nil bundle:nil];
}


- (void)dealloc {
	self.tableView = nil;
	[super dealloc];
}


#pragma mark -
#pragma mark UITableViewController
#pragma mark -

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nil bundle:nil]) {
		self.view.backgroundColor = [UIColor colorWithRed:0.859 green:0.886 blue:0.929 alpha:1.0];
		
		// Table view
		UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width, self.view.frame.size.height - kInputHeight) style:UITableViewStylePlain];
		tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		tableView.backgroundColor = self.view.backgroundColor;
		tableView.dataSource = self;
		tableView.delegate = self;
		tableView.separatorColor = self.view.backgroundColor;
		self.tableView = tableView;
		[tableView release];
		[self.view addSubview:self.tableView];
		
		// Input background
		TWGradientView *inputBackground = [[TWGradientView alloc] initWithFrame:CGRectMake(0.0, self.view.frame.size.height - 44.0 - kInputHeight, self.view.frame.size.width, kInputHeight)];
		inputBackground.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		inputBackground.hasBottomBorder = NO;
		inputBackground.topBorderColor = [UIColor colorWithRed:0.733 green:0.741 blue:0.745 alpha:1.0];
		inputBackground.topColor = [UIColor colorWithRed:0.914 green:0.922 blue:0.929 alpha:1.0];
		inputBackground.bottomColor = [UIColor colorWithRed:0.765 green:0.773 blue:0.788 alpha:1.0];
		[self.view addSubview:inputBackground];
		[inputBackground release];
		
		// Send button
		UIButton *sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
		sendButton.frame = CGRectMake(self.view.frame.size.width - 65.0, 8.0, 59.0, 27.0);
		sendButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
		sendButton.titleLabel.font = [UIFont boldSystemFontOfSize:16.0];
		sendButton.titleLabel.shadowColor = [UIColor colorWithWhite:0.0 alpha:1.0];
		sendButton.titleLabel.shadowOffset = CGSizeMake(0.0, -1.0);
		[sendButton setBackgroundImage:[UIImage imageNamed:@"images/messages-button.png" bundle:@"TWToolkit.bundle"] forState:UIControlStateNormal];
		[sendButton setTitle:@"Send" forState:UIControlStateNormal];
		[inputBackground addSubview:sendButton];
    }
    return self;
}


#pragma mark -
#pragma mark TWMessagesViewController
#pragma mark -

// This method is intended to be overridden by subclasses
- (TWMessageTableViewCellMessageStyle)messageStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
	return TWMessageTableViewCellMessageStyleGray;
}

// This method is intended to be overridden by subclasses
- (NSString *)textForRowAtIndexPath:(NSIndexPath *)indexPath {
	return nil;
}


#pragma mark -
#pragma mark UITableViewDataSource
#pragma mark -

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


#pragma mark -
#pragma mark UITableViewDelegate
#pragma mark -

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return [TWMessageTableViewCellBubbleView cellHeightForText:[self textForRowAtIndexPath:indexPath]];
}

@end
