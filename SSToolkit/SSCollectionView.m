//
//  SSCollectionView.m
//  SSToolkit
//
//  Created by Sam Soffes on 6/11/10.
//  Copyright 2009-2010 Sam Soffes. All rights reserved.
//

#import "SSCollectionView.h"
#import "SSCollectionViewInternal.h"
#import "SSCollectionViewItem.h"
#import "SSCollectionViewItemInternal.h"
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
@synthesize allowsSelection = _allowsSelection;

#pragma mark NSObject

- (void)dealloc {
	self.dataSource = nil;
	self.delegate = nil;
	
	[_visibleItems removeAllObjects];
	[_visibleItems release];
	_visibleItems = nil;
	
	[_reuseableItems removeAllObjects];
	[_reuseableItems release];
	_reuseableItems = nil;
	
	_tableView.dataSource = nil;
	_tableView.delegate = nil;
	[_tableView release];
	
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
		_reuseableItems = [[NSMutableDictionary alloc] init];
		_visibleItems = [[NSMutableSet alloc] init];
		
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
	if (!identifier) {
		return nil;
	}
	
	NSMutableArray *items = [_reuseableItems objectForKey:identifier];
	if (!items || [items count] == 0) {
		return nil;
	}
	
	SSCollectionViewItem *item = [[items lastObject] retain];
	[items removeObject:item];
	
	[item prepareForReuse];
	return [item autorelease];
}


- (SSCollectionViewItem *)itemPathForIndex:(NSIndexPath *)indexPath {
	for (SSCollectionViewItem *item in _visibleItems) {
		if ([item.indexPath isEqual:indexPath]) {
			return item;
		}
	}	
	
	return nil;
}


- (NSIndexPath *)indexPathForItem:(SSCollectionViewItem *)item {
	// TODO: Implement
	return nil;
}


- (void)selectItemAtIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated {
	// Notify delegate that it will select
	if ([self.delegate respondsToSelector:@selector(collectionView:willSelectItemAtIndexPath:)]) {
		[self.delegate collectionView:self willSelectItemAtIndexPath:indexPath];
	}
	
	SSCollectionViewItem *item = [self itemPathForIndex:indexPath];
	[item setHighlighted:NO animated:NO];
	[item setSelected:YES animated:YES];
	
	// Notify delegate that it did selection
	if ([self.delegate respondsToSelector:@selector(collectionView:didSelectItemAtIndexPath:)]) {
		[self.delegate collectionView:self didSelectItemAtIndexPath:indexPath];
	}
}


- (void)deselectItemAtIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated {
	// Notify delegate that it will deselect
	if ([self.delegate respondsToSelector:@selector(collectionView:willDeselectItemAtIndexPath:)]) {
		[self.delegate collectionView:self willDeselectItemAtIndexPath:indexPath];
	}
	
	SSCollectionViewItem *item = [self itemPathForIndex:indexPath];
	[item setHighlighted:NO animated:NO];
	[item setSelected:NO animated:YES];
	
	// Notify delegate that it did deselection
	if ([self.delegate respondsToSelector:@selector(collectionView:didDeselectItemAtIndexPath:)]) {
		[self.delegate collectionView:self didDeselectItemAtIndexPath:indexPath];
	}
}


- (void)scrollToItemAtIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated {
	// TODO: Implement
}


- (void)reloadItemAtIndexPaths:(NSIndexPath *)indexPaths {
	// TODO: Implement
}


#pragma mark Private Methods

- (void)_reuseItem:(SSCollectionViewItem *)item {
	[_visibleItems removeObject:item];
	
	NSMutableArray *items = [_reuseableItems objectForKey:item.reuseIdentifier];
	if (!items) {
		[_reuseableItems setObject:[NSMutableArray array] forKey:item.reuseIdentifier];
	}
	
	[items addObject:item];
}


- (void)_reuseItems:(NSArray *)items {
	for (SSCollectionViewItem *item in items) {
		[self _reuseItem:item];
	}
}


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
		NSIndexPath *itemIndexPath = [NSIndexPath indexPathForRow:i inSection:rowIndexPath.section];
		SSCollectionViewItem *item = [_dataSource collectionView:self itemForIndexPath:itemIndexPath];
		if (item == nil) {
			NSException *exception = [NSException exceptionWithName:kSSCollectionViewNilItemExceptionName 
															 reason:kSSCollectionViewNilItemExceptionReason userInfo:nil];
			[exception raise];
			return nil;
		}
		
		item.tag = i;
		item.indexPath = itemIndexPath;
		item.collectionView = self;
		[_visibleItems addObject:item];
		[items addObject:item];
	}
	
	return [items autorelease];
}


#pragma mark Getters

- (UIScrollView *)scrollView {
	return _tableView;
}


- (UIView *)backgroundView {
	return _tableView.backgroundView;
}


#pragma mark Setters

- (void)setBackgroundColor:(UIColor *)color {
	[super setBackgroundColor:color];
	_tableView.backgroundColor = color;
}


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


- (void)setBackgroundView:(UIView *)background {
	_tableView.backgroundView = background;
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
		cell = [[[SSCollectionViewTableViewCell alloc] initWithReuseIdentifier:cellIdentifier] autorelease];
	}
	
	// TODO: Cache
	CGSize itemSize = [self _itemSizeForSection:indexPath.section];
	CGFloat itemsPerRow = floorf(self.frame.size.width / (itemSize.width + _minimumColumnSpacing));
	CGFloat itemSpacing = roundf((self.frame.size.width - (itemSize.width * itemsPerRow)) / itemsPerRow);
	
	cell.itemSize = itemSize;
	cell.itemSpacing = itemSpacing;
	cell.items = [self _itemsForRowIndexPath:indexPath];
	cell.collectionView = self;
	
	return cell;
}


#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return [self _itemSizeForSection:indexPath.section].height + _rowSpacing;
}

@end
