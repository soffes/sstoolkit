//
//  TCRemoteImageViewDemoViewController.m
//  TWCatalog
//
//  Created by Sam Soffes on 10/9/09.
//  Copyright 2009 Tasteful Works, Inc. All rights reserved.
//

#import "TCRemoteImageViewDemoViewController.h"
#import "TWToolkit/TWToolkit.h"
#import "TWToolkit/UIView+fading.h"

@implementation TCRemoteImageViewDemoViewController

#pragma mark -
#pragma mark Class Methods
#pragma mark -

+ (TCRemoteImageViewDemoViewController *)setup {
	return [[TCRemoteImageViewDemoViewController alloc] initWithNibName:nil bundle:nil];
}


#pragma mark -
#pragma mark NSObject
#pragma mark -

- (void)dealloc {
//	[remoteImageView release];
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
	
//	remoteImageView = [[TWRemoteImageView alloc] initWithFrame:CGRectMake(20.0, 20.0, 280.0, 280.0)];
//	remoteImageView.delegate = self;
//	remoteImageView.placeholderImageView.image = [UIImage imageNamed:@"placeholder.png"];
//	remoteImageView.URL = [NSURL URLWithString:@"http://farm3.static.flickr.com/2421/3534460712_3930f69415.jpg"];
//	[self.view addSubview:remoteImageView];
	
	loadingView  = [[TWLoadingView alloc] initWithFrame:CGRectMake(20.0, 340.0, 280.0, 20.0)];
	[self.view addSubview:loadingView];
}


#pragma mark -
#pragma mark TWImageViewDelegate
#pragma mark -

//- (void)remoteImageViewDidStartLoading:(TWRemoteImageView*)aRemoteImageView {
//	NSLog(@"Started loading image");
//}
//
//
//- (void)remoteImageView:(TWRemoteImageView*)aRemoteImageView didLoadImage:(UIImage*)image {
//	[loadingView fadeOut];
//}
//
//
//- (void)remoteImageView:(TWRemoteImageView*)aRemoteImageView didFailWithError:(NSError*)error {
//	[loadingView fadeOut];
//	
//	// Display alert error
//	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"The image failed to load. Maybe try again later." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//	[alert show];
//	[alert release];
//}

@end
