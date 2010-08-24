//
//  SCHUDViewDemoViewController.m
//  SSCatalog
//
//  Created by Sam Soffes on 11/18/09.
//  Copyright 2009 Sam Soffes, Inc. All rights reserved.
//

#import "SCHUDViewDemoViewController.h"
#import <SSToolkit/SSToolkit.h>

@implementation SCHUDViewDemoViewController

#pragma mark Class Methods

+ (NSString *)title {
	return @"HUD View";
}


#pragma mark NSObject

- (void)dealloc {
	[hud release];
	[super dealloc];
}


#pragma mark UIViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	self.title = [[self class] title];
	
	self.view.backgroundColor = [UIColor whiteColor];
	
	// Show HUD
	hud = [[SSHUDView alloc] initWithTitle:@"Custom Message"];
	[hud show];
	
	// After 2 seconds, complete action
	[self performSelector:@selector(complete:) withObject:nil afterDelay:2.0];
}


#pragma mark Actions

- (void)complete:(id)sender {
	[hud completeWithTitle:@"Finished!"];
	[self performSelector:@selector(pop:) withObject:nil afterDelay:0.7];
}


- (void)pop:(id)sender {
	[hud dismiss];
	[self.navigationController popViewControllerAnimated:YES];
}

@end
