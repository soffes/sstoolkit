//
//  TCTwitterDemoViewController.m
//  TWCatalog
//
//  Created by Sam Soffes on 11/9/09.
//  Copyright 2009 Tasteful Works, Inc. All rights reserved.
//

#import "TCTwitterDemoViewController.h"

@implementation TCTwitterDemoViewController

#pragma mark -
#pragma mark Class Methods
#pragma mark -

+ (TCTwitterDemoViewController *)setup {
	return [[TCTwitterDemoViewController alloc] initWithNibName:nil bundle:nil];
}


#pragma mark -
#pragma mark UIViewController
#pragma mark -

- (void)viewDidLoad {
    [super viewDidLoad];
	self.title = @"Twitter OAuth";
	self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
}

@end
