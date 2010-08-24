//
//  SCCollectionViewDemoViewController.m
//  SSCatalog
//
//  Created by Sam Soffes on 8/24/10.
//  Copyright 2010 Sam Soffes. All rights reserved.
//

#import "SCCollectionViewDemoViewController.h"

@implementation SCCollectionViewDemoViewController

#pragma mark Class Methods

+ (NSString *)title {
	return @"Collection View";
}


#pragma mark NSObject

- (void)dealloc {
	_collectionView.dataSource = nil;
	_collectionView.delegate = nil;
	[_collectionView release];
	[super dealloc];
}


#pragma mark UIViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	self.title = [[self class] title];
	self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
	
	_collectionView = [[SSCollectionView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width, self.view.frame.size.height)];
	_collectionView.dataSource = self;
	_collectionView.delegate = self;
	[self.view addSubview:_collectionView];
}


#pragma mark SSCollectionViewDataSource

- (NSInteger)numberOfItemsInCollectionView:(SSCollectionView *)aCollectionView {
	return 0;
}


- (SSCollectionViewItem *)aCollectionView:(SSCollectionView *)aCollectionView itemForIndex:(NSUInteger)index {
	return nil;
}


#pragma mark SSCollectionViewDelegate

- (void)collectionView:(SSCollectionView *)aCollectionView didSelectItemAtIndex:(NSUInteger)index {
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"You selected item at index %i!", index] message:nil delegate:nil cancelButtonTitle:@"Oh, awesome!" otherButtonTitles:nil];
	[alert show];
	[alert release];
}

@end
