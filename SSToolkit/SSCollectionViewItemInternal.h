//
//  SSCollectionViewItemInternal.h
//  SSToolkit
//
//  Created by Sam Soffes on 3/15/11.
//  Copyright 2011 Sam Soffes. All rights reserved.
//

@class SSCollectionView;

@interface SSCollectionViewItem ()

@property (nonatomic, retain) NSIndexPath *indexPath;
@property (nonatomic, assign) SSCollectionView *collectionView;

@end
