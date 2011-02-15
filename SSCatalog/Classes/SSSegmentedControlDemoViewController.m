//
//  SSSegmentedControlDemoViewController.m
//  SSCatalog
//
//  Created by Sam Soffes on 2/14/11.
//  Copyright 2011 Sam Soffes. All rights reserved.
//

#import "SSSegmentedControlDemoViewController.h"
#import <SSToolkit/SSSegmentedControl.h>

@implementation SSSegmentedControlDemoViewController

#pragma mark Class Methods

+ (NSString *)title {
	return @"Segmented Control";
}


#pragma mark UIViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	self.title = [[self class] title];
	self.view.backgroundColor = [UIColor colorWithRed:0.851f green:0.859f blue:0.882f alpha:1.0f];
	
	UIFont *labelFont = [UIFont boldSystemFontOfSize:15.0f];
	NSArray *items = [NSArray arrayWithObjects:@"Apples", @"Oranges", @"Grapes", nil];
	
	// System segmented control
	UILabel *systemLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 20.0f, 280.0f, 20.0f)];
	systemLabel.text = @"UISegmentedControl";
	systemLabel.font = labelFont;
	systemLabel.backgroundColor = self.view.backgroundColor;
	systemLabel.shadowColor = [UIColor whiteColor];
	systemLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
	[self.view addSubview:systemLabel];
	[systemLabel release];
	
	UISegmentedControl *systemSegmentedControl = [[UISegmentedControl alloc] initWithItems:items];
	systemSegmentedControl.frame = CGRectMake(20.0f, 50.0f, 280.0f, 32.0f);
	systemSegmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
	systemSegmentedControl.selectedSegmentIndex = 0;
	[self.view addSubview:systemSegmentedControl];
	[systemSegmentedControl release];
	
	// Custom segmented control
	UILabel *customLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 107.0f, 280.0f, 20.0f)];
	customLabel.text = @"SSSegmentedControl";
	customLabel.font = labelFont;
	customLabel.backgroundColor = self.view.backgroundColor;
	customLabel.shadowColor = [UIColor whiteColor];
	customLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
	[self.view addSubview:customLabel];
	[customLabel release];
	
	SSSegmentedControl *customSegmentedControl = [[SSSegmentedControl alloc] initWithItems:items];
	customSegmentedControl.frame = CGRectMake(20.0f, 50.0f, 280.0f, 32.0f);
	customSegmentedControl.selectedSegmentIndex = 0;
	[self.view addSubview:customSegmentedControl];
	[customSegmentedControl release];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
		return toInterfaceOrientation != UIInterfaceOrientationPortraitUpsideDown;
	}
	return YES;
}

@end
