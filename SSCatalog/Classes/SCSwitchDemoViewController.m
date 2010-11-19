//
//  SCSwitchDemoViewController.m
//  SSCatalog
//
//  Created by Sam Soffes on 11/19/10.
//  Copyright 2010 Sam Soffes. All rights reserved.
//

#import "SCSwitchDemoViewController.h"

@implementation SCSwitchDemoViewController

#pragma mark Class Methods

+ (NSString *)title {
	return @"Switch";
}


#pragma mark UIViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	self.title = [[self class] title];
	self.view.backgroundColor = [UIColor colorWithRed:0.851 green:0.859 blue:0.882 alpha:1.0];
	
	// System switch
	UILabel *systemLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0, 20.0, 280.0, 20.0)];
	systemLabel.text = @"Standard UISwitch";
	systemLabel.font = [UIFont boldSystemFontOfSize:15.0];
	systemLabel.backgroundColor = self.view.backgroundColor;
	[self.view addSubview:systemLabel];
	[systemLabel release];
	
	UISwitch *systemOffSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(20.0, 50.0, 94.0, 27.0)];
	[self.view addSubview:systemOffSwitch];
	[systemOffSwitch release];
	
	UISwitch *systemOnSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(134.0, 50.0, 94.0, 27.0)];
	systemOnSwitch.on = YES;
	[self.view addSubview:systemOnSwitch];
	[systemOnSwitch release];
	
	// Default style
	UILabel *defaultLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0, 107.0, 280.0, 20.0)];
	defaultLabel.text = @"SSSwitchStyleDefault";
	defaultLabel.font = [UIFont boldSystemFontOfSize:15.0];
	defaultLabel.backgroundColor = self.view.backgroundColor;
	[self.view addSubview:defaultLabel];
	[defaultLabel release];
	
	SSSwitch *defaultOffSwitch = [[SSSwitch alloc] initWithFrame:CGRectMake(20.0, 137.0, 94.0, 27.0)];
	[self.view addSubview:defaultOffSwitch];
	[defaultOffSwitch release];
	
	SSSwitch *defaultOnSwitch = [[SSSwitch alloc] initWithFrame:CGRectMake(134.0, 137.0, 94.0, 27.0)];
	defaultOnSwitch.on = YES;
	[self.view addSubview:defaultOnSwitch];
	[defaultOnSwitch release];
	
	// Airplane mode style
	UILabel *airplaneLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0, 194.0, 280.0, 20.0)];
	airplaneLabel.text = @"SSSwitchStyleAirplane";
	airplaneLabel.font = [UIFont boldSystemFontOfSize:15.0];
	airplaneLabel.backgroundColor = self.view.backgroundColor;
	[self.view addSubview:airplaneLabel];
	[airplaneLabel release];
	
	SSSwitch *airplaneOffSwitch = [[SSSwitch alloc] initWithFrame:CGRectMake(20.0, 224.0, 94.0, 27.0)];
	airplaneOffSwitch.style = SSSwitchStyleAirplane;
	[self.view addSubview:airplaneOffSwitch];
	[airplaneOffSwitch release];
	
	SSSwitch *airplaneOnSwitch = [[SSSwitch alloc] initWithFrame:CGRectMake(134.0, 224.0, 94.0, 27.0)];
	airplaneOnSwitch.style = SSSwitchStyleAirplane;
	airplaneOnSwitch.on = YES;
	[self.view addSubview:airplaneOnSwitch];
	[airplaneOnSwitch release];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
		return toInterfaceOrientation != UIInterfaceOrientationPortraitUpsideDown;
	}
	return YES;
}

@end
