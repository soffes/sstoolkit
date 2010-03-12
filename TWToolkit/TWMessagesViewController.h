//
//  TWMessagesViewController.h
//  Messages
//
//	This is an abstract class for displaying a UI similar
//	to Apple's SMS application. A subclass should
//	override the messageStyleForRowAtIndexPath: and
//	textForRowAtIndexPath: to customize this class.
//
//  Created by Sam Soffes on 3/10/10.
//  Copyright 2010 Tasteful Works. All rights reserved.
//

#import "TWMessageTableViewCell.h"

@class TWGradientView;

@interface TWMessagesViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate> {

	UITableView *_tableView;
	TWGradientView *_inputView;
	UIButton *_sendButton;
}

@property (nonatomic, retain, readonly) UITableView *tableView;

- (TWMessageTableViewCellMessageStyle)messageStyleForRowAtIndexPath:(NSIndexPath *)indexPath;
- (NSString *)textForRowAtIndexPath:(NSIndexPath *)indexPath;

@end
