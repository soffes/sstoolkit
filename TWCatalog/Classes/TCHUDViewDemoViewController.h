//
//  TCHUDViewDemoViewController.h
//  TWCatalog
//
//  Created by Sam Soffes on 11/18/09.
//  Copyright 2009 Tasteful Works, Inc. All rights reserved.
//

@class TWHUDView;

@interface TCHUDViewDemoViewController : UIViewController {

	TWHUDView *hud;
}

+ (NSString *)title;
+ (TCHUDViewDemoViewController *)setup;

- (void)complete:(id)sender;
- (void)pop:(id)sender;

@end
