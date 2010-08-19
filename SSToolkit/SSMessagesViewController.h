//
//  SSMessagesViewController.h
//  Messages
//
//	This is an abstract class for displaying a UI similar
//	to Apple's SMS application. A subclass should
//	override the messageStyleForRowAtIndexPath: and
//	textForRowAtIndexPath: to customize this class.
//
//	This is still a work in progress and likely to change
//	at any time.
//
//  Created by Sam Soffes on 3/10/10.
//  Copyright 2010 Sam Soffes. All rights reserved.
//

#import "SSMessageTableViewCell.h"

@class SSGradientView;

@interface SSMessagesViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate> {

	UITableView *_tableView;
	SSGradientView *_inputView;
	UIButton *_sendButton;
}

@property (nonatomic, retain, readonly) UITableView *tableView;

- (SSMessageTableViewCellMessageStyle)messageStyleForRowAtIndexPath:(NSIndexPath *)indexPath;
- (NSString *)textForRowAtIndexPath:(NSIndexPath *)indexPath;

@end
