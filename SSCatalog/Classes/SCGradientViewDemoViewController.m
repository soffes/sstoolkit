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

#pragma mark Class Methods

+ (NSString *)title {
	return @"Gradient View";
}


#pragma mark NSObject

- (void)dealloc {
	[_gradientView release];
	[super dealloc];
}


#pragma mark UIViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	self.title = [[self class] title];
	self.view.backgroundColor = [UIColor whiteColor];
	
	// Gradient view
	_gradientView = [[SSGradientView alloc] initWithFrame:CGRectMake(20.0, 20.0, 280.0, 280.0)];
	[self.view addSubview:_gradientView];
	
	UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	button.frame = CGRectMake(20.0, 320.0, 280.0, 37.0);
	[button setTitle:@"Change Color" forState:UIControlStateNormal];
	[button addTarget:self action:@selector(changeColor:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:button];
	
}


#pragma mark Actions

- (void)changeColor:(id)sender {
	if ([_gradientView.topColor isEqual:[SSGradientView defaultTopColor]]) {
		_gradientView.topColor = [UIColor whiteColor];
		_gradientView.bottomColor = [UIColor grayColor];
	} else {
		_gradientView.topColor = [SSGradientView defaultTopColor];
		_gradientView.bottomColor = [SSGradientView defaultBottomColor];
	}	
}

@end
