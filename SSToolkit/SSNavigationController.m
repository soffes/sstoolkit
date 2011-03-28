//
//  SSNavigationController.m
//  SSToolkit
//
//  Created by Sam Soffes on 10/15/10.
//  Copyright 2010-2011 Sam Soffes. All rights reserved.
//

#import "SSNavigationController.h"
#import "SSViewController.h"

@implementation SSNavigationController

@synthesize modalParentViewController = _modalParentViewController;
@synthesize dismissCustomModalOnVignetteTap = _dismissCustomModalOnVignetteTap;
@synthesize contentSizeForViewInCustomModal = _contentSizeForViewInCustomModal;
@synthesize originOffsetForViewInCustomModal = _originOffsetForViewInCustomModal;

- (void) viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];

	// Move nav bar up. This makes me cry.
	if (self.modalParentViewController) {
		UIView *navBar = [[self.view subviews] objectAtIndex:1];
		navBar.frame = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, 44.0f);
	}
}

@end
