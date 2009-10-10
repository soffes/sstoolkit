//
//  TCRootViewController.m
//  TWCatalog
//
//  Created by Sam Soffes on 10/9/09.
//  Copyright 2009 Tasteful Works, Inc. All rights reserved.
//

#import "TCRootViewController.h"
#import "TCConnectionDemoViewController.h"
#import "TCImageViewDemoViewController.h"
#import "TCPickerDemoViewController.h"

#define kTitleKey @"title"
#define kDescriptionKey @"description"
#define kClassNameKey @"className"

@interface UIViewController (TCRootViewControllerAdditions)
+ (id)setup;
@end

@implementation TCRootViewController

#pragma mark -
#pragma mark NSObject
#pragma mark -

- (void)dealloc {
	[data release];
	[super dealloc];
}


#pragma mark -
#pragma mark UIViewController
#pragma mark -

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.title = @"TWCatalog";

    data = [[NSArray alloc] initWithObjects:
			[NSDictionary dictionaryWithObjectsAndKeys:
			 @"Connection", kTitleKey,
			 @"Simple class for loading remote data", kDescriptionKey,
			 @"TCConnectionDemoViewController", kClassNameKey,
			 nil],
			[NSDictionary dictionaryWithObjectsAndKeys:
			 @"Image View", kTitleKey,
			 @"Easily load and cache remote images", kDescriptionKey,
			 @"TCImageViewDemoViewController", kClassNameKey,
			 nil],
			[NSDictionary dictionaryWithObjectsAndKeys:
			 @"Picker View Controller", kTitleKey,
			 @"Easily create pickers like the Settings app", kDescriptionKey,
			 @"TCPickerDemoViewController", kClassNameKey,
			 nil],
			nil];
}


- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	[self tableView:self.tableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
}


#pragma mark -
#pragma mark UITableViewDataSource
#pragma mark -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [data count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier] autorelease];
    }
	
	NSDictionary *row = [data objectAtIndex:indexPath.row];
	
	cell.textLabel.text = [row objectForKey:kTitleKey];
	cell.detailTextLabel.text = [row objectForKey:kDescriptionKey];
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	
    return cell;
}


#pragma mark -
#pragma mark UITableViewDelegate
#pragma mark -

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 50.0;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[self.tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	Class aClass = [[NSBundle mainBundle] classNamed:[[data objectAtIndex:indexPath.row] objectForKey:kClassNameKey]];
	UIViewController *viewController = [aClass setup];
	[self.navigationController pushViewController:viewController animated:YES];
	[viewController release];
}

@end
