//
//  SCMessagesDemoViewController.m
//  SSCatalog
//
//  Created by Sam Soffes on 3/10/10.
//  Copyright 2010 Sam Soffes. All rights reserved.
//

#import "SCMessagesDemoViewController.h"

@implementation SCMessagesDemoViewController

NSString *lorem[] = {
	@"Hi",
	@"This is a work in progress",
	@"Ya I know",
	@"Fine then\nI see how it is",
	@"Do you? Do you really?",
	@"Yes"
};


#pragma mark Class Methods

+ (NSString *)title {
	return @"Messages";
}


#pragma mark UIViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	self.title = [[self class] title];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
		return toInterfaceOrientation != UIInterfaceOrientationPortraitUpsideDown;
	}
	return YES;
}


#pragma mark SSMessagesViewController

- (SSMessageTableViewCellMessageStyle)messageStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.row % 2) {
		return SSMessageTableViewCellMessageStyleGreen;
	}
	return SSMessageTableViewCellMessageStyleGray;
}


- (NSString *)textForRowAtIndexPath:(NSIndexPath *)indexPath {
	return lorem[indexPath.row];
}


#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return sizeof(lorem) / sizeof(NSString *);
}

@end
