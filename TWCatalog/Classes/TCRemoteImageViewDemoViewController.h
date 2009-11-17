//
//  TCRemoteImageViewDemoViewController.h
//  TWCatalog
//
//  Created by Sam Soffes on 10/9/09.
//  Copyright 2009 Tasteful Works, Inc. All rights reserved.
//

#import <TWToolkit/TWToolkit.h>

@interface TCRemoteImageViewDemoViewController : UIViewController <TWRemoteImageViewDelegate> {

	TWRemoteImageView *remoteImageView;
	TWLoadingView *loadingView;
}

+ (NSString *)title;
+ (TCRemoteImageViewDemoViewController *)setup;

@end
