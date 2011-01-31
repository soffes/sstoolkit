//
//  SCBadgeTableViewCellDemoViewController.m
//  SSCatalog
//
//  Created by Sam Soffes on 01/29/11.
//  Copyright 2011 Sam Soffes, Inc. All rights reserved.
//

#import "SCBadgeTableViewCellDemoViewController.h"
#import <SSToolkit/SSBadgeTableViewCell.h>
#import <SSToolkit/SSBadgeView.h>

@implementation SCBadgeTableViewCellDemoViewController

#pragma mark Class Methods

+ (NSString *)title {
	return @"Badge Table View Cell";
}


#pragma mark NSObject

- (id)init {
	return self = [super initWithStyle:UITableViewStyleGrouped];
}


#pragma mark UIViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	self.title = [[self class] title];
}


- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[self.tableView reloadData];
}


#pragma mark SSBadgeTableViewCellDemoViewController

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
		return toInterfaceOrientation != UIInterfaceOrientationPortraitUpsideDown;
	}
	return YES;
}


#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cell";
	
	SSBadgeTableViewCell *cell = (SSBadgeTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	if (cell == nil) {
		cell = [[[SSBadgeTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier] autorelease];
	}
	
	switch (indexPath.row) {
		case 0:
			cell.textLabel.text = @"Default Badge View";
			break;
		case 1:
			cell.textLabel.text = @"Unread Count";
			cell.badgeView.text = @"3";
			cell.badgeView.badgeColor = [UIColor colorWithRed:0.969f green:0.082f blue:0.078f alpha:1.0f];
			break;
		case 2:
			cell.textLabel.text = @"Text Badge";
			cell.badgeView.text = @"New";
			cell.badgeView.badgeColor = [UIColor colorWithRed:0.388f green:0.686f blue:0.239f alpha:1.0f];
			break;
	}
	
	return cell;
}


#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
