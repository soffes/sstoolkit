//
//  TCLineViewDemoViewController.m
//  TWCatalog
//
//  Created by Sam Soffes on 4/19/10.
//  Copyright 2010 Tasteful Works, Inc. All rights reserved.
//

#import "TCLineViewDemoViewController.h"
#import <TWToolkit/TWToolkit.h>

@implementation TCLineViewDemoViewController

#pragma mark -
#pragma mark Class Methods
#pragma mark -

+ (NSString *)title {
	return @"Line View";
}


#pragma mark -
#pragma mark UIViewController
#pragma mark -

- (void)viewDidLoad {
    [super viewDidLoad];
	self.title = @"Line View";
	self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
	
	TWLineView *lineView = [[TWLineView alloc] initWithFrame:CGRectMake(20.0, 20.0, 280.0, 2.0)];
	[self.view addSubview:lineView];
	[lineView release];
}

@end
