//
//  SSCollectionView.m
//  SSToolkit
//
//  Created by Sam Soffes on 6/11/10.
//  Copyright 2010-2011 Sam Soffes. All rights reserved.
//

#import "SSCollectionView.h"
#import "SSCollectionViewInternal.h"
#import "SSCollectionViewItem.h"
#import "SSCollectionViewItemInternal.h"
#import "SSCollectionViewTableViewCell.h"
#import "SSDrawingUtilities.h"
#import "UIView+SSToolkitAdditions.h"

@interface SSCollectionView (PrivateMethods)
- (CGSize)_itemSizeForSection:(NSInteger)section;
- (NSArray *)_itemsForRowIndexPath:(NSIndexPath *)rowIndexPath;
- (NSIndexPath *)_cellIndexPathFromItemIndexPath:(NSIndexPath *)rowIndexPath;
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
	
	[_sectionCache release];
	
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


- (void)setFrame:(CGRect)frame {
	[super setFrame:frame];
	[_tableView reloadData];
}


#pragma mark SSCollectionView

- (void)reloadData {
	[_sectionCache release];
	_sectionCache = [[NSMutableDictionary alloc] init];
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
	return item.indexPath;
}


- (void)selectItemAtIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated scrollPosition:(SSCollectionViewScrollPosition)scrollPosition {
	// Notify delegate that it will select
	if ([self.delegate respondsToSelector:@selector(collectionView:willSelectItemAtIndexPath:)]) {
		[self.delegate collectionView:self willSelectItemAtIndexPath:indexPath];
	}
	
	SSCollectionViewItem *item = [self itemPathForIndex:indexPath];
	[item setHighlighted:NO animated:NO];
	[item setSelected:YES animated:YES];
	
	if (scrollPosition == SSCollectionViewScrollPositionTop || scrollPosition == SSCollectionViewScrollPositionMiddle ||
		scrollPosition == SSCollectionViewScrollPositionBottom) {
		[self scrollToItemAtIndexPath:indexPath atScrollPosition:scrollPosition animated:animated];
	}
	
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


- (void)scrollToItemAtIndexPath:(NSIndexPath *)indexPath atScrollPosition:(SSCollectionViewScrollPosition)scrollPosition animated:(BOOL)animated {
	NSIndexPath *cellIndexPath = [self _cellIndexPathFromItemIndexPath:indexPath];
	[_tableView scrollToRowAtIndexPath:cellIndexPath atScrollPosition:(UITableViewScrollPosition)scrollPosition animated:animated];
}


- (void)reloadItemsAtIndexPaths:(NSArray *)indexPaths {
	NSMutableArray *rowIndexPaths = [[NSMutableArray alloc] init];
	for (NSIndexPath *itemIndexPath in indexPaths) {
		NSIndexPath *rowIndexPath = [self _cellIndexPathFromItemIndexPath:itemIndexPath];
		if (![rowIndexPaths containsObject:rowIndexPaths]) {
			[rowIndexPaths addObject:rowIndexPath];
		}
	}
	
	[_tableView reloadRowsAtIndexPaths:rowIndexPaths withRowAnimation:UITableViewRowAnimationFade];	
	[rowIndexPaths release];
}


- (NSInteger)numberOfSections {
	return [_tableView numberOfSections];
}


- (NSInteger)numberOfItemsInSection:(NSInteger)section {
	if ([_dataSource respondsToSelector:@selector(collectionView:numberOfItemsInSection:)] == NO) {
		return 0;
	}
	return [_dataSource collectionView:self numberOfItemsInSection:section];
}


- (CGRect)rectForSection:(NSInteger)section {
	return [_tableView rectForSection:section];
}


- (CGRect)rectForHeaderInSection:(NSInteger)section {
	return [_tableView rectForSection:section];
}


- (CGRect)rectForFooterInSection:(NSInteger)section {
	return [_tableView rectForFooterInSection:section];
}


#pragma mark Private Methods

- (void)_reuseItem:(SSCollectionViewItem *)item {
	[_visibleItems removeObject:item];
	
	if (!item.reuseIdentifier) {
		NSLog(@"[SSCollectionView] Your item identifier is nil. You should really provide a reuse identifier.");
		return;
	}
	
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
	NSNumber *key = [NSNumber numberWithInteger:section];
	NSValue *value = [_sectionCache objectForKey:key];
	if (value) {
		return [value CGSizeValue];
	}
	
	if ([_delegate respondsToSelector:@selector(collectionView:itemSizeForSection:)] == NO) {
		[[NSException exceptionWithName:kSSCollectionViewMissingItemSizeExceptionName reason:kSSCollectionViewMissingItemSizeExceptionReason userInfo:nil] raise];
		return CGSizeZero;
	}	
	CGSize size = [_delegate collectionView:self itemSizeForSection:section];
	[_sectionCache setObject:[NSValue valueWithCGSize:size] forKey:key];
	return size;
}


- (NSArray *)_itemsForRowIndexPath:(NSIndexPath *)rowIndexPath {
	NSInteger totalItems = [self numberOfItemsInSection:(NSInteger)rowIndexPath.section];
	CGSize itemSize = [self _itemSizeForSection:(NSInteger)rowIndexPath.section];
	NSInteger itemsPerRow = (NSInteger)floorf(self.frame.size.width / (itemSize.width + _minimumColumnSpacing));
	
	NSInteger startIndex = itemsPerRow * (NSInteger)rowIndexPath.row;
	NSInteger endIndex = (NSInteger)fmin(totalItems, startIndex + itemsPerRow);
	
	NSMutableArray *items = [[NSMutableArray alloc] initWithCapacity:(NSUInteger)(endIndex - startIndex)];
	
	for (NSInteger i = startIndex; i < endIndex; i++) {
		NSIndexPath *itemIndexPath = [NSIndexPath indexPathForRow:(NSUInteger)i inSection:rowIndexPath.section];
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


- (NSIndexPath *)_cellIndexPathFromItemIndexPath:(NSIndexPath *)rowIndexPath {
	CGSize itemSize = [self _itemSizeForSection:(NSInteger)rowIndexPath.section];
	NSUInteger itemsPerRow = (NSUInteger)floorf(self.frame.size.width / (itemSize.width + _minimumColumnSpacing));
	
	// Avoid division by zero
	if (itemsPerRow == 0) {
		return nil;
	}	
	
	NSUInteger row = (NSUInteger)floor(rowIndexPath.row / itemsPerRow);
	return [NSIndexPath indexPathForRow:row inSection:rowIndexPath.section];
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
	
	if (_delegate && _dataSource) {
		[self reloadData];
	}
}


- (void)setDelegate:(id<SSCollectionViewDelegate>)delegate {
	_delegate = delegate;
	
	if (_delegate && _dataSource) {
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
	NSInteger totalItems = [self numberOfItemsInSection:section];
	CGSize itemSize = [self _itemSizeForSection:section];
	CGFloat itemsPerRow = floorf(self.frame.size.width / (itemSize.width + _minimumColumnSpacing));
	
	if (itemsPerRow == 0.0f) {
		return 0;
	}

	NSInteger rows = (NSInteger)ceilf((CGFloat)totalItems / itemsPerRow);
	return rows;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *cellIdentifier = @"SSCollectionViewTableViewCellIdentifier";
	
	SSCollectionViewTableViewCell *cell = (SSCollectionViewTableViewCell *)[_tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	if (!cell) {
		cell = [[[SSCollectionViewTableViewCell alloc] initWithReuseIdentifier:cellIdentifier] autorelease];
	}
	
	CGSize itemSize = [self _itemSizeForSection:(NSInteger)indexPath.section];
	CGFloat itemsPerRow = floorf(self.frame.size.width / (itemSize.width + _minimumColumnSpacing));
	CGFloat itemSpacing = roundf((self.frame.size.width - (itemSize.width * itemsPerRow)) / (itemsPerRow + 1));
	
	cell.itemSize = itemSize;
	cell.itemSpacing = itemSpacing;
	cell.items = [self _itemsForRowIndexPath:indexPath];
	cell.collectionView = self;
	
	return cell;
}


#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return [self _itemSizeForSection:(NSInteger)indexPath.section].height + _rowSpacing;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	if ([_delegate respondsToSelector:@selector(collectionView:viewForHeaderInSection:)]) {
		return [_delegate collectionView:self viewForHeaderInSection:section];
	}
	return nil;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	if ([_delegate respondsToSelector:@selector(collectionView:heightForHeaderInSection:)]) {
		return [_delegate collectionView:self heightForHeaderInSection:section];
	}
	return 0.0f;
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
	if ([_delegate respondsToSelector:@selector(collectionView:viewForFooterInSection:)]) {
		return [_delegate collectionView:self viewForFooterInSection:section];
	}
	return nil;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
	if ([_delegate respondsToSelector:@selector(collectionView:heightForFooterInSection:)]) {
		return [_delegate collectionView:self heightForFooterInSection:section];
	}
	return 0.0f;
}


#pragma mark UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
	if ([_delegate respondsToSelector:@selector(scrollViewDidScroll:)]) {
		[_delegate scrollViewDidScroll:scrollView];
	}
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
	if ([_delegate respondsToSelector:@selector(scrollViewWillBeginDragging:)]) {
		[_delegate scrollViewWillBeginDragging:scrollView];
	}
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
	if ([_delegate respondsToSelector:@selector(scrollViewDidEndDragging:willDecelerate:)]) {
		[_delegate scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
	}
}


- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
	if ([_delegate respondsToSelector:@selector(scrollViewWillBeginDecelerating:)]) {
		[_delegate scrollViewWillBeginDecelerating:scrollView];
	}
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
	if ([_delegate respondsToSelector:@selector(scrollViewDidEndDecelerating:)]) {
		[_delegate scrollViewDidEndDecelerating:scrollView];
	}
}


- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
	if ([_delegate respondsToSelector:@selector(scrollViewDidEndScrollingAnimation:)]) {
		[_delegate scrollViewDidEndScrollingAnimation:scrollView];
	}
}


- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView {
	if ([_delegate respondsToSelector:@selector(scrollViewShouldScrollToTop:)]) {
		return [_delegate scrollViewShouldScrollToTop:scrollView];
	}
	
	return YES;
}


- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView {
	if ([_delegate respondsToSelector:@selector(scrollViewDidScrollToTop:)]) {
		[_delegate scrollViewDidScrollToTop:scrollView];
	}
}

@end
