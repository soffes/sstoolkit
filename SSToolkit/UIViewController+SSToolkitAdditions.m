//
//  UIViewController+SSToolkitAdditions.m
//  SSToolkit
//
//  Created by Sam Soffes on 6/21/10.
//  Copyright 2010-2011 Sam Soffes. All rights reserved.
//

#import "UIViewController+SSToolkitAdditions.h"

@implementation UIViewController (SSToolkitAdditions)

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
}

@end
