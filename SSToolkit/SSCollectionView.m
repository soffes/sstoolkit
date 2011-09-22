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
#import "SSCollectionViewItemTableViewCell.h"
#import "SSCollectionViewExtremityTableViewCell.h"
#import "SSDrawingUtilities.h"
#import "UIView+SSToolkitAdditions.h"

typedef enum {
	SSCollectionViewCellTypeRow,
	SSCollectionViewCellTypeHeader,
	SSCollectionViewCellTypeFooter
} SSCollectionViewCellType;

static NSString *kSSCollectionViewSectionNumberOfItemsKey = @"SSCollectionViewSectionNumberOfItems";
static NSString *kSSCollectionViewSectionNumberOfRowsKey = @"SSCollectionViewSectionNumberOfRows";
static NSString *kSSCollectionViewSectionNumberOfItemsPerRowsKey = @"SSCollectionViewSectionNumberOfItemsPerRows";
static NSString *kSSCollectionViewSectionHeaderViewKey = @"SSCollectionViewSectionHeaderView";
static NSString *kSSCollectionViewSectionFooterViewKey = @"SSCollectionViewSectionFooterView";
static NSString *kSSCollectionViewSectionHeaderHeightKey = @"SSCollectionViewSectionHeaderHeight";
static NSString *kSSCollectionViewSectionFooterHeightKey = @"SSCollectionViewSectionFooterHeight";
static NSString *kSSCollectionViewSectionItemSizeKey = @"SSCollectionViewSectionItemSize";

@interface SSCollectionView (PrivateMethods)
- (void)_reuseItem:(SSCollectionViewItem *)item;
- (void)_reuseItems:(NSArray *)items;

- (CGSize)_itemSizeForSection:(NSUInteger)section;
- (NSUInteger)_numberOfItemsPerRowForSection:(NSUInteger)section;
- (NSUInteger)_numberOfRowsInSection:(NSUInteger)section;

- (NSArray *)_itemsForRowIndexPath:(NSIndexPath *)rowIndexPath;
- (NSIndexPath *)_cellIndexPathFromItemIndexPath:(NSIndexPath *)rowIndexPath;
- (SSCollectionViewCellType)_cellTypeForRowIndexPath:(NSIndexPath *)indexPath;
- (UIView *)_extremityViewForSection:(NSUInteger)section type:(SSCollectionViewCellType)type;

- (NSMutableDictionary *)_sectionInfoForIndex:(NSUInteger)section;
- (id)_sectionInfoItemForKey:(NSString *)key section:(NSUInteger)section;
- (void)_setSectionInfoItem:(id)object forKey:(NSString *)key section:(NSUInteger)section;
@end

@implementation SSCollectionView

#pragma mark - Accessors

@synthesize dataSource = _dataSource;

- (void)setDataSource:(id<SSCollectionViewDataSource>)dataSource {
	_dataSource = dataSource;
	
	if (_delegate && _dataSource) {
		[self reloadData];
	}
}


@synthesize delegate = _delegate;

- (void)setDelegate:(id<SSCollectionViewDelegate>)delegate {
	_delegate = delegate;
	
	if (_delegate && _dataSource) {
		[self reloadData];
	}
}


@synthesize minimumColumnSpacing = _minimumColumnSpacing;
@synthesize rowSpacing = _rowSpacing;
@synthesize allowsSelection = _allowsSelection;

- (UIScrollView *)scrollView {
	return _tableView;
}


- (UIView *)backgroundView {
	return _tableView.backgroundView;
}


- (void)setBackgroundView:(UIView *)background {
	_tableView.backgroundView = background;
}


- (UIView *)collectionHeaderView {
	return _tableView.tableHeaderView;
}


- (void)setCollectionHeaderView:(UIView *)collectionHeaderView {
	_tableView.tableHeaderView = collectionHeaderView;
}


- (UIView *)collectionFooterView {
	return _tableView.tableFooterView;
}


- (void)setCollectionFooterView:(UIView *)collectionFooterView {
	_tableView.tableFooterView = collectionFooterView;
}


- (void)setBackgroundColor:(UIColor *)color {
	[super setBackgroundColor:color];
	_tableView.backgroundColor = color;
}


@synthesize extremitiesStyle = _extremitiesStyle;

- (void)setExtremitiesStyle:(SSCollectionViewExtremitiesStyle)style {
	if (_extremitiesStyle == style) {
		return;
	}
	
	_extremitiesStyle = style;
	[self reloadData];
}


