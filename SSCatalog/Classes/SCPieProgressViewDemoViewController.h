//
//  SCPieProgressViewDemoViewController.h
//  SSCatalog
//
//  Created by Sam Soffes on 4/22/10.
//  Copyright 2010 Sam Soffes, Inc. All rights reserved.
//

@class SSPieProgressView;

@interface SCPieProgressViewDemoViewController : UIViewController {

	SSPieProgressView *progressView7;
	NSTimer *timer;
}

+ (NSString *)title;

- (void)incrementProgress:(NSTimer *)timer;

@end
