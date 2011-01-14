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
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
		return toInterfaceOrientation != UIInterfaceOrientationPortraitUpsideDown;
	}
	return YES;
}


#pragma mark SSCollectionViewDataSource

- (NSInteger)collectionView:(SSCollectionView *)aCollectionView numberOfRowsInSection:(NSInteger)section {
	return 32;
}


- (SSCollectionViewItem *)collectionView:(SSCollectionView *)aCollectionView itemForIndexPath:(NSIndexPath *)indexPath {
	static NSString *const itemIdentifier = @"itemIdentifier";
	
	SSCollectionViewItem *item = [aCollectionView dequeueReusableItemWithIdentifier:itemIdentifier];
	if (item == nil) {
		item = [[[SSCollectionViewItem alloc] initWithStyle:SSCollectionViewItemStyleDefault reuseIdentifier:itemIdentifier] autorelease];
		
		// Customize item for demo
		item.textLabel.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
		item.textLabel.frame = CGRectMake(0.0, 0.0, 80.0, 80.0);
	}
	
	item.textLabel.text = [NSString stringWithFormat:@"%i", indexPath.row];
	
	return item;
}


#pragma mark SSCollectionViewDelegate

- (void)collectionView:(SSCollectionView *)aCollectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"\nYou selected item #%i!\n\n", indexPath.row] message:nil delegate:nil cancelButtonTitle:@"Oh, awesome!" otherButtonTitles:nil];
	[alert show];
	[alert release];
}

@end
