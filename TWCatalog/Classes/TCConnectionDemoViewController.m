//
//  TCConnectionDemoViewController.m
//  TWCatalog
//
//  Created by Sam Soffes on 10/9/09.
//  Copyright 2009 Tasteful Works, Inc. All rights reserved.
//

#import "TCConnectionDemoViewController.h"

@implementation TCConnectionDemoViewController

#pragma mark -
#pragma mark Class Methods
#pragma mark -

+ (TCConnectionDemoViewController *)setup {
	return [[TCConnectionDemoViewController alloc] initWithNibName:nil bundle:nil];
}


#pragma mark -
#pragma mark NSObject
#pragma mark -

- (void)dealloc {
	[outputView release];
	[super dealloc];
}


#pragma mark -
#pragma mark UIViewController
#pragma mark -

- (void)loadView {
	[super loadView];
	
	outputView = [[UITextView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width, self.view.frame.size.height)];
	outputView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	[self.view addSubview:outputView];
}


- (void)viewDidLoad {
	
	self.title = @"Connection";
	
	UIBarButtonItem *refreshButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refresh:)];
	self.navigationItem.rightBarButtonItem = refreshButton;
	[refreshButton release];
	
	[self refresh:nil];
}


#pragma mark -
#pragma mark Actions
#pragma mark -

- (IBAction)refresh:(id)sender {
	
	// Update output
	outputView.text = @"Connecting...";
	
	// Start connection
	NSURL *url = [[NSURL alloc] initWithString:@"http://twitter.com/statuses/user_timeline/samsoffes.json?count=5"];
	TWConnection *connection =  [[[TWConnection alloc] initWithDelegate:self] autorelease];
	connection.dataType = TWConnectionDataTypeJSONArray;
	[connection requestURL:url];
	[url release];
}


#pragma mark -
#pragma mark TWConnectionDelegate
#pragma mark -

- (void)connection:(TWConnection *)aConnection startedLoadingRequest:(NSURLRequest *)aRequest {
	outputView.text = @"Loading...";
}


- (void)connection:(TWConnection *)aConnection didReceiveBytes:(NSInteger)receivedBytes totalReceivedBytes:(NSInteger)totalReceivedBytes totalExpectedBytes:(NSInteger)totalExpectedBytes {
	NSLog(@"receivedBytes: %i, totalReceivedBytes: %i, totalExpectedBytes: %i", receivedBytes, totalReceivedBytes, totalExpectedBytes);
}


- (void)connection:(TWConnection *)aConnection didFinishLoadingRequest:(NSURLRequest *)aRequest withResult:(id)result {
	outputView.text = [(NSArray *)result description];
}


- (void)connection:(TWConnection *)aConnection failedWithError:(NSError *)error {	
	outputView.text = @"";
	
	// Display alert error
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"The request failed. Maybe try again later." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alert show];
	[alert release];
}

@end
