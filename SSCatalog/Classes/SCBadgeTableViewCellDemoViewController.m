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
	return @"Badge View Cell";
}


#pragma mark NSObject

- (id)init {
	return self = [super initWithStyle:UITableViewStyleGrouped];
}


- (void)dealloc {
    [super dealloc];
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
	
	SSBadgeView *badgeView = (SSBadgeView *) cell.accessoryView;
	switch ([indexPath row]) {
		case 0:
			cell.textLabel.text = @"Default Badge View";
			break;
		case 1:
			cell.textLabel.text = @"Unread Count";
			[badgeView setText:@"3"];
			break;
		case 2:
			cell.textLabel.text = @"Text Badge";
			cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
			[badgeView setText:@"New"];
			break;
		default:
			break;
	}
	
	return cell;
}


#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