#pragma mark - NSObject

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
	
	[_sectionCache removeAllObjects];
	[_sectionCache release];
	_sectionCache = nil;
	
	[super dealloc];
}


#pragma mark - UIView

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
		self.backgroundColor = [UIColor whiteColor];
		self.opaque = YES;
		
		_minimumColumnSpacing = 10.0f;
		_rowSpacing = 20.0f;
		_allowsSelection = YES;
		_visibleItems = [[NSMutableSet alloc] init];
		_reuseableItems = [[NSMutableDictionary alloc] init];
		_sectionCache = [[NSMutableDictionary alloc] init];
		
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
	BOOL shouldReload = (CGSizeEqualToSize(frame.size, self.frame.size) == NO);
	[super setFrame:frame];
	
	if (shouldReload) {
		[self reloadData];
	}
}


#pragma mark - SSCollectionView

- (void)reloadData {
	[_sectionCache removeAllObjects];
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
	__block SSCollectionViewItem *item = nil;
	[_visibleItems enumerateObjectsUsingBlock:^(id object, BOOL *stop) {
		if ([[(SSCollectionViewItem *)object indexPath] isEqual:indexPath]) {
			item = object;
			*stop = YES;
		}
	}];	
	return item;
}


- (NSIndexPath *)indexPathForItem:(SSCollectionViewItem *)item {
	return item.indexPath;
}


- (void)selectItemAtIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated scrollPosition:(SSCollectionViewScrollPosition)scrollPosition {
	// Notify delegate that it will select
	if ([self.delegate respondsToSelector:@selector(collectionView:willSelectItemAtIndexPath:)]) {
		[self.delegate collectionView:self willSelectItemAtIndexPath:indexPath];
	}
	
	// Select
	SSCollectionViewItem *item = [self itemPathForIndex:indexPath];
	[item setHighlighted:NO animated:NO];
	[item setSelected:YES animated:YES];
	
	// Scroll to position
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
	
	// Deselect
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
	[indexPaths enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop) {
		NSIndexPath *itemIndexPath = (NSIndexPath *)object;
		NSIndexPath *rowIndexPath = [self _cellIndexPathFromItemIndexPath:itemIndexPath];
		if (![rowIndexPaths containsObject:rowIndexPath]) {
			[rowIndexPaths addObject:rowIndexPath];
		}
	}];
	[_tableView reloadRowsAtIndexPaths:rowIndexPaths withRowAnimation:UITableViewRowAnimationFade];	
	[rowIndexPaths release];
}


- (NSUInteger)numberOfSections {
	if ([_dataSource respondsToSelector:@selector(numberOfSectionsInCollectionView:)]) {
		return [_dataSource numberOfSectionsInCollectionView:self];
	}
	
	return 1;
}


- (NSUInteger)numberOfItemsInSection:(NSUInteger)section {
	NSNumber *items = [self _sectionInfoItemForKey:kSSCollectionViewSectionNumberOfItemsKey section:section];	
	if (!items) {
		if ([_dataSource respondsToSelector:@selector(collectionView:numberOfItemsInSection:)] == NO) {
			return 0;
		}
		items = [NSNumber numberWithUnsignedInteger:[_dataSource collectionView:self numberOfItemsInSection:section]];
		[self _setSectionInfoItem:items forKey:kSSCollectionViewSectionNumberOfItemsKey section:section];
	}
	return [items unsignedIntegerValue];
}


- (CGRect)rectForSection:(NSUInteger)section {
	return [_tableView rectForSection:(NSInteger)section];
}


- (CGRect)rectForHeaderInSection:(NSUInteger)section {
	return [_tableView rectForSection:(NSInteger)section];
}


- (CGRect)rectForFooterInSection:(NSUInteger)section {
	return [_tableView rectForFooterInSection:(NSInteger)section];
}


#pragma mark - Private Methods

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
	[items enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop) {
		[self _reuseItem:(SSCollectionViewItem *)object];
	}];
}


