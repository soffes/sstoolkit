//
//  TCRemoteImageViewDemoViewController.h
//  TWCatalog
//
//  Created by Sam Soffes on 10/9/09.
//  Copyright 2009 Tasteful Works, Inc. All rights reserved.
//

//@class TWRemoteImageView;
@class TWLoadingView;
//@protocol TWRemoteImageViewDelegate;

@interface TCRemoteImageViewDemoViewController : UIViewController {// <TWRemoteImageViewDelegate> {

	//TWRemoteImageView *remoteImageView;
	TWLoadingView *loadingView;
}

+ (TCRemoteImageViewDemoViewController *)setup;

@end
