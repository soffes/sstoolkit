//
//  SCCollectionViewDemoViewController.m
//  SSCatalog
//
//  Created by Sam Soffes on 8/24/10.
//  Copyright 2010 Sam Soffes. All rights reserved.
//

#import "SCCollectionViewDemoViewController.h"
#import "SCImageCollectionViewItem.h"

@implementation SCCollectionViewDemoViewController

#pragma mark Class Methods

+ (NSString *)title {
	return @"Collection View";
}


#pragma mark NSObject

- (void)dealloc {
	[_headerCache release];
	[super dealloc];
}


#pragma mark UIViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	self.title = [[self class] title];
	self.collectionView.minimumColumnSpacing = 20.0f;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
		return toInterfaceOrientation != UIInterfaceOrientationPortraitUpsideDown;
	}
	return YES;
}

#pragma mark SSCollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(SSCollectionView *)aCollectionView {
	return 10;
}

- (NSInteger)collectionView:(SSCollectionView *)aCollectionView numberOfItemsInSection:(NSInteger)section {
	return 50;
}


- (SSCollectionViewItem *)collectionView:(SSCollectionView *)aCollectionView itemForIndexPath:(NSIndexPath *)indexPath {
	static NSString *const itemIdentifier = @"itemIdentifier";
	
	SCImageCollectionViewItem *item = (SCImageCollectionViewItem *)[aCollectionView dequeueReusableItemWithIdentifier:itemIdentifier];
	if (item == nil) {
		item = [[[SCImageCollectionViewItem alloc] initWithStyle:SSCollectionViewItemStyleImage reuseIdentifier:itemIdentifier] autorelease];
	}
	
	CGFloat size = 80.0f * [[UIScreen mainScreen] scale];
	NSInteger i = (50 * indexPath.section) + indexPath.row;
	item.imageURL = [NSString stringWithFormat:@"http://www.gravatar.com/avatar/%i?s=%0.f&d=identicon", i, size];
	
	return item;
}


- (UIView *)collectionView:(SSCollectionView *)aCollectionView viewForHeaderInSection:(NSInteger)section {
	if (!_headerCache) {
		_headerCache = [[NSCache alloc] init];
	}
	
	NSNumber *key = [NSNumber numberWithInteger:section];
	SSLabel *header = [_headerCache objectForKey:key];
	if (!header) {
		header = [[SSLabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.width, 40.0f)];
		header.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		header.text = [NSString stringWithFormat:@"Section %i", section + 1];
		header.textEdgeInsets = UIEdgeInsetsMake(0.0f, 10.0f, 0.0f, 10.0f);
		header.shadowColor = [UIColor whiteColor];
		header.shadowOffset = CGSizeMake(0.0f, 1.0f);
		header.backgroundColor = [UIColor colorWithWhite:1.0f alpha:0.8f];
		
		[_headerCache setObject:header forKey:key];
		[header autorelease];
	}
	return header;
}


#pragma mark SSCollectionViewDelegate

- (CGSize)collectionView:(SSCollectionView *)aCollectionView itemSizeForSection:(NSInteger)section {
	return CGSizeMake(80.0f, 80.0f);
}


- (void)collectionView:(SSCollectionView *)aCollectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
	NSString *title = [NSString stringWithFormat:@"You selected item %i in section %i!",
					   indexPath.row + 1, indexPath.section + 1];
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:nil delegate:nil
										  cancelButtonTitle:@"Oh, awesome!" otherButtonTitles:nil];
	[alert show];
	[alert release];
}


- (CGFloat)collectionView:(SSCollectionView *)aCollectionView heightForHeaderInSection:(NSInteger)section {
	return 40.0f;
}

@end
