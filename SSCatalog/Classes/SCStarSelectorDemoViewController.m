//
//  SCStarSelectorDemoViewController.m
//  SSCatalog
//
//  Created by Sam Soffes on 2/2/11.
//  Copyright 2011 Sam Soffes. All rights reserved.
//

#import "SCStarSelectorDemoViewController.h"
#import <SSToolkit/SSStarsSelector.h>

@implementation SCStarSelectorDemoViewController

#pragma mark Class Methods

+ (NSString *)title {
	return @"Star Selector";
}


#pragma mark UIViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	self.title = [[self class] title];
	self.view.backgroundColor = [UIColor whiteColor];
	
	SSStarsSelector *selector = [[SSStarsSelector alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 48.0f)];
	selector.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
	[self.view addSubview:selector];
	[selector release];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
		return toInterfaceOrientation != UIInterfaceOrientationPortraitUpsideDown;
	}
	return YES;
}

@end
