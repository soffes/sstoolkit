//
//  SCGradientViewDemoViewController.m
//  SSCatalog
//
//  Created by Sam Soffes on 10/27/09.
//  Copyright 2009 Sam Soffes, Inc. All rights reserved.
//

#import "SCGradientViewDemoViewController.h"
#import <SSToolkit/SSGradientView.h>

@implementation SCGradientViewDemoViewController

#pragma mark -
#pragma mark Class Methods
#pragma mark -

+ (NSString *)title {
	return @"Gradient View";
}


#pragma mark -
#pragma mark NSObject
#pragma mark -

- (void)dealloc {
	[gradientView release];
	[super dealloc];
}


#pragma mark -
#pragma mark UIViewController
#pragma mark -

- (void)viewDidLoad {
	[super viewDidLoad];
	self.title = [[self class] title];
	self.view.backgroundColor = [UIColor whiteColor];
	
	// Gradient view
	gradientView = [[SSGradientView alloc] initWithFrame:CGRectMake(20.0, 20.0, 280.0, 280.0)];
	[self.view addSubview:gradientView];
	
	UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	button.frame = CGRectMake(20.0, 320.0, 280.0, 37.0);
	[button setTitle:@"Change Color" forState:UIControlStateNormal];
	[button addTarget:self action:@selector(changeColor:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:button];
	
}


#pragma mark -
#pragma mark Actions
#pragma mark -

- (void)changeColor:(id)sender {
	if ([gradientView.topColor isEqual:[SSGradientView defaultTopColor]]) {
		gradientView.topColor = [UIColor whiteColor];
		gradientView.bottomColor = [UIColor grayColor];
	} else {
		gradientView.topColor = [SSGradientView defaultTopColor];
		gradientView.bottomColor = [SSGradientView defaultBottomColor];
	}	
}

@end
