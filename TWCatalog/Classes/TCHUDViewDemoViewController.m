//
//  TCHUDViewDemoViewController.m
//  TWCatalog
//
//  Created by Sam Soffes on 11/18/09.
//  Copyright 2009 Tasteful Works, Inc. All rights reserved.
//

#import "TCHUDViewDemoViewController.h"
#import <TWToolkit/TWToolkit.h>

@implementation TCHUDViewDemoViewController

#pragma mark -
#pragma mark Class Methods
#pragma mark -

+ (NSString *)title {
	return @"HUD View";
}


+ (TCHUDViewDemoViewController *)setup {
	return [[TCHUDViewDemoViewController alloc] initWithNibName:nil bundle:nil];
}


#pragma mark -
#pragma mark NSObject
#pragma mark -

- (void)dealloc {
	[hud release];
	[super dealloc];
}


#pragma mark -
#pragma mark UIViewController
#pragma mark -

- (void)viewDidLoad {
	[super viewDidLoad];
	
	self.view.backgroundColor = [UIColor whiteColor];
	
	// Show hud
	hud = [[TWHUDView alloc] init];
	[hud show];
	
	// After 3 seconds, pop
	[self performSelector:@selector(pop:) withObject:nil afterDelay:3.0];
}


#pragma mark -
#pragma mark Actions
#pragma mark -

- (void)pop:(id)sender {
	[hud dismiss];
	[self.navigationController popViewControllerAnimated:YES];
}

@end