- (CGSize)_itemSizeForSection:(NSUInteger)section {
	NSValue *size = [self _sectionInfoItemForKey:kSSCollectionViewSectionItemSizeKey section:section];
	if (size) {
		return [size CGSizeValue];
	}
	
	if ([_delegate respondsToSelector:@selector(collectionView:itemSizeForSection:)] == NO) {
		[[NSException exceptionWithName:SSCollectionViewInvalidItemSizeExceptionName reason:SSCollectionViewInvalidItemSizeExceptionReason userInfo:nil] raise];
		return CGSizeZero;
	}
	
	CGSize itemSize = [_delegate collectionView:self itemSizeForSection:section];
	if (CGSizeEqualToSize(itemSize, CGSizeZero)) {
		[[NSException exceptionWithName:SSCollectionViewInvalidItemSizeExceptionName reason:SSCollectionViewInvalidItemSizeExceptionReason userInfo:nil] raise];
		return CGSizeZero;
	}
	[self _setSectionInfoItem:[NSValue valueWithCGSize:itemSize] forKey:kSSCollectionViewSectionItemSizeKey section:section];
	
	return itemSize;
}


- (NSUInteger)_numberOfItemsPerRowForSection:(NSUInteger)section {
	NSNumber *items = [self _sectionInfoItemForKey:kSSCollectionViewSectionNumberOfItemsPerRowsKey section:section];
	if (items) {
		return [items unsignedIntegerValue];
	}
	
	CGSize itemSize = [self _itemSizeForSection:section];
	NSUInteger itemsPerRow = (NSUInteger)floorf(self.frame.size.width / (itemSize.width + _minimumColumnSpacing));
	[self _setSectionInfoItem:[NSNumber numberWithUnsignedInteger:itemsPerRow] forKey:kSSCollectionViewSectionNumberOfItemsPerRowsKey section:section];
	return itemsPerRow;
}


- (NSUInteger)_numberOfRowsInSection:(NSUInteger)section {
	NSNumber *numberOfRows = [self _sectionInfoItemForKey:kSSCollectionViewSectionNumberOfRowsKey section:section];
	if (numberOfRows) {
		return [numberOfRows unsignedIntegerValue];
	}

	NSUInteger totalItems = [self numberOfItemsInSection:section];
	NSUInteger itemsPerRow = [self _numberOfItemsPerRowForSection:section];

	if (itemsPerRow == 0) {
		return 0;
	}

	NSUInteger rows = (NSUInteger)ceilf((CGFloat)totalItems / (CGFloat)itemsPerRow);

	// Check for headers and footers
	if (_extremitiesStyle == SSCollectionViewExtremitiesStyleScrolling) {
		if ([self _sectionInfoItemForKey:kSSCollectionViewSectionHeaderViewKey section:section]) {
			rows++;
		}

		if ([self _sectionInfoItemForKey:kSSCollectionViewSectionFooterViewKey section:section]) {
			rows++;
		}
	}

	[self _setSectionInfoItem:[NSNumber numberWithUnsignedInteger:rows] forKey:kSSCollectionViewSectionNumberOfRowsKey section:section];

	return rows;
}


- (CGFloat)_itemSpacingForSection:(NSUInteger)section {
	CGSize itemSize = [self _itemSizeForSection:section];
	NSUInteger itemsPerRow = [self _numberOfItemsPerRowForSection:section];
	return roundf((self.frame.size.width - (itemSize.width * (CGFloat)itemsPerRow)) / (itemsPerRow + 1));
}


- (NSArray *)_itemsForRowIndexPath:(NSIndexPath *)rowIndexPath {
	NSUInteger totalItems = [self numberOfItemsInSection:rowIndexPath.section];
	NSUInteger itemsPerRow = [self _numberOfItemsPerRowForSection:rowIndexPath.section];
	
	NSUInteger row = (NSUInteger)rowIndexPath.row;
	
	// Check for header
	if (_extremitiesStyle == SSCollectionViewExtremitiesStyleScrolling &&
		[self _sectionInfoItemForKey:kSSCollectionViewSectionHeaderViewKey section:rowIndexPath.section]) {
		row--;
	}
	
	NSUInteger startIndex = itemsPerRow * row;
	NSUInteger endIndex = (NSUInteger)fmin(totalItems, startIndex + itemsPerRow);
	
	NSMutableArray *items = [[[NSMutableArray alloc] initWithCapacity:endIndex - startIndex] autorelease];
	
	for (NSUInteger i = startIndex; i < endIndex; i++) {
		NSIndexPath *itemIndexPath = [NSIndexPath indexPathForRow:i inSection:rowIndexPath.section];
		SSCollectionViewItem *item = [_dataSource collectionView:self itemForIndexPath:itemIndexPath];
		if (item == nil) {
			NSException *exception = [NSException exceptionWithName:kSSCollectionViewNilItemExceptionName 
															 reason:kSSCollectionViewNilItemExceptionReason userInfo:nil];
			[exception raise];
			return nil;
		}
		
		item.tag = (NSInteger)i;
		item.indexPath = itemIndexPath;
		item.collectionView = self;
		[_visibleItems addObject:item];
		[items addObject:item];
	}
	
	return items;
}


