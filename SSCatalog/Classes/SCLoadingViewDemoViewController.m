//
//  SCLoadingViewDemoViewController.m
//  SSCatalog
//
//  Created by Sam Soffes on 11/15/10.
//  Copyright 2010 Sam Soffes. All rights reserved.
//

#import "SCLoadingViewDemoViewController.h"
#import <SSToolkit/SSLoadingView.h>

@implementation SCLoadingViewDemoViewController

#pragma mark Class Methods

+ (NSString *)title {
	return @"Loading View";
}


#pragma mark UIViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	self.title = [[self class] title];
	self.view.backgroundColor = [UIColor colorWithRed:0.851 green:0.859 blue:0.882 alpha:1.0];
	
	CGSize size = self.view.frame.size;
	
	SSLoadingView *loadingView = [[SSLoadingView alloc] initWithFrame:CGRectMake(0.0, 0.0, size.width, size.height)];
	[self.view addSubview:loadingView];
	[loadingView release];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
		return toInterfaceOrientation != UIInterfaceOrientationPortraitUpsideDown;
	}
	return YES;
}


@end
