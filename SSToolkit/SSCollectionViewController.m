//
//  SSCollectionViewController.m
//  SSToolkit
//
//  Created by Sam Soffes on 8/26/10.
//  Copyright 2010 Sam Soffes. All rights reserved.
//

#import "SSCollectionViewController.h"

@implementation SSCollectionViewController

@synthesize collectionView = _collectionView;

#pragma mark NSObject

- (void)dealloc {
	_collectionView.dataSource = nil;
	_collectionView.delegate = nil;
	[_collectionView release];
	[super dealloc];
}


#pragma mark UIViewController

- (void)loadView {
	_collectionView = [[SSCollectionView alloc] initWithFrame:CGRectZero];
	_collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	_collectionView.dataSource = self;
	_collectionView.delegate = self;

	self.view = _collectionView;
}


#pragma mark SSCollectionViewDataSource

- (NSInteger)collectionView:(SSCollectionView *)aCollectionView numberOfRowsInSection:(NSInteger)section {
	return 0;
}


- (SSCollectionViewItem *)collectionView:(SSCollectionView *)aCollectionView itemForIndexPath:(NSIndexPath *)indexPath {
	return nil;
}

@end
