//
//  SCRootViewController.m
//  SSCatalog
//
//  Created by Sam Soffes on 10/9/09.
//  Copyright 2009 Sam Soffes, Inc. All rights reserved.
//

#import "SCRootViewController.h"
#import "SCPickerDemoViewController.h"
#import "SCGradientViewDemoViewController.h"

#define kTitleKey @"title"
#define kClassesKey @"classes"

@interface UIViewController (SCRootViewControllerAdditions)
+ (id)setup;
@end

@implementation SCRootViewController

#pragma mark NSObject

- (void)dealloc {
	[data release];
	[super dealloc];
}


#pragma mark UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.title = @"SSCatalog";

    data = [[NSArray alloc] initWithObjects:
			[NSDictionary dictionaryWithObjectsAndKeys:
			 [NSArray arrayWithObjects:
			  @"SCCollectionViewDemoViewController",
			  @"SCGradientViewDemoViewController",
			  @"SCHUDViewDemoViewController",
			  @"SCLineViewDemoViewController",
			  @"SCPieProgressViewDemoViewController",
			  nil],
			 kClassesKey,
			 @"Views",
			 kTitleKey,
			 nil],
			[NSDictionary dictionaryWithObjectsAndKeys:
			 [NSArray arrayWithObjects:
			  @"SCPickerDemoViewController",
			  @"SCMessagesDemoViewController",
			  nil],
			 kClassesKey,
			 @"View Controllers",
			 kTitleKey,
			 nil],
			nil];
}


#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [data count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[data objectAtIndex:section] objectForKey:kClassesKey] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
    }
	
	Class klass = [[NSBundle mainBundle] classNamed:[[[data objectAtIndex:indexPath.section] objectForKey:kClassesKey] objectAtIndex:indexPath.row]];
		
	cell.textLabel.text = [klass title];
//	cell.detailTextLabel.text = [row objectForKey:kDescriptionKey];
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	
    return cell;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	return [[data objectAtIndex:section] objectForKey:kTitleKey];
}


#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[self.tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	Class klass = [[NSBundle mainBundle] classNamed:[[[data objectAtIndex:indexPath.section] objectForKey:kClassesKey] objectAtIndex:indexPath.row]];
	UIViewController *viewController = [[klass alloc] init];
	[self.navigationController pushViewController:viewController animated:YES];
	[viewController release];
}

@end