- (NSIndexPath *)_cellIndexPathFromItemIndexPath:(NSIndexPath *)rowIndexPath {
	NSUInteger itemsPerRow = [self _numberOfItemsPerRowForSection:rowIndexPath.section];
	
	// Avoid division by zero
	if (itemsPerRow == 0) {
		return nil;
	}	
	
	NSUInteger row = (NSUInteger)floor(rowIndexPath.row / itemsPerRow);
	NSUInteger offset = 0;
	if (_extremitiesStyle == SSCollectionViewExtremitiesStyleScrolling &&
		[self _sectionInfoItemForKey:kSSCollectionViewSectionHeaderViewKey section:rowIndexPath.row]) {
		offset = 1;
	}
	
	return [NSIndexPath indexPathForRow:(row + offset) inSection:rowIndexPath.section];
}


- (SSCollectionViewCellType)_cellTypeForRowIndexPath:(NSIndexPath *)indexPath {
	// If extremity style is fixed, everything is a row
	if (_extremitiesStyle == SSCollectionViewExtremitiesStyleFixed) {
		return SSCollectionViewCellTypeRow;
	}
	
	// Check for header
	if (indexPath.row == 0 && [self _sectionInfoItemForKey:kSSCollectionViewSectionHeaderViewKey section:indexPath.section]) {
		return SSCollectionViewCellTypeHeader;
	}

	// Check for footer
	BOOL hasFooter = ([self _sectionInfoItemForKey:kSSCollectionViewSectionFooterViewKey section:indexPath.section] != nil);
	if (hasFooter && (NSUInteger)indexPath.row == [self _numberOfRowsInSection:indexPath.section] - 1) {
		return SSCollectionViewCellTypeFooter;
	}
	
	return SSCollectionViewCellTypeRow;
}


- (UIView *)_extremityViewForSection:(NSUInteger)section type:(SSCollectionViewCellType)type {
	// Note: It might be good for this method to check if the cache has been set and hit the delegate if not. For now,
	// we are relying on UITableView to hit the delegate in the correct order.
	
	// Header
	if (type == SSCollectionViewCellTypeHeader) {
		return [self _sectionInfoItemForKey:kSSCollectionViewSectionHeaderViewKey section:section];
	}
	
	// Footer
	else if (type == SSCollectionViewCellTypeFooter) {
		return [self _sectionInfoItemForKey:kSSCollectionViewSectionFooterViewKey section:section];
	}
	
	return nil;
}


- (NSMutableDictionary *)_sectionInfoForIndex:(NSUInteger)section {
	NSNumber *sectionKey = [NSNumber numberWithUnsignedInteger:section];
	NSMutableDictionary *dictionary = [_sectionCache objectForKey:sectionKey];
	if (dictionary) {
		return dictionary;
	}
	
	dictionary = [[NSMutableDictionary alloc] init];
	[_sectionCache setObject:dictionary forKey:sectionKey];
	[dictionary release];
	
	return dictionary;
}


- (id)_sectionInfoItemForKey:(NSString *)key section:(NSUInteger)section {
	NSDictionary *dictionary = [self _sectionInfoForIndex:section];
	id object = [dictionary objectForKey:key];
	if ([object isEqual:[NSNull null]]) {
		return nil;
	}
	return object;
}


