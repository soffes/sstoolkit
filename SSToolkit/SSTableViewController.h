//
//  SSTableViewController.h
//  SSToolkit
//
//  Created by Sam Soffes on 10/14/10.
//  Copyright 2010 Sam Soffes. All rights reserved.
//

#import "SSViewController.h"

@interface SSTableViewController : SSViewController <UITableViewDataSource, UITableViewDelegate> {

	UITableView *_tableView;
	BOOL _clearsSelectionOnViewWillAppear;
}

- (id)initWithStyle:(UITableViewStyle)style;

@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic) BOOL clearsSelectionOnViewWillAppear;

@end
