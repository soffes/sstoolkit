//
//  TCImagePickerDemoViewController.m
//  TWCatalog
//
//  Created by Sam Soffes on 11/11/09.
//  Copyright 2009 Tasteful Works, Inc. All rights reserved.
//

#import "TCImagePickerDemoViewController.h"

@implementation TCImagePickerDemoViewController

#pragma mark -
#pragma mark Class Methods
#pragma mark -

+ (TCImagePickerDemoViewController *)setup {
	return [[TCImagePickerDemoViewController alloc] initWithNibName:nil bundle:nil];
}


#pragma mark -
#pragma mark UIViewController
#pragma mark -

- (void)viewDidLoad {
    [super viewDidLoad];
	self.title = @"Image Picker";
	self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
}

@end
