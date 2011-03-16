//
//  SSCollectionViewInternal.h
//  SSToolkit
//
//  Created by Sam Soffes on 3/14/11.
//  Copyright 2011 Sam Soffes. All rights reserved.
//

@interface SSCollectionView (Internal)

- (void)_reuseItems:(NSArray *)items;
- (void)_reuseItem:(SSCollectionViewItem *)item;

@end
