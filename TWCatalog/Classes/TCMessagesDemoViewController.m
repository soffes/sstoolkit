//
//  TCMessagesDemoViewController.m
//  TWCatalog
//
//  Created by Sam Soffes on 3/10/10.
//  Copyright 2010 Tasteful Works. All rights reserved.
//

#import "TCMessagesDemoViewController.h"

@implementation TCMessagesDemoViewController

NSString *lorem[] = {
	@"Hi",
	@"Lorem ipsum dolor sit amet.",
	@"Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam.",
	@"Quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
	@"Duis aute irure dolor in reprehenderit.",
	@"Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
	
};


#pragma mark -
#pragma mark Class Methods
#pragma mark -

+ (NSString *)title {
	return @"Messages";
}


#pragma mark -
#pragma mark UIViewController
#pragma mark -

- (void)viewDidLoad {
	[super viewDidLoad];
	self.title = [[self class] title];
}


#pragma mark -
#pragma mark TWMessagesViewController
#pragma mark -

- (TWMessageTableViewCellMessageStyle)messageStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.row % 2) {
		return TWMessageTableViewCellMessageStyleGreen;
	}
	return TWMessageTableViewCellMessageStyleGray;
}


- (NSString *)textForRowAtIndexPath:(NSIndexPath *)indexPath {
	return lorem[indexPath.row];
}


#pragma mark -
#pragma mark UITableViewDataSource
#pragma mark -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return sizeof(lorem) / sizeof(NSString *);
}

@end
