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

- (NSInteger)collectionView:(SSCollectionView *)aCollectionView numberOfItemsInSection:(NSInteger)section {
	return 1024;
}


- (SSCollectionViewItem *)collectionView:(SSCollectionView *)aCollectionView itemForIndexPath:(NSIndexPath *)indexPath {
	static NSString *const itemIdentifier = @"itemIdentifier";
	
	SSCollectionViewItem *item = [aCollectionView dequeueReusableItemWithIdentifier:itemIdentifier];
	if (item == nil) {
		NSLog(@"Allocating");
		item = [[[SSCollectionViewItem alloc] initWithStyle:SSCollectionViewItemStyleDefault reuseIdentifier:itemIdentifier] autorelease];
		
		// Customize item for demo
		item.textLabel.backgroundColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
		item.textLabel.frame = CGRectMake(0.0f, 0.0f, 80.0f, 80.0f);
	} else {
		NSLog(@"Reusing");
	}
	
	item.textLabel.text = [NSString stringWithFormat:@"%i", indexPath.row];
	
	return item;
}


#pragma mark SSCollectionViewDelegate

- (CGSize)collectionView:(SSCollectionView *)aCollectionView itemSizeForSection:(NSInteger)section {
	return CGSizeMake(80.0f, 80.0f);
}


- (void)collectionView:(SSCollectionView *)aCollectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"\nYou selected item #%i!\n\n", indexPath.row] message:nil delegate:nil cancelButtonTitle:@"Oh, awesome!" otherButtonTitles:nil];
	[alert show];
	[alert release];
}

@end
