//
//  SSSegmentedControlDemoViewController.m
//  SSCatalog
//
//  Created by Sam Soffes on 2/14/11.
//  Copyright 2011 Sam Soffes. All rights reserved.
//

#import "SSSegmentedControlDemoViewController.h"

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
}

@end
