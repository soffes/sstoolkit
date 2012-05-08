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
#import "SSCollectionViewTableView.h"
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

@interface SSCollectionView () <UITableViewDataSource, UITableViewDelegate>
- (void)_initialize;
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

@implementation SSCollectionView {
	SSCollectionViewTableView *_tableView;
	
	NSMutableSet *_visibleItems;
	NSMutableDictionary *_reuseableItems;
	NSMutableDictionary *_sectionCache;
	NSMutableArray *_updates;
	NSInteger _updatesDepth;
}

#pragma mark - Accessors

@synthesize dataSource = _dataSource;
@synthesize delegate = _delegate;
@synthesize minimumColumnSpacing = _minimumColumnSpacing;
@synthesize rowSpacing = _rowSpacing;
@synthesize allowsSelection = _allowsSelection;
@synthesize extremitiesStyle = _extremitiesStyle;
@synthesize rowBackgroundColor = _rowBackgroundColor;

#pragma mark - NSObject

- (void)dealloc {
	self.dataSource = nil;
	self.delegate = nil;
	
	[_visibleItems removeAllObjects];
	_visibleItems = nil;
	
	[_reuseableItems removeAllObjects];
	_reuseableItems = nil;
	
	_tableView.dataSource = nil;
	_tableView.delegate = nil;
	
	[_sectionCache removeAllObjects];
	_sectionCache = nil;
	
	[_updates removeAllObjects];
	_updates = nil;
	
	_rowBackgroundColor = nil;
}


#pragma mark - UIView

- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
		[self _initialize];
    }
    return self;
}


- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
		[self _initialize];
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


- (void)setBackgroundColor:(UIColor *)color {
	[super setBackgroundColor:color];
	_tableView.backgroundColor = color;
}


#pragma mark - Configuring a Collection View

