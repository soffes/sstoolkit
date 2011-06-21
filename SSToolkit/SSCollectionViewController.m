//
//  SSCollectionViewController.m
//  SSToolkit
//
//  Created by Sam Soffes on 8/26/10.
//  Copyright 2010-2011 Sam Soffes. All rights reserved.
//

#import "SSCollectionViewController.h"
#import "SSDrawingUtilities.h"

@implementation SSCollectionViewController

#pragma mark -
#pragma mark Accessors

@synthesize collectionView = _collectionView;


#pragma mark -
#pragma mark NSObject

- (void)dealloc {
	_collectionView.dataSource = nil;
	_collectionView.delegate = nil;
	[_collectionView release];
	[super dealloc];
}


#pragma mark -
#pragma mark UIViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
		_collectionView = [[SSCollectionView alloc] initWithFrame:CGRectZero];
		_collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		_collectionView.dataSource = self;
		_collectionView.delegate = self;
	}
	return self;
}


- (void)loadView {
	_collectionView.frame = [[UIScreen mainScreen] applicationFrame];
	self.view = _collectionView;
}


- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	[_collectionView.scrollView flashScrollIndicators];
}


#pragma mark -
#pragma mark SSCollectionViewDataSource

- (NSUInteger)collectionView:(SSCollectionView *)aCollectionView numberOfItemsInSection:(NSUInteger)section {
	return 0;
}


- (SSCollectionViewItem *)collectionView:(SSCollectionView *)aCollectionView itemForIndexPath:(NSIndexPath *)indexPath {
	return nil;
}


#pragma mark -
#pragma mark SSCollectionViewDelegate

- (CGSize)collectionView:(SSCollectionView *)aCollectionView itemSizeForSection:(NSUInteger)section {
	return CGSizeZero;
}

@end
