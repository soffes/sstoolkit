//
//  TWCatalogAppDelegate.h
//  TWCatalog
//
//  Created by Sam Soffes on 9/21/09.
//  Copyright 2009 Tasteful Works, Inc. All rights reserved.
//

@class WebViewCellViewController;

@interface TWCatalogAppDelegate : NSObject <UIApplicationDelegate> {
    
	UIWindow *window;
	WebViewCellViewController *rootViewController;
}

@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) UIViewController *rootViewController;

@end

