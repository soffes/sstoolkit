//
//  SSCollectionView.m
//  SSToolkit
//
//  Created by Sam Soffes on 6/11/10.
//  Copyright 2009-2010 Sam Soffes. All rights reserved.
//

#import "SSCollectionView.h"
#import "SSCollectionViewItem.h"
#import "SSCollectionViewTableViewCell.h"
#import "SSDrawingMacros.h"
#import "UIView+SSToolkitAdditions.h"

@interface SSCollectionView (PrivateMethods)
- (CGSize)_itemSizeForSection:(NSInteger)section;
- (NSInteger)_numberOfItemsInSection:(NSInteger)section;
- (NSArray *)_itemsForRowIndexPath:(NSIndexPath *)rowIndexPath;
@end

@implementation SSCollectionView

@synthesize dataSource = _dataSource;
@synthesize delegate = _delegate;
@synthesize minimumColumnSpacing = _minimumColumnSpacing;
@synthesize rowSpacing = _rowSpacing;
@synthesize backgroundView = _backgroundView;
@synthesize backgroundHeaderView = _backgroundHeaderView;
@synthesize backgroundFooterView = _backgroundFooterView;
@synthesize allowsSelection = _allowsSelection;

#pragma mark NSObject

- (void)dealloc {
	self.dataSource = nil;
	self.delegate = nil;
	
	_tableView.dataSource = nil;
	_tableView.delegate = nil;
	[_tableView release];
	
	self.backgroundView = nil;
	self.backgroundHeaderView = nil;
	self.backgroundFooterView = nil;
	
	[super dealloc];
}


#pragma mark UIView

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
		self.backgroundColor = [UIColor whiteColor];
		self.opaque = YES;
		
		_minimumColumnSpacing = 10.0f;
		_rowSpacing = 20.0f;
		_allowsSelection = YES;
		
		_tableView = [[UITableView alloc] initWithFrame:CGRectSetZeroOrigin(frame)];
		_tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		_tableView.dataSource = self;
		_tableView.delegate = self;
		_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
		[self addSubview:_tableView];
    }
    return self;
}


#pragma mark SSCollectionView

- (void)reloadData {
	[_tableView reloadData];
}


- (SSCollectionViewItem *)dequeueReusableItemWithIdentifier:(NSString *)identifier {
	// TODO: Store items and reuse
	return nil;
}


- (SSCollectionViewItem *)itemPathForIndex:(NSIndexPath *)indexPath {
	// TODO: Implement
	return nil;
}


- (NSIndexPath *)indexPathForItem:(SSCollectionViewItem *)item {
	// TODO: Implement
	return nil;
}


- (void)deselectItemAtIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated {
	// TODO: Implement
}


- (void)scrollToItemAtIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated {
	// TODO: Implement
}


- (void)reloadItemAtIndexPaths:(NSIndexPath *)indexPaths {
	// TODO: Implement
}


- (void)flashScrollIndicators {
	[_tableView flashScrollIndicators];
}


#pragma mark Private Methods

- (CGSize)_itemSizeForSection:(NSInteger)section {
	// TODO: Cache this value to elminate lots of method calls
	if ([_delegate respondsToSelector:@selector(collectionView:itemSizeForSection:)] == NO) {
		[[NSException exceptionWithName:kSSCollectionViewMissingItemSizeExceptionName reason:kSSCollectionViewMissingItemSizeExceptionReason userInfo:nil] raise];
		return CGSizeZero;
	}	
	return [_delegate collectionView:self itemSizeForSection:section];
}


- (NSInteger)_numberOfItemsInSection:(NSInteger)section {
	if ([_dataSource respondsToSelector:@selector(collectionView:numberOfItemsInSection:)] == NO) {
		return 0;
	}
	return [_dataSource collectionView:self numberOfItemsInSection:section];
}


