//
//  SSCollectionViewController.h
//  SSToolkit
//
//  Created by Sam Soffes on 8/26/10.
//  Copyright 2009-2010 Sam Soffes. All rights reserved.
//

#import "SSViewController.h"
#import "SSCollectionView.h"

@interface SSCollectionViewController : SSViewController <SSCollectionViewDataSource, SSCollectionViewDelegate> {

	SSCollectionView *_collectionView;
}

@property (nonatomic, retain, readonly) SSCollectionView *collectionView;

@end
