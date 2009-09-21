//
//  TWCatalogAppDelegate.m
//  TWCatalog
//
//  Created by Sam Soffes on 9/21/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "TWCatalogAppDelegate.h"

@implementation TWCatalogAppDelegate

@synthesize window;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    

    // Override point for customization after application launch
    [window makeKeyAndVisible];
}


- (void)dealloc {
    [window release];
    [super dealloc];
}


@end
