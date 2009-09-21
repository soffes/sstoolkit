//
//  TWCatalogAppDelegate.m
//  TWCatalog
//
//  Created by Sam Soffes on 9/21/09.
//  Copyright 2009 Tasteful Works, Inc. All rights reserved.
//

#import "TWCatalogAppDelegate.h"
#import "WebViewCellViewController.h"

@implementation TWCatalogAppDelegate

@synthesize window;
@synthesize rootViewController;

#pragma mark -
#pragma mark NSObject
#pragma mark -

- (void)dealloc {
	[rootViewController release];
    [window release];
    [super dealloc];
}


#pragma mark -
#pragma mark UIApplicationDelegate
#pragma mark -

- (void)applicationDidFinishLaunching:(UIApplication *)application {    

    window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	
	WebViewCellViewController *viewController = [[WebViewCellViewController alloc] initWithStyle:UITableViewStyleGrouped];
	self.rootViewController = viewController;
	[viewController release];
	
	[window addSubview:self.rootViewController.view];
    [window makeKeyAndVisible];
}

@end
