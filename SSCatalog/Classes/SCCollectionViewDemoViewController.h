//
//  SCCollectionViewDemoViewController.h
//  SSCatalog
//
//  Created by Sam Soffes on 8/24/10.
//  Copyright 2010 Sam Soffes. All rights reserved.
//

#import <SSToolkit/SSToolkit.h>

@interface SCCollectionViewDemoViewController : UIViewController <SSCollectionViewDataSource, SSCollectionViewDelegate> {

	SSCollectionView *_collectionView;
}

+ (NSString *)title;

@end
