//
//  TCRootViewController.m
//  TWCatalog
//
//  Created by Sam Soffes on 10/9/09.
//  Copyright 2009 Tasteful Works, Inc. All rights reserved.
//

#import "TCRootViewController.h"
#import "TCConnectionDemoViewController.h"
#import "TCRemoteImageViewDemoViewController.h"
#import "TCPickerDemoViewController.h"
#import "TCGradientViewDemoViewController.h"

#define kTitleKey @"title"
#define kDescriptionKey @"description"
#define kClassNameKey @"className"
#define kObjectsKey @"objects"

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
			 [NSArray arrayWithObjects:
			  [NSDictionary dictionaryWithObjectsAndKeys:
			   @"Connection Queue", kTitleKey,
			   @"Simple class for loading remote data", kDescriptionKey,
			   @"TCConnectionDemoViewController", kClassNameKey,
			   nil],
			  nil],
			 kObjectsKey,
			 @"Connection",
			 kTitleKey,
			 nil],
			[NSDictionary dictionaryWithObjectsAndKeys:
			 [NSArray arrayWithObjects:
			  [NSDictionary dictionaryWithObjectsAndKeys:
			   @"Remote Image View", kTitleKey,
			   @"Easily load and cache remote images", kDescriptionKey,
			   @"TCRemoteImageViewDemoViewController", kClassNameKey,
			   nil],
			  [NSDictionary dictionaryWithObjectsAndKeys:
			   @"Gradient View", kTitleKey,
			   @"Gradients made easy", kDescriptionKey,
			   @"TCGradientViewDemoViewController", kClassNameKey,
			   nil],
			  nil],
			 kObjectsKey,
			 @"Views",
			 kTitleKey,
			 nil],
			[NSDictionary dictionaryWithObjectsAndKeys:
			 [NSArray arrayWithObjects:
			  [NSDictionary dictionaryWithObjectsAndKeys:
			   @"Settings Picker", kTitleKey,
			   @"Easily create pickers like the Settings app", kDescriptionKey,
			   @"TCPickerDemoViewController", kClassNameKey,
			   nil],
			  [NSDictionary dictionaryWithObjectsAndKeys:
			   @"Twitter OAuth", kTitleKey,
			   @"Easy Twitter authorization using OAuth", kDescriptionKey,
			   @"TCTwitterDemoViewController", kClassNameKey,
			   nil],
			  nil],
			 kObjectsKey,
			 @"View Controllers",
			 kTitleKey,
			 nil],
			nil];
}


#pragma mark -
#pragma mark UITableViewDataSource
#pragma mark -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [data count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[data objectAtIndex:section] objectForKey:kObjectsKey] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
    }
	
	NSDictionary *row = [[[data objectAtIndex:indexPath.section] objectForKey:kObjectsKey] objectAtIndex:indexPath.row];
	
	cell.textLabel.text = [row objectForKey:kTitleKey];
//	cell.detailTextLabel.text = [row objectForKey:kDescriptionKey];
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	
    return cell;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	return [[data objectAtIndex:section] objectForKey:kTitleKey];
}


#pragma mark -
#pragma mark UITableViewDelegate
#pragma mark -

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[self.tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	Class aClass = [[NSBundle mainBundle] classNamed:[[[[data objectAtIndex:indexPath.section] objectForKey:kObjectsKey] objectAtIndex:indexPath.row] objectForKey:kClassNameKey]];
	UIViewController *viewController = [aClass setup];
	[self.navigationController pushViewController:viewController animated:YES];
	[viewController release];
}

@end
