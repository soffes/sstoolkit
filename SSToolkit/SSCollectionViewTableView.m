//
//  SSCollectionViewTableView.m
//  SSToolkit
//
//  Created by Sam Soffes on 10/17/11.
//  Copyright (c) 2011 Sam Soffes. All rights reserved.
//

#import "SSCollectionViewTableView.h"

@implementation SSCollectionViewTableView

- (void)setDelegate:(id<UITableViewDelegate>)delegate {
	// Do nothing.
}


- (void)setDataSource:(id<UITableViewDataSource>)dataSource {
	// Do nothing.
}


- (void)_setDelegate:(SSCollectionView *)aCollectionView {
	[super setDelegate:(id<UITableViewDelegate>)aCollectionView];
}


- (void)_setDataSource:(SSCollectionView *)aCollectionView {
	[super setDataSource:(id<UITableViewDataSource>)aCollectionView];
}


@end