- (void)_setSectionInfoItem:(id)object forKey:(NSString *)key section:(NSUInteger)section {
	NSMutableDictionary *dictionary = [self _sectionInfoForIndex:section];
	if (!object) {
		object = [NSNull null];
	}
	[dictionary setObject:object forKey:key];
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return (NSInteger)[self numberOfSections];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return (NSInteger)[self _numberOfRowsInSection:(NSUInteger)section];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)rowIndexPath {
	static NSString *itemCellIdentifier = @"SSCollectionViewItemTableViewCellIdentifier";
	static NSString *extremityCellIdentifier = @"SSCollectionViewExtremityTableViewCellIdentifier";
	
	SSCollectionViewCellType cellType = [self _cellTypeForRowIndexPath:rowIndexPath];
	
	// Extremities
	if (cellType != SSCollectionViewCellTypeRow) {
		SSCollectionViewExtremityTableViewCell *cell = (SSCollectionViewExtremityTableViewCell *)[_tableView dequeueReusableCellWithIdentifier:extremityCellIdentifier];
		if (!cell) {
			cell = [[[SSCollectionViewExtremityTableViewCell alloc] initWithReuseIdentifier:extremityCellIdentifier] autorelease];
		}
		
		cell.extrimityView = [self _extremityViewForSection:rowIndexPath.section type:cellType];
		
		return cell;
	}
	
	// Normal row	
	SSCollectionViewItemTableViewCell *cell = (SSCollectionViewItemTableViewCell *)[_tableView dequeueReusableCellWithIdentifier:itemCellIdentifier];
	if (!cell) {
		cell = [[[SSCollectionViewItemTableViewCell alloc] initWithReuseIdentifier:itemCellIdentifier] autorelease];
		cell.collectionView = self;
	}
	
	cell.itemSize = [self _itemSizeForSection:rowIndexPath.section];
	cell.itemSpacing = [self _itemSpacingForSection:rowIndexPath.section];
	cell.items = [self _itemsForRowIndexPath:rowIndexPath];
	
	return cell;
}


#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)rowIndexPath {
	// If scrolling extremity style, provide the height for the extermity
	if (_extremitiesStyle == SSCollectionViewExtremitiesStyleScrolling) {
		SSCollectionViewCellType cellType = [self _cellTypeForRowIndexPath:rowIndexPath];
		
		// Header
		if (cellType == SSCollectionViewCellTypeHeader) {
			return [[self _sectionInfoItemForKey:kSSCollectionViewSectionHeaderHeightKey section:rowIndexPath.section] floatValue];
		}
		
		// Footer
		else if (cellType == SSCollectionViewCellTypeFooter) {
			return [[self _sectionInfoItemForKey:kSSCollectionViewSectionFooterHeightKey section:rowIndexPath.section] floatValue];
		}
	}

	// Row
	return [self _itemSizeForSection:rowIndexPath.section].height + _rowSpacing;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	// If scrolling extremity style, don't use table view's header since we will draw it in a cell
	if (_extremitiesStyle == SSCollectionViewExtremitiesStyleScrolling) {
		// Hit delegate and cache result for use later
		if ([_delegate respondsToSelector:@selector(collectionView:viewForHeaderInSection:)]) {
			UIView *view = [_delegate collectionView:self viewForHeaderInSection:(NSUInteger)section];
			[self _setSectionInfoItem:view forKey:kSSCollectionViewSectionHeaderViewKey section:(NSUInteger)section];
		}
		
		return nil;
	}
	
	// If the collection view's delegate provides a header, forward it to the table view
	if ([_delegate respondsToSelector:@selector(collectionView:viewForHeaderInSection:)]) {
		return [_delegate collectionView:self viewForHeaderInSection:(NSUInteger)section];
	}
	
	// Default to none
	return nil;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	// If scrolling extremity style, don't use table view's header since we will draw it in a cell
	if (_extremitiesStyle == SSCollectionViewExtremitiesStyleScrolling) {
		
		// Hit delegate and cache result for use later
		if ([_delegate respondsToSelector:@selector(collectionView:heightForHeaderInSection:)]) {
			CGFloat height = [_delegate collectionView:self heightForHeaderInSection:(NSUInteger)section];
			[self _setSectionInfoItem:[NSNumber numberWithFloat:height] forKey:kSSCollectionViewSectionHeaderHeightKey section:(NSUInteger)section];
		}
		return 0.0f;
	}
	
	// If the collection view's delegate provides a header height, forward it to the table view
	if ([_delegate respondsToSelector:@selector(collectionView:heightForHeaderInSection:)]) {
		return [_delegate collectionView:self heightForHeaderInSection:(NSUInteger)section];
	}
	
	// Default to none
	return 0.0f;
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
	// If scrolling extremity style, don't use table view's footer since we will draw it in a cell
	if (_extremitiesStyle == SSCollectionViewExtremitiesStyleScrolling) {
		
		// Hit delegate and cache result for use later
		if ([_delegate respondsToSelector:@selector(collectionView:viewForFooterInSection:)]) {
			UIView *view = [_delegate collectionView:self viewForFooterInSection:(NSUInteger)section];
			[self _setSectionInfoItem:view forKey:kSSCollectionViewSectionFooterViewKey section:(NSUInteger)section];
		}
		return nil;
	}
	
	// If the collection view's delegate provides a footer, forward it to the table view
	if ([_delegate respondsToSelector:@selector(collectionView:viewForFooterInSection:)]) {
		return [_delegate collectionView:self viewForFooterInSection:(NSUInteger)section];
	}
	
	// Default to none
	return nil;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
	// If scrolling extremity style, don't use table view's footer since we will draw it in a cell
	if (_extremitiesStyle == SSCollectionViewExtremitiesStyleScrolling) {
		
		// Hit delegate and cache result for use later
		if ([_delegate respondsToSelector:@selector(collectionView:heightForFooterInSection:)]) {
			CGFloat height = [_delegate collectionView:self heightForFooterInSection:(NSUInteger)section];
			[self _setSectionInfoItem:[NSNumber numberWithFloat:height] forKey:kSSCollectionViewSectionFooterHeightKey section:(NSUInteger)section];
		}
		return 0.0f;
	}
	
	// If the collection view's delegate provides a footer height, forward it to the table view
	if ([_delegate respondsToSelector:@selector(collectionView:heightForFooterInSection:)]) {
		return [_delegate collectionView:self heightForFooterInSection:(NSUInteger)section];
	}
	
	// Default to none
	return 0.0f;
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
	// Make sure extremities are on top
	if ([cell isKindOfClass:[SSCollectionViewExtremityTableViewCell class]]) {
		// Put it under the scroll bar. I know this is awful.
		[cell removeFromSuperview];
		[tableView insertSubview:cell atIndex:[[tableView subviews] count] - 2];
		return;
	}
	
	// Forward delegate message for items if the delegate implements the delegate
	if ([_delegate respondsToSelector:@selector(collectionView:willDisplayItem:atIndexPath:)]) {
		NSArray *items = [self _itemsForRowIndexPath:indexPath];
		if (!items) {
			return;
		}
		
		// Send for each item
		for (SSCollectionViewItem *item in items) {
			[_delegate collectionView:self willDisplayItem:item atIndexPath:item.indexPath];
		}
	}
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)aScrollView {
	if ([_delegate respondsToSelector:@selector(scrollViewDidScroll:)]) {
		[_delegate scrollViewDidScroll:aScrollView];
	}
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)aScrollView {
	if ([_delegate respondsToSelector:@selector(scrollViewWillBeginDragging:)]) {
		[_delegate scrollViewWillBeginDragging:aScrollView];
	}
}


