//
//  TCAppDelegate.m
//  TWCatalog
//
//  Created by Sam Soffes on 9/21/09.
//  Copyright 2009 Tasteful Works, Inc. All rights reserved.
//

#import "TCAppDelegate.h"
#import "TCRootViewController.h"

@implementation TCAppDelegate

@synthesize window;
@synthesize navigationController;

#pragma mark -
#pragma mark NSObject
#pragma mark -

- (void)dealloc {
	[navigationController release];
    [window release];
    [super dealloc];
}


#pragma mark -
#pragma mark UIApplicationDelegate
#pragma mark -

- (void)applicationDidFinishLaunching:(UIApplication *)application {    

    window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	
	TCRootViewController *viewController = [[TCRootViewController alloc] initWithStyle:UITableViewStylePlain];
	UINavigationController *aNavigationController = [[UINavigationController alloc] initWithRootViewController:viewController];

	self.navigationController = aNavigationController;

	[viewController release];
	[aNavigationController release];
	
	[window addSubview:navigationController.view];
    [window makeKeyAndVisible];
}

@end
