//
//  TCImageViewDemoViewController.m
//  TWCatalog
//
//  Created by Sam Soffes on 10/9/09.
//  Copyright 2009 Tasteful Works, Inc. All rights reserved.
//

#import "TCImageViewDemoViewController.h"
#import "TWToolkit/TWLoadingView.h"
#import "TWToolkit/UIView+fading.h"

@implementation TCImageViewDemoViewController

#pragma mark -
#pragma mark Class Methods
#pragma mark -

+ (TCImageViewDemoViewController *)setup {
	return [[TCImageViewDemoViewController alloc] initWithNibName:nil bundle:nil];
}


#pragma mark -
#pragma mark NSObject
#pragma mark -

- (void)dealloc {
	[imageView release];
	[loadingView release];
	[super dealloc];
}


#pragma mark -
#pragma mark UIViewController
#pragma mark -

- (void)viewDidLoad {
	[super viewDidLoad];
	
	self.title = @"Image View";
	self.view.backgroundColor = [UIColor whiteColor];
	
	imageView = [[TWImageView alloc] initWithFrame:CGRectMake(20.0, 20.0, 280.0, 280.0)];
	imageView.placeholderImageView.image = [UIImage imageNamed:@"placeholder.png"];
	imageView.URL = [NSURL URLWithString:@"http://farm3.static.flickr.com/2421/3534460712_3930f69415.jpg"];
	[self.view addSubview:imageView];
	
	loadingView  = [[TWLoadingView alloc] initWithFrame:CGRectMake(20.0, 340.0, 280.0, 20.0)];
	[self.view addSubview:loadingView];
}


#pragma mark -
#pragma mark TWImageViewDelegate
#pragma mark -

- (void)connection:(TWConnection *)aConnection didReceiveBytes:(NSInteger)receivedBytes totalReceivedBytes:(NSInteger)totalReceivedBytes totalExpectedBytes:(NSInteger)totalExpectedBytes {
	NSLog(@"receivedBytes: %i, totalReceivedBytes: %i, totalExpectedBytes: %i", receivedBytes, totalReceivedBytes, totalExpectedBytes);
}


- (void)connection:(TWConnection *)aConnection didFinishLoadingRequest:(NSURLRequest *)aRequest withResult:(id)result {
	[loadingView fadeOut];
}


- (void)connection:(TWConnection *)aConnection failedWithError:(NSError *)error {	
	[loadingView fadeOut];
	
	// Display alert error
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Loading the image failed. Maybe try again later." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alert show];
	[alert release];
}
@end
