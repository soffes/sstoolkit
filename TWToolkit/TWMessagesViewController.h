//
//  TWMessagesViewController.h
//  Messages
//
//  Created by Sam Soffes on 3/10/10.
//  Copyright 2010 Tasteful Works. All rights reserved.
//

#import "TWMessageTableViewCell.h"

@interface TWMessagesViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {

	UITableView *_tableView;
}

@property (nonatomic, retain) UITableView *tableView;

- (TWMessageTableViewCellMessageStyle)messageStyleForRowAtIndexPath:(NSIndexPath *)indexPath;
- (NSString *)textForRowAtIndexPath:(NSIndexPath *)indexPath;

@end
