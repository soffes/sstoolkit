//
//  SCAppDelegate.m
//  SSCatalog
//
//  Created by Sam Soffes on 9/21/09.
//  Copyright 2009 Sam Soffes, Inc. All rights reserved.
//

#import "SCAppDelegate.h"
#import "SCRootViewController.h"

@implementation SCAppDelegate

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
	
	SCRootViewController *viewController = [[SCRootViewController alloc] initWithStyle:UITableViewStyleGrouped];
	UINavigationController *aNavigationController = [[UINavigationController alloc] initWithRootViewController:viewController];

	self.navigationController = aNavigationController;

	[viewController release];
	[aNavigationController release];
	
	[window addSubview:navigationController.view];
    [window makeKeyAndVisible];
}

@end