- (SSCollectionViewItem *)dequeueReusableItemWithIdentifier:(NSString *)identifier {
	if (!identifier) {
		return nil;
	}
	
	NSMutableArray *items = [_reuseableItems objectForKey:identifier];
	if (!items || [items count] == 0) {
		return nil;
	}
	
	SSCollectionViewItem *item = [items lastObject];
	[items removeObject:item];
	
	[item prepareForReuse];
	return item;
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


- (NSUInteger)numberOfSections {
	if ([_dataSource respondsToSelector:@selector(numberOfSectionsInCollectionView:)]) {
		return [_dataSource numberOfSectionsInCollectionView:self];
	}
	
	return 1;
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


- (void)setExtremitiesStyle:(SSCollectionViewExtremitiesStyle)style {
	if (_extremitiesStyle == style) {
		return;
	}
	
	_extremitiesStyle = style;
	[self reloadData];
}


#pragma mark - Accessing Items and Sections

- (SSCollectionViewItem *)itemForIndexPath:(NSIndexPath *)indexPath {
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


- (NSArray *)visibleItems {
	return [_visibleItems allObjects];
}


- (NSArray *)indexPathsForVisibleRows {
	NSMutableArray *indexPaths = [[NSMutableArray alloc] initWithCapacity:[_visibleItems count]];
	for (SSCollectionViewItem *item in _visibleItems) {
		[indexPaths addObject:[self indexPathForItem:item]];
	}
	return indexPaths;
}


#pragma mark - Scrolling the Collection View

- (void)scrollToItemAtIndexPath:(NSIndexPath *)indexPath atScrollPosition:(SSCollectionViewScrollPosition)scrollPosition animated:(BOOL)animated {
	NSIndexPath *cellIndexPath = [self _cellIndexPathFromItemIndexPath:indexPath];
	[_tableView scrollToRowAtIndexPath:cellIndexPath atScrollPosition:(UITableViewScrollPosition)scrollPosition animated:animated];
}


- (UIScrollView *)scrollView {
	return _tableView;
}


#pragma mark - Managing Selections

- (void)selectItemAtIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated scrollPosition:(SSCollectionViewScrollPosition)scrollPosition {
	// Notify delegate that it will select
	if ([self.delegate respondsToSelector:@selector(collectionView:willSelectItemAtIndexPath:)]) {
		[self.delegate collectionView:self willSelectItemAtIndexPath:indexPath];
	}
	
	// Select
	SSCollectionViewItem *item = [self itemForIndexPath:indexPath];
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
	SSCollectionViewItem *item = [self itemForIndexPath:indexPath];
	[item setHighlighted:NO animated:NO];
	[item setSelected:NO animated:YES];
	
	// Notify delegate that it did deselection
	if ([self.delegate respondsToSelector:@selector(collectionView:didDeselectItemAtIndexPath:)]) {
		[self.delegate collectionView:self didDeselectItemAtIndexPath:indexPath];
	}
}


#pragma mark - Inserting, Deleting, and Moving Items and Sections

- (void)beginUpdates {
	[_tableView beginUpdates];
	
	// TODO: This should be thread safe and it currently is not
	if (!_updates) {
		_updates = [[NSMutableArray alloc] init];
		_updatesDepth = -1;
	}
	
	// Update blocks can be nested
	_updatesDepth++;
	[_updates addObject:[NSMutableArray array]];
}


- (void)endUpdates {
	// Aggregate all item internal updates
	NSMutableDictionary *sections = [[NSMutableDictionary alloc] init];
	for (NSDictionary *update in [_updates objectAtIndex:_updatesDepth]) {
		NSIndexPath *indexPath = [update objectForKey:@"indexPath"];
		NSNumber *key = [NSNumber numberWithInteger:indexPath.section];
		
		NSMutableDictionary *section = [sections objectForKey:key];
		if (!section) {
			section = [NSMutableDictionary dictionary];
			[sections setObject:section forKey:key];
		}
		
		// Update item closest to the top
		NSNumber *item = [section objectForKey:@"item"];
		if (!item || indexPath.row < [item integerValue]) {
			[section setObject:[NSNumber numberWithInteger:indexPath.row] forKey:@"item"];
			[section setObject:[update objectForKey:@"animation"] forKey:@"animation"];
		}
		
		// Update delta
		NSInteger delta = [[section objectForKey:@"delta"] integerValue];
		if ([[update objectForKey:@"type"] isEqualToString:@"insert"]) {
			delta++;
		} else if ([[update objectForKey:@"type"] isEqualToString:@"delete"]) {
			delta--;
		}
		
		[section setObject:[NSNumber numberWithInteger:delta] forKey:@"delta"];
	}
	
	// Process each section that has changes and apply table view updates
	for (NSNumber *key in sections) {
		NSDictionary *section = [sections objectForKey:key];
		NSInteger sectionIndex = [key integerValue];
		
		// Add or delete cells
		NSInteger itemsDelta = [[section objectForKey:@"delta"] integerValue];
		NSInteger totalItems = [self numberOfItemsInSection:sectionIndex];
		NSInteger itemsPerRow = [self _numberOfItemsPerRowForSection:sectionIndex];
		
		NSInteger rows = itemsPerRow == 0 ? 0 : (NSInteger)ceilf((CGFloat)totalItems / (CGFloat)itemsPerRow);
		
		totalItems += itemsDelta;
		NSInteger rowsDelta = rows - (itemsPerRow == 0 ? 0 : (NSInteger)ceilf((CGFloat)totalItems / (CGFloat)itemsPerRow));
		
		UITableViewRowAnimation animation = (UITableViewRowAnimation)[[section objectForKey:@"animation"] integerValue];
		if (rowsDelta != 0) {			
			// Add rows
			if (rowsDelta > 0) {
				for (NSInteger i = 1; i <= rowsDelta; i++) {
					NSArray *indexPaths = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:rows + i inSection:sectionIndex]];
					[_tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:animation];
				}
			}
			
			// Delete rows
			else {
				for (NSInteger i = rowsDelta; i > 0; i--) {
					NSArray *indexPaths = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:rows - i inSection:sectionIndex]];
					[_tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:animation];
				}
			}
		}
		
		// Reload changed cells
		NSNumber *top = [section objectForKey:@"item"];
		if (top) {
			NSInteger topIndex = [top integerValue];
			NSInteger topRow = [self _cellIndexPathFromItemIndexPath:[NSIndexPath indexPathForRow:topIndex inSection:sectionIndex]].row;
			for (NSInteger i = topRow; i < rows + rowsDelta; i++) {
				NSArray *indexPaths = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:i inSection:sectionIndex]];
				[_tableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:animation];
			}
		}
	}
		
	// Apply updates
	[_tableView endUpdates];
	
	// Clean up internal representation
	[_updates removeObjectAtIndex:_updatesDepth];
	_updatesDepth--;
}


