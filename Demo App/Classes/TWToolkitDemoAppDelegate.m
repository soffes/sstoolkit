//
//  TWToolkitDemoAppDelegate.m
//  TWToolkitDemo
//
//  Created by Sam Soffes on 9/21/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "TWToolkitDemoAppDelegate.h"

@implementation TWToolkitDemoAppDelegate

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
