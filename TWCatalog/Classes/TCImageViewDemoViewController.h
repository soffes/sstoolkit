//
//  TCImageViewDemoViewController.h
//  TWCatalog
//
//  Created by Sam Soffes on 10/9/09.
//  Copyright 2009 Tasteful Works, Inc. All rights reserved.
//

#import "TWToolkit/TWImageView.h"

@class TWLoadingView;

@interface TCImageViewDemoViewController : UIViewController <TWImageViewDelegate> {

	TWImageView *imageView;
	TWLoadingView *loadingView;
}

+ (TCImageViewDemoViewController *)setup;

@end
