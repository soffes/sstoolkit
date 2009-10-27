//
//  TCGradientViewDemoViewController.m
//  TWCatalog
//
//  Created by Sam Soffes on 10/27/09.
//  Copyright 2009 Tasteful Works, Inc. All rights reserved.
//

#import "TCGradientViewDemoViewController.h"
#import "TWToolkit/TWGradientView.h"

@implementation TCGradientViewDemoViewController

#pragma mark -
#pragma mark Class Methods
#pragma mark -

+ (TCGradientViewDemoViewController *)setup {
	return [[TCGradientViewDemoViewController alloc] initWithNibName:nil bundle:nil];
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
	
	self.title = @"Gradient View";
	self.view.backgroundColor = [UIColor whiteColor];
	
	// Gradient view
	gradientView = [[TWGradientView alloc] initWithFrame:CGRectMake(20.0, 20.0, 280.0, 280.0)];
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
	gradientView.topColor = [gradientView.topColor isEqual:[UIColor redColor]] ? [UIColor colorWithRed:0.676 green:0.722 blue:0.765 alpha:1.0] : [UIColor redColor];
}

@end
