//
//  SSCollectionViewController.m
//  SSToolkit
//
//  Created by Sam Soffes on 8/26/10.
//  Copyright 2010-2011 Sam Soffes. All rights reserved.
//

#import "SSCollectionViewController.h"
#import "SSDrawingUtilities.h"

@interface SSCollectionViewController ()
- (void)_initialize;
@end

@implementation SSCollectionViewController

#pragma mark - Accessors

@synthesize collectionView = _collectionView;


#pragma mark - NSObject

- (id)init {
	if ((self = [super init])) {
		[self _initialize];
	}
	return self;
}


- (void)dealloc {
	_collectionView.dataSource = nil;
	_collectionView.delegate = nil;
}


#pragma mark - UIViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
	if ((self = [super initWithCoder:aDecoder])) {
		[self _initialize];
	}
	return self;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
		[self _initialize];
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

#pragma mark - Private

- (void)_initialize {
    if ( ! _collectionView )
    {
        _collectionView = [[SSCollectionView alloc] initWithFrame:CGRectZero];
        _collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
    }
}


#pragma mark - SSCollectionViewDataSource

- (NSUInteger)collectionView:(SSCollectionView *)aCollectionView numberOfItemsInSection:(NSUInteger)section {
	return 0;
}


- (SSCollectionViewItem *)collectionView:(SSCollectionView *)aCollectionView itemForIndexPath:(NSIndexPath *)indexPath {
	return nil;
}


#pragma mark - SSCollectionViewDelegate

- (CGSize)collectionView:(SSCollectionView *)aCollectionView itemSizeForSection:(NSUInteger)section {
	return CGSizeMake(50.0f, 50.0f);
}

@end
