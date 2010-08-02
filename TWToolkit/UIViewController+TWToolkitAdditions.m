//
//  UIViewController+TWToolkitAdditions.m
//  TWToolkit
//
//  Created by Sam Soffes on 6/21/10.
//  Copyright 2010 Tasteful Works, Inc. All rights reserved.
//

#import "UIViewController+TWToolkitAdditions.h"

@implementation UIViewController (TWToolkitAdditions)

- (void)displayError:(NSError *)error {
	if (!error) {
		return;
	}
	
	[self displayErrorString:[error localizedDescription]];
}


- (void)displayErrorString:(NSString *)string {
	if (!string || [string length] < 1) {
		return;
	}
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:string delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alert show];
	[alert release];
}

@end