- (void)insertItemsAtIndexPaths:(NSArray *)indexPaths withItemAnimation:(SSCollectionViewItemAnimation)animation {
	if (_updatesDepth < 0) {
		[[NSException exceptionWithName:@"SSCollectionViewNoUpdatesBlockException" reason:@"You must call `insertItemsAtIndexPaths:withItemAnimation:` in a `beginUpdates`/`endUpdates` block." userInfo:nil] raise];
		return;
	}
	
	for (NSIndexPath *indexPath in indexPaths) {
		[[_updates objectAtIndex:_updatesDepth] addObject:[NSDictionary dictionaryWithObjectsAndKeys:
														   @"insert", @"type",
														   indexPath, @"indexPath",
														   [NSNumber numberWithInteger:(NSInteger)animation], @"animation",
														   nil]];
	}
}


- (void)deleteItemsAtIndexPaths:(NSArray *)indexPaths withItemAnimation:(SSCollectionViewItemAnimation)animation {
	if (_updatesDepth < 0) {
		[[NSException exceptionWithName:@"SSCollectionViewNoUpdatesBlockException" reason:@"You must call `deleteItemsAtIndexPaths:withItemAnimation:` in a `beginUpdates`/`endUpdates` block." userInfo:nil] raise];
		return;
	}
	
	for (NSIndexPath *indexPath in indexPaths) {
		[[_updates objectAtIndex:_updatesDepth] addObject:[NSDictionary dictionaryWithObjectsAndKeys:
														   @"delete", @"type",
														   indexPath, @"indexPath",
														   [NSNumber numberWithInteger:(NSInteger)animation], @"animation",
														   nil]];
	}
}


- (void)insertSections:(NSIndexSet *)sections withItemAnimation:(SSCollectionViewItemAnimation)animation {
	[_tableView insertSections:sections withRowAnimation:(UITableViewRowAnimation)animation];
}


- (void)deleteSections:(NSIndexSet *)sections withItemAnimation:(SSCollectionViewItemAnimation)animation {
	[_tableView deleteSections:sections withRowAnimation:(UITableViewRowAnimation)animation];
}


#pragma mark - Reloading the Collection View

- (void)reloadData {
	if (![self superview]) {
		return;
	}
	
	[_sectionCache removeAllObjects];
	[_tableView reloadData];
	
	if (_extremitiesStyle == SSCollectionViewExtremitiesStyleScrolling) {
		
	}
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
}


#pragma mark - Accessing Drawing Areas of the Collection View

- (CGRect)rectForSection:(NSUInteger)section {
	return [_tableView rectForSection:(NSInteger)section];
}


- (CGRect)rectForFooterInSection:(NSUInteger)section {
	return [_tableView rectForFooterInSection:(NSInteger)section];
}


- (CGRect)rectForHeaderInSection:(NSUInteger)section {
	return [_tableView rectForSection:(NSInteger)section];
}


#pragma mark - Managing the Delegate and the Data Source

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


#pragma mark - Private Methods

