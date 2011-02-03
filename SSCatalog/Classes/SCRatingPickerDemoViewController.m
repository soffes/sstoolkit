//
//  SCRatingPickerDemoViewController.m
//  SSCatalog
//
//  Created by Sam Soffes on 2/2/11.
//  Copyright 2011 Sam Soffes. All rights reserved.
//

#import "SCRatingPickerDemoViewController.h"
#import <SSToolkit/SSRatingPicker.h>

@implementation SCRatingPickerDemoViewController

#pragma mark Class Methods

+ (NSString *)title {
	return @"Rating Picker";
}


#pragma mark UIViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	self.title = [[self class] title];
	self.view.backgroundColor = [UIColor whiteColor];
	
	SSRatingPicker *selector = [[SSRatingPicker alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 48.0f)];
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
