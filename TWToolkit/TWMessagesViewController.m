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

@implementation TWMessagesViewController

#pragma mark -
#pragma mark NSObject
#pragma mark -

- (id)init {
	return [self initWithStyle:UITableViewStylePlain];
}


#pragma mark -
#pragma mark UITableViewController
#pragma mark -

- (id)initWithStyle:(UITableViewStyle)style {
    if ((self = [super initWithStyle:UITableViewStylePlain])) {
		self.view.backgroundColor = [UIColor colorWithRed:0.859 green:0.886 blue:0.929 alpha:1.0];
		self.tableView.separatorColor = [UIColor clearColor];
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
