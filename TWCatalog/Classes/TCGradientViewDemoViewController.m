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
#pragma mark UIViewController
#pragma mark -

- (void)viewDidLoad {
	[super viewDidLoad];
	
	self.title = @"Gradient View";
	self.view.backgroundColor = [UIColor whiteColor];
	
	// Gradient view
	TWGradientView *gradientView = [[TWGradientView alloc] initWithFrame:CGRectMake(20.0, 20.0, 280.0, 280.0)];
	[self.view addSubview:gradientView];
	[gradientView release];
	
}

@end
