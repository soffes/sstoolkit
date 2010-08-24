    //
//  SCPieProgressViewDemoViewController.m
//  SSCatalog
//
//  Created by Sam Soffes on 4/22/10.
//  Copyright 2010 Sam Soffes, Inc. All rights reserved.
//

#import "SCPieProgressViewDemoViewController.h"
#import <SSToolkit/SSToolkit.h>

@implementation SCPieProgressViewDemoViewController

#pragma mark Class Methods

+ (NSString *)title {
	return @"Pie Progress View";
}


#pragma mark UIViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	self.title = [[self class] title];
	self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
	
	SSPieProgressView *progressView1 = [[SSPieProgressView alloc] initWithFrame:CGRectMake(20.0, 20.0, 55.0, 55.0)];
	progressView1.progress = 0.25;
	[self.view addSubview:progressView1];
	[progressView1 release];
	
	SSPieProgressView *progressView2 = [[SSPieProgressView alloc] initWithFrame:CGRectMake(95.0, 20.0, 55.0, 55.0)];
	progressView2.progress = 0.50;
	[self.view addSubview:progressView2];
	[progressView2 release];
	
	SSPieProgressView *progressView3 = [[SSPieProgressView alloc] initWithFrame:CGRectMake(170.0, 20.0, 55.0, 55.0)];
	progressView3.progress = 0.75;
	[self.view addSubview:progressView3];
	[progressView3 release];
	
	SSPieProgressView *progressView4 = [[SSPieProgressView alloc] initWithFrame:CGRectMake(245.0, 20.0, 55.0, 55.0)];
	progressView4.progress = 1.0;
	[self.view addSubview:progressView4];
	[progressView4 release];
	
	SSPieProgressView *progressView5 = [[SSPieProgressView alloc] initWithFrame:CGRectMake(20.0, 95.0, 130.0, 130.0)];
	progressView5.progress = 0.33;
	[self.view addSubview:progressView5];
	[progressView5 release];
	
	SSPieProgressView *progressView6 = [[SSPieProgressView alloc] initWithFrame:CGRectMake(170.0, 95.0, 130.0, 130.0)];
	progressView6.progress = 0.66;
	[self.view addSubview:progressView6];
	[progressView6 release];
	
	_progressView7 = [[SSPieProgressView alloc] initWithFrame:CGRectMake(95.0, 245.0, 130.0, 130.0)];
	[self.view addSubview:_progressView7];
	[_progressView7 release];
	
	_timer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(incrementProgress:) userInfo:nil repeats:YES];
}


- (void)viewDidUnload {
	[super viewDidUnload];
	[_timer invalidate];
}


#pragma mark Timer

- (void)incrementProgress:(NSTimer *)timer {
	_progressView7.progress = _progressView7.progress + 0.01;
	if (_progressView7.progress == 1.0) {
		_progressView7.progress = 0.0;
	}
}

@end
