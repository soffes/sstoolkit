//
//  SSCollectionViewController.m
//  SSToolkit
//
//  Created by Sam Soffes on 8/26/10.
//  Copyright 2009-2010 Sam Soffes. All rights reserved.
//

#import "SSCollectionViewController.h"
#import "SSDrawingMacros.h"

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
	[super loadView];
	
	_collectionView = [[SSCollectionView alloc] initWithFrame:CGRectSetZeroOrigin(self.view.frame)];
	_collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	_collectionView.dataSource = self;
	_collectionView.delegate = self;

	[self.view addSubview:_collectionView];
}


- (void)viewDidLoad {
	[super viewDidLoad];
	[_collectionView reloadData];
}


- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	[_collectionView flashScrollIndicators];
}


#pragma mark SSCollectionViewDataSource

- (NSInteger)collectionView:(SSCollectionView *)aCollectionView numberOfItemsInSection:(NSInteger)section {
	return 0;
}


- (SSCollectionViewItem *)collectionView:(SSCollectionView *)aCollectionView itemForIndexPath:(NSIndexPath *)indexPath {
	return nil;
}


#pragma mark SSCollectionViewDelegate

- (CGSize)collectionView:(SSCollectionView *)aCollectionView itemSizeForSection:(NSInteger)section {
	return CGSizeZero;
}

@end
