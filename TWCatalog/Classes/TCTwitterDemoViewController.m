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
	
	UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[button setTitle:@"Authorize" forState:UIControlStateNormal];
	[button setFrame:CGRectMake(20.0, 20.0, 280.0, 37.0)];
	[button addTarget:self action:@selector(authorize:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:button];
}


#pragma mark -
#pragma mark Actions
#pragma mark -

- (void)authorize:(id)sender {
	// *** Add your Twitter OAuth consumer key and secret here ***
	OAConsumer *consumer = nil; //[[OAConsumer alloc] initWithKey:@"your consumer key" secret:@"your consumer secret"];
	TWTwitterOAuthViewController *viewController = [[TWTwitterOAuthViewController alloc] initWithDelegate:self consumer:consumer];
	[consumer release];
	[self.navigationController presentModalViewController:viewController animated:YES];
	[viewController release];
}


#pragma mark -
#pragma mark TWTwitterOAuthViewControllerDelegate
#pragma mark -

- (void)twitterOAuthViewController:(TWTwitterOAuthViewController *)viewController didFailWithError:(NSError *)error {
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failed" message:[error localizedDescription] delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
	[alert show];
	[alert release];
}


- (void)twitterOAuthViewController:(TWTwitterOAuthViewController *)viewController didAuthorizeWithAccessToken:(OAToken *)accessToken userDictionary:(NSDictionary *)userDictionary {
	NSString *message = [NSString stringWithFormat:@"Successfuly received access token for %@", [[userDictionary objectForKey:@"user"] objectForKey:@"screen_name"]];
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
