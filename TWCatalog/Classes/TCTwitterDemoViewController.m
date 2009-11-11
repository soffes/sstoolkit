//
//  TCTwitterDemoViewController.m
//  TWCatalog
//
//  Created by Sam Soffes on 11/9/09.
//  Copyright 2009 Tasteful Works, Inc. All rights reserved.
//

#import "TCTwitterDemoViewController.h"
#import <TWToolkit/OAuthConsumer.h>

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
	
	UILabel *instructions = [[UILabel alloc] initWithFrame:CGRectMake(20.0, 20.0, 280.0, 140.0)];
	instructions.numberOfLines = 0;
	instructions.shadowColor = [UIColor whiteColor];
	instructions.shadowOffset = CGSizeMake(0.0, 1.0);
	instructions.backgroundColor = [UIColor clearColor];
	instructions.font = [UIFont systemFontOfSize:16.0];
	instructions.textColor = [UIColor colorWithRed:0.298 green:0.337 blue:0.424 alpha:1.0];
	instructions.text = @"Authorize Twitter with OAuth and get the user's object and access token without using their credentials directly.\n\n(Be sure to define the OAuth consumer variables in the demo view controller.)";
	[self.view addSubview:instructions];
	[instructions release];
	
	UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[button setTitle:@"Authorize with OAuth" forState:UIControlStateNormal];
	[button setFrame:CGRectMake(20.0, 180.0, 280.0, 37.0)];
	[button addTarget:self action:@selector(authorize:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:button];
}


#pragma mark -
#pragma mark Actions
#pragma mark -

- (void)authorize:(id)sender {
	// *** Add your Twitter OAuth consumer key and secret here ***
	OAConsumer *consumer = nil;// [[OAConsumer alloc] initWithKey:@"your consumer key" secret:@"your consumer secret"];
	TWTwitterOAuthViewController *viewController = [[TWTwitterOAuthViewController alloc] initWithDelegate:self consumer:consumer];
	[consumer release];
	[self.navigationController presentModalViewController:viewController animated:YES];
	[viewController release];
}


#pragma mark -
#pragma mark TWTwitterOAuthViewControllerDelegate
#pragma mark -

- (void)twitterOAuthViewControllerDidCancel:(TWTwitterOAuthViewController *)viewController {
	[self.navigationController dismissModalViewControllerAnimated:YES];
}


- (void)twitterOAuthViewController:(TWTwitterOAuthViewController *)viewController didFailWithError:(NSError *)error {
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failed" message:[error localizedDescription] delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
	[alert show];
	[alert release];
}


- (void)twitterOAuthViewController:(TWTwitterOAuthViewController *)viewController didAuthorizeWithAccessToken:(OAToken *)accessToken userDictionary:(NSDictionary *)userDictionary {
	NSString *message = [NSString stringWithFormat:@"Successfuly received access token for %@!", [userDictionary objectForKey:@"screen_name"]];
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success!" message:message delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
	[alert show];
	[alert release];
}


#pragma mark -
#pragma mark UIAlertViewDelegate
#pragma mark -

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
	[self.navigationController dismissModalViewControllerAnimated:YES];
}

@end