- (void)scrollViewDidEndDragging:(UIScrollView *)aScrollView willDecelerate:(BOOL)decelerate {
	if ([_delegate respondsToSelector:@selector(scrollViewDidEndDragging:willDecelerate:)]) {
		[_delegate scrollViewDidEndDragging:aScrollView willDecelerate:decelerate];
	}
}


- (void)scrollViewWillBeginDecelerating:(UIScrollView *)aScrollView {
	if ([_delegate respondsToSelector:@selector(scrollViewWillBeginDecelerating:)]) {
		[_delegate scrollViewWillBeginDecelerating:aScrollView];
	}
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)aScrollView {
	if ([_delegate respondsToSelector:@selector(scrollViewDidEndDecelerating:)]) {
		[_delegate scrollViewDidEndDecelerating:aScrollView];
	}
}


- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)aScrollView {
	if ([_delegate respondsToSelector:@selector(scrollViewDidEndScrollingAnimation:)]) {
		[_delegate scrollViewDidEndScrollingAnimation:aScrollView];
	}
}


- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)aScrollView {
	if ([_delegate respondsToSelector:@selector(scrollViewShouldScrollToTop:)]) {
		return [_delegate scrollViewShouldScrollToTop:aScrollView];
	}
	
	return YES;
}


- (void)scrollViewDidScrollToTop:(UIScrollView *)aScrollView {
	if ([_delegate respondsToSelector:@selector(scrollViewDidScrollToTop:)]) {
		[_delegate scrollViewDidScrollToTop:aScrollView];
	}
}

@end
