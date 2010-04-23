    //
//  TCPieProgressViewDemoViewController.m
//  TWCatalog
//
//  Created by Sam Soffes on 4/22/10.
//  Copyright 2010 Tasteful Works, Inc. All rights reserved.
//

#import "TCPieProgressViewDemoViewController.h"
#import <TWToolkit/TWToolkit.h>

@implementation TCPieProgressViewDemoViewController

#pragma mark -
#pragma mark Class Methods
#pragma mark -

+ (NSString *)title {
	return @"Pie Progress View";
}

#pragma mark -
#pragma mark UIViewController
#pragma mark -

- (void)viewDidLoad {
	[super viewDidLoad];
	self.title = [[self class] title];
	self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
	
	TWPieProgressView *progressView1 = [[TWPieProgressView alloc] initWithFrame:CGRectMake(20.0, 20.0, 55.0, 55.0)];
	progressView1.progress = 0.25;
	[self.view addSubview:progressView1];
	[progressView1 release];
	
	TWPieProgressView *progressView2 = [[TWPieProgressView alloc] initWithFrame:CGRectMake(95.0, 20.0, 55.0, 55.0)];
	progressView2.progress = 0.50;
	[self.view addSubview:progressView2];
	[progressView2 release];
	
	TWPieProgressView *progressView3 = [[TWPieProgressView alloc] initWithFrame:CGRectMake(170.0, 20.0, 55.0, 55.0)];
	progressView3.progress = 0.75;
	[self.view addSubview:progressView3];
	[progressView3 release];
	
	TWPieProgressView *progressView4 = [[TWPieProgressView alloc] initWithFrame:CGRectMake(245.0, 20.0, 55.0, 55.0)];
	progressView4.progress = 1.0;
	[self.view addSubview:progressView4];
	[progressView4 release];
	
	TWPieProgressView *progressView5 = [[TWPieProgressView alloc] initWithFrame:CGRectMake(20.0, 95.0, 130.0, 130.0)];
	progressView5.progress = 0.33;
	[self.view addSubview:progressView5];
	[progressView5 release];
	
	TWPieProgressView *progressView6 = [[TWPieProgressView alloc] initWithFrame:CGRectMake(170.0, 95.0, 130.0, 130.0)];
	progressView6.progress = 0.66;
	[self.view addSubview:progressView6];
	[progressView6 release];
	
	progressView7 = [[TWPieProgressView alloc] initWithFrame:CGRectMake(95.0, 245.0, 130.0, 130.0)];
	[self.view addSubview:progressView7];
	[progressView7 release];
	
	timer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(incrementProgress:) userInfo:nil repeats:YES];
}


- (void)viewDidUnload {
	[super viewDidUnload];
	[timer invalidate];
}


#pragma mark -
#pragma mark Timer
#pragma mark -

- (void)incrementProgress:(NSTimer *)timer {
	progressView7.progress = progressView7.progress + 0.01;
	if (progressView7.progress == 1.0) {
		progressView7.progress = 0.0;
	}
}

@end
