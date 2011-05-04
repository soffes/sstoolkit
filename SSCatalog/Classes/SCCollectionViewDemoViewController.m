//
//  SCCollectionViewDemoViewController.m
//  SSCatalog
//
//  Created by Sam Soffes on 8/24/10.
//  Copyright 2010 Sam Soffes. All rights reserved.
//

#import "SCCollectionViewDemoViewController.h"
#import "SCImageCollectionViewItem.h"
#import "EGOImageView.h"

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
	
	UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"999" style:UIBarButtonItemStyleBordered target:self action:@selector(goTo999:)];
	self.navigationItem.rightBarButtonItem = rightButton;
	[rightButton release];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
		return toInterfaceOrientation != UIInterfaceOrientationPortraitUpsideDown;
	}
	return YES;
}


#pragma mark Actions

- (void)goTo999:(id)sender {
	NSIndexPath *indexPath = [NSIndexPath indexPathForRow:999 inSection:0];
	[self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:SSCollectionViewScrollPositionTop animated:YES];
}


#pragma mark SSCollectionViewDataSource

- (NSInteger)collectionView:(SSCollectionView *)aCollectionView numberOfItemsInSection:(NSInteger)section {
	return 1024;
}


- (SSCollectionViewItem *)collectionView:(SSCollectionView *)aCollectionView itemForIndexPath:(NSIndexPath *)indexPath {
	static NSString *const itemIdentifier = @"itemIdentifier";
	
	SCImageCollectionViewItem *item = (SCImageCollectionViewItem *)[aCollectionView dequeueReusableItemWithIdentifier:itemIdentifier];
	if (item == nil) {
		item = [[[SCImageCollectionViewItem alloc] initWithStyle:SSCollectionViewItemStyleDefault reuseIdentifier:itemIdentifier] autorelease];
		
		// Customize item for demo
		item.textLabel.backgroundColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
		item.textLabel.frame = CGRectMake(0.0f, 0.0f, 80.0f, 80.0f);
	}
	
	CGFloat size = 80.0f * [[UIScreen mainScreen] scale];
	NSString *urlString = [NSString stringWithFormat:@"http://www.gravatar.com/avatar/%i?s=%0.f&d=identicon", indexPath.row, size];
	item.remoteImageView.imageURL = [NSURL URLWithString:urlString];
	
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