- (void)_initialize {
	self.backgroundColor = [UIColor whiteColor];
	self.opaque = YES;
	
	_minimumColumnSpacing = 10.0f;
	_rowSpacing = 20.0f;
	_allowsSelection = YES;
	_visibleItems = [[NSMutableSet alloc] init];
	_reuseableItems = [[NSMutableDictionary alloc] init];
	_sectionCache = [[NSMutableDictionary alloc] init];
	
	_tableView = [[SSCollectionViewTableView alloc] initWithFrame:self.bounds];
	_tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	[_tableView _setDataSource:self];
	[_tableView _setDelegate:self];
	[self addSubview:_tableView];
}


- (void)_reuseItem:(SSCollectionViewItem *)item {
	[_visibleItems removeObject:item];
	
	NSAssert(item.reuseIdentifier != nil, @"[SSCollectionView] Your item identifier is nil. You should really provide a reuse identifier for %@", item);
	
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
		if ([self _extremityViewForSection:section type:SSCollectionViewCellTypeHeader]) {
			rows++;
		}

		if ([self _extremityViewForSection:section type:SSCollectionViewCellTypeFooter]) {
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
	
	NSMutableArray *items = [[NSMutableArray alloc] initWithCapacity:endIndex - startIndex];
	
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
	BOOL isHeader = (type == SSCollectionViewCellTypeHeader);
	NSString *key = isHeader ? kSSCollectionViewSectionHeaderViewKey : kSSCollectionViewSectionFooterViewKey;
	id extremity = [self _sectionInfoItemForKey:key section:section];
	
	// If the extremeity isn't cached, hit the delegate
	if (!extremity) {
		// Header
		if (isHeader) {
			if ([_delegate respondsToSelector:@selector(collectionView:viewForHeaderInSection:)]) {
				extremity = [_delegate collectionView:self viewForHeaderInSection:section];
			}
		}
		
		// Footer
		else {
			if ([_delegate respondsToSelector:@selector(collectionView:viewForFooterInSection:)]) {
				extremity = [_delegate collectionView:self viewForFooterInSection:section];
			}
		}
		
		// Handle nil
		if (!extremity) {
			extremity = [NSNull null];
		}
		
		// Cache
		[self _setSectionInfoItem:extremity forKey:key section:section];
	}
	
	// Return nil instead of null
	if (extremity == [NSNull null]) {
		return nil;
	}
	
	return extremity;
}


- (NSMutableDictionary *)_sectionInfoForIndex:(NSUInteger)section {
	NSNumber *sectionKey = [NSNumber numberWithUnsignedInteger:section];
	NSMutableDictionary *dictionary = [_sectionCache objectForKey:sectionKey];
	if (dictionary) {
		return dictionary;
	}
	
	dictionary = [[NSMutableDictionary alloc] init];
	[_sectionCache setObject:dictionary forKey:sectionKey];
	
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
			cell = [[SSCollectionViewExtremityTableViewCell alloc] initWithReuseIdentifier:extremityCellIdentifier];
		}
		
		cell.extrimityView = [self _extremityViewForSection:rowIndexPath.section type:cellType];
		
		return cell;
	}
	
	// Normal row	
	SSCollectionViewItemTableViewCell *cell = (SSCollectionViewItemTableViewCell *)[_tableView dequeueReusableCellWithIdentifier:itemCellIdentifier];
	if (!cell) {
		cell = [[SSCollectionViewItemTableViewCell alloc] initWithReuseIdentifier:itemCellIdentifier];
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
	if (_rowBackgroundColor) {
		cell.backgroundColor = _rowBackgroundColor;
	}
	
	// Make sure extremities are on top
	if ([cell isKindOfClass:[SSCollectionViewExtremityTableViewCell class]]) {
		// Put it under the scroll bar. I know this is awful.
		NSArray *subviews = [tableView subviews];
		if ([subviews count] > 2) {
			[cell removeFromSuperview];
			[tableView insertSubview:cell atIndex:[subviews count] - 2];
		}
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
