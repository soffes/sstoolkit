//
//  TCPieProgressViewDemoViewController.h
//  TWCatalog
//
//  Created by Sam Soffes on 4/22/10.
//  Copyright 2010 Tasteful Works, Inc. All rights reserved.
//

@class TWPieProgressView;

@interface TCPieProgressViewDemoViewController : UIViewController {

	TWPieProgressView *progressView7;
	NSTimer *timer;
}

+ (NSString *)title;

- (void)incrementProgress:(NSTimer *)timer;

@end
