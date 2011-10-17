//
//  SSCollectionViewTableView.h
//  SSToolkit
//
//  Created by Sam Soffes on 10/17/11.
//  Copyright (c) 2011 Sam Soffes. All rights reserved.
//

@class SSCollectionView;

@interface SSCollectionViewTableView : UITableView

- (void)_setDelegate:(SSCollectionView *)aCollectionView;
- (void)_setDataSource:(SSCollectionView *)aCollectionView;

@end
