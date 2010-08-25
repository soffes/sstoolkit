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
	self.view.backgroundColor = [UIColor whiteColor];
	
	_collectionView = [[SSCollectionView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width, self.view.frame.size.height)];
	_collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	_collectionView.dataSource = self;
	_collectionView.delegate = self;
	[self.view addSubview:_collectionView];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
		return toInterfaceOrientation != UIInterfaceOrientationPortraitUpsideDown;
	}
	return YES;
}


#pragma mark SSCollectionViewDataSource

- (NSInteger)numberOfItemsInCollectionView:(SSCollectionView *)aCollectionView {
	return 32;
}


- (SSCollectionViewItem *)collectionView:(SSCollectionView *)aCollectionView itemForIndex:(NSUInteger)index {
	static NSString *const itemIdentifier = @"itemIdentifier";
	
	SSCollectionViewItem *item = [aCollectionView dequeueReusableItemWithIdentifier:itemIdentifier];
	if (item == nil) {
		item = [[SSCollectionViewItem alloc] initWithStyle:SSCollectionViewItemStyleDefault reuseIdentifier:itemIdentifier];
		
		// Customize item for demo
		item.textLabel.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
		item.textLabel.frame = CGRectMake(0.0, 0.0, 80.0, 80.0);
	}
	
	item.textLabel.text = [NSString stringWithFormat:@"%i", index];
	
	return item;
}


#pragma mark SSCollectionViewDelegate

- (void)collectionView:(SSCollectionView *)aCollectionView didSelectItemAtIndex:(NSUInteger)index {
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"\nYou selected item #%i!\n\n", index] message:nil delegate:nil cancelButtonTitle:@"Oh, awesome!" otherButtonTitles:nil];
	[alert show];
	[alert release];
}

@end