- (NSArray *)_itemsForRowIndexPath:(NSIndexPath *)rowIndexPath {
	NSInteger totalItems = [self _numberOfItemsInSection:rowIndexPath.section];
	CGSize itemSize = [self _itemSizeForSection:rowIndexPath.section];
	NSInteger itemsPerRow = (NSInteger)floorf(self.frame.size.width / (itemSize.width + _minimumColumnSpacing));
	
	NSInteger startIndex = itemsPerRow * (NSInteger)rowIndexPath.row;
	NSInteger endIndex = (NSInteger)fmin(totalItems, startIndex + itemsPerRow);

	NSMutableArray *items = [[NSMutableArray alloc] initWithCapacity:endIndex - startIndex];
	
	for (NSInteger i = startIndex; i < endIndex; i++) {
		// TODO: Store item so it can be dequeued later
		SSCollectionViewItem *item = [_dataSource collectionView:self itemForIndexPath:[NSIndexPath indexPathForRow:i inSection:rowIndexPath.section]];
		if (item == nil) {
			NSException *exception = [NSException exceptionWithName:kSSCollectionViewNilItemExceptionName 
															 reason:kSSCollectionViewNilItemExceptionReason userInfo:nil];
			[exception raise];
			return nil;
		}
		
		item.tag = i;
		[items addObject:item];
	}
	
	return [items autorelease];
}


#pragma mark Setters

- (void)setDataSource:(id<SSCollectionViewDataSource>)dataSource {
	_dataSource = dataSource;
	
	if (_delegate) {
		[self reloadData];
	}
}


- (void)setDelegate:(id<SSCollectionViewDelegate>)delegate {
	_delegate = delegate;
	
	if (_dataSource) {
		[self reloadData];
	}
}


- (void)setFrame:(CGRect)rect {
	[super setFrame:rect];
	
	[UIView beginAnimations:@"SSCollectionViewAnimationUpdateLayout" context:self];
	[self setNeedsLayout];
	[UIView commitAnimations];
}


- (void)setBackgroundView:(UIView *)background {
	[_backgroundView removeFromSuperview];
	[_backgroundView release];
	
	_backgroundView = [background retain];
	_backgroundView.tag = -1;
	_backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	[self insertSubview:_backgroundView atIndex:0];
	
	[self setNeedsLayout];
}


- (void)setBackgroundHeaderView:(UIView *)backgroundHeader {
	[_backgroundHeaderView removeFromSuperview];
	[_backgroundHeaderView release];
	
	_backgroundHeaderView = [backgroundHeader retain];
	_backgroundHeaderView.tag = -2;
	_backgroundHeaderView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	
	if (_backgroundView) {
		[self insertSubview:_backgroundHeaderView aboveSubview:_backgroundView];
	} else {
		[self insertSubview:_backgroundHeaderView atIndex:0];
	}
	
	[self setNeedsLayout];
}


- (void)setBackgroundFooterView:(UIView *)backgroundFooter {
	[_backgroundFooterView removeFromSuperview];
	[_backgroundFooterView release];
	
	_backgroundFooterView = [backgroundFooter retain];
	_backgroundFooterView.tag = -3;
	_backgroundFooterView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	
	if (_backgroundView) {
		[self insertSubview:_backgroundFooterView aboveSubview:_backgroundView];
	} else {
		[self insertSubview:_backgroundFooterView atIndex:0];
	}
	
	[self setNeedsLayout];
}


#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	if ([_dataSource respondsToSelector:@selector(numberOfSectionsInCollectionView:)]) {
		return [_dataSource numberOfSectionsInCollectionView:self];
	}
	
	return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	NSInteger totalItems = [self _numberOfItemsInSection:section];
	CGSize itemSize = [self _itemSizeForSection:section];
	CGFloat itemsPerRow = floorf(self.frame.size.width / (itemSize.width + _minimumColumnSpacing));
	
	NSInteger rows = (NSInteger)ceilf((CGFloat)totalItems / itemsPerRow);
	return rows;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *cellIdentifier = @"SSCollectionViewTableViewCellIdentifier";
	
	SSCollectionViewTableViewCell *cell = (SSCollectionViewTableViewCell *)[_tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	if (!cell) {
		cell = [[SSCollectionViewTableViewCell alloc] initWithReuseIdentifier:cellIdentifier];
	}
	
	// TODO: Cache
	CGSize itemSize = [self _itemSizeForSection:indexPath.section];
	CGFloat itemsPerRow = floorf(self.frame.size.width / (itemSize.width + _minimumColumnSpacing));
	
	cell.itemSize = itemSize;
	cell.itemSpacing = roundf((self.frame.size.width - (itemSize.width * itemsPerRow)) / itemsPerRow);	
	cell.items = [self _itemsForRowIndexPath:indexPath];
	
	return cell;
}


#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return [self _itemSizeForSection:indexPath.section].height + _rowSpacing;
}

@end
