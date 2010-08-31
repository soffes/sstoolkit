//
//  SSCollectionView.h
//  SSToolkit
//
//  Created by Sam Soffes on 6/11/10.
//  Copyright 2010 Sam Soffes. All rights reserved.
//
//  This is very alphay. My goals are to be similar to UITableView
//  and NSCollectionView when possible. Currently it's pretty inefficient
//  and doesn't reuse items. Also resizing items isn't easy. Only scrolling
//  vertically is currently supported.
//
//  Multiple sections are not supported.
//
//  Editing will and performance will be my next focus. Then animating
//  changes when data changes and an option to disable that.
//

#import "SSCollectionViewItem.h"

//typedef enum {
//    SSCollectionViewScrollPositionNone = UITableViewScrollPositionNone,
//    SSCollectionViewScrollPositionTop = UITableViewScrollPositionTop,
//    SSCollectionViewScrollPositionTop = UITableViewScrollPositionTop,
//    SSCollectionViewScrollPositionTop = UITableViewScrollPositionTop
//} SSCollectionViewScrollPosition;
//
//typedef enum {
//    SSCollectionViewItemAnimationFade = UITableViewRowAnimationFade,
//    SSCollectionViewItemAnimationRight = UITableViewRowAnimationRight,
//    SSCollectionViewItemAnimationLeft = UITableViewRowAnimationLeft,
//    SSCollectionViewItemAnimationTop = UITableViewRowAnimationTop,
//    SSCollectionViewItemnimationBottom = UITableViewRowAnimationBottom,
//    SSCollectionViewItemAnimationNone = UITableViewRowAnimationNone,
//    SSCollectionViewItemAnimationMiddle = UITableViewRowAnimationMiddle,
//} SSCollectionViewItemAnimation;

@protocol SSCollectionViewDelegate;
@protocol SSCollectionViewDataSource;

@interface SSCollectionView : UIScrollView {
	
	id <SSCollectionViewDataSource> _dataSource;
	NSMutableArray *_items;
	
	CGFloat _rowHeight;
	CGFloat _rowSpacing;
	CGFloat _columnWidth;
	CGFloat _columnSpacing;
	
	UIView *_backgroundView;
	UIView *_backgroundHeaderView;
	UIView *_backgroundFooterView;
//	UIView *_collectionHeaderView;
//	UIView *_collectionFooterView;
	
	NSUInteger _minNumberOfColumns;
	NSUInteger _maxNumberOfColumns;
	
	CGSize _minItemSize;
	CGSize _maxItemSize;
	
	BOOL _allowsSelection;
//	BOOL _editing;
//	BOOL _allowsSelectionDuringEditing;
	
//	NSUInteger _selectedSection;
//	NSUInteger _selectedItem;
//	NSUInteger _lastSelectedSection;
//	NSUInteger _lastSelectedItem;
}

@property (nonatomic, assign) id<SSCollectionViewDataSource> dataSource;
@property (nonatomic, assign) id<SSCollectionViewDelegate> delegate;

@property (nonatomic, assign) CGFloat rowHeight;
@property (nonatomic, assign) CGFloat rowSpacing;
@property (nonatomic, assign) CGFloat columnWidth;
@property (nonatomic, assign) CGFloat columnSpacing;

@property (nonatomic, retain) UIView *backgroundView;
@property (nonatomic, retain) UIView *backgroundHeaderView;
@property (nonatomic, retain) UIView *backgroundFooterView;
//@property (nonatomic, retain) UIView *collectionHeaderView;
//@property (nonatomic, retain) UIView *collectionFooterView;

@property (nonatomic, assign) NSUInteger minNumberOfColumns;
@property (nonatomic, assign) NSUInteger maxNumberOfColumns;

@property (nonatomic, assign) CGSize minItemSize;
@property (nonatomic, assign) CGSize maxItemSize;

@property (nonatomic, assign) BOOL allowsSelection;
//@property (nonatomic, assign, getter=isEditing) BOOL editing;
//@property (nonatomic, assign) BOOL allowsSelectionDuringEditing;

- (void)reloadData;
- (SSCollectionViewItem *)dequeueReusableItemWithIdentifier:(NSString *)identifier;
- (SSCollectionViewItem *)itemPathForIndex:(NSIndexPath *)indexPath;
- (NSIndexPath *)indexPathForItem:(SSCollectionViewItem *)item;
- (void)deselectItemAtIndexPath:(NSIndexPath *)index animated:(BOOL)animated;

//- (NSInteger)numberOfSections;
//- (NSInteger)numberOfItemsInSection:(NSInteger)section;
//
//- (CGRect)rectForSection:(NSInteger)section;
//- (CGRect)rectForHeaderInSection:(NSInteger)section;
//- (CGRect)rectForFooterInSection:(NSInteger)section;
//- (CGRect)rectForItemAtIndex:(NSUInteger)index;
//
//- (NSIndexPath *)indexPathForItemAtPoint:(CGPoint)point;
//- (NSIndexPath *)indexPathForItem:(SSCollectionViewItem *)item;
//- (NSArray *)indexPathsForItemsInRect:(CGRect)rect;
//
//- (NSArray *)visibleItems;
//- (NSArray *)indexsForVisibleItems;
//
//- (void)scrollToItemAtIndexPath:(NSUInteger)index atScrollPosition:(UITableViewScrollPosition)scrollPosition animated:(BOOL)animated;
//- (void)scrollToNearestSelectedItemAtScrollPosition:(UITableViewScrollPosition)scrollPosition animated:(BOOL)animated;
//
//- (void)insertSections:(NSIndexSet *)sections withItemAnimation:(UITableViewItemAnimation)animation;
//- (void)deleteSections:(NSIndexSet *)sections withItemAnimation:(UITableViewItemAnimation)animation;
//- (void)reloadSections:(NSIndexSet *)sections withItemAnimation:(UITableViewItemAnimation)animation;
//
//- (void)insertItemsAtIndexPaths:(NSArray *)indexs withItemAnimation:(UITableViewItemAnimation)animation;
//- (void)deleteItemsAtIndexPaths:(NSArray *)indexs withItemAnimation:(UITableViewItemAnimation)animation;
//- (void)reloadItemsAtIndexPaths:(NSArray *)indexs withItemAnimation:(UITableViewItemAnimation)animation
//
//- (void)setEditing:(BOOL)editing animated:(BOOL)animated;
//
//- (NSIndexPath *)indexPathForSelectedItem;
//
//- (void)selectItemAtIndexPath:(NSIndexPath *)index animated:(BOOL)animated scrollPosition:(UITableViewScrollPosition)scrollPosition;

@end


@protocol SSCollectionViewDataSource <NSObject>

@required

- (NSInteger)collectionView:(SSCollectionView *)aCollectionView numberOfRowsInSection:(NSInteger)section;
- (SSCollectionViewItem *)collectionView:(SSCollectionView *)aCollectionView itemForIndexPath:(NSIndexPath *)indexPath;

@optional

//- (BOOL)collectionView:(SSCollectionView *)aCollectionView canEditItemAtIndexPath:(NSIndexPath *)indexPath;
//- (BOOL)collectionView:(SSCollectionView *)aCollectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath;
//
//- (void)collectionView:(SSCollectionView *)aCollectionView commitEditingStyle:(SSCollectionViewItemEditingStyle)editingStyle forItemAtIndexPath:(NSIndexPath *)indexPath;
//
//- (void)collectionView:(SSCollectionView *)aCollectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath;

@end


@protocol SSCollectionViewDelegate <NSObject, UIScrollViewDelegate>

@optional

- (void)collectionView:(SSCollectionView *)aCollectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;

//- (void)collectionView:(SSCollectionView *)aCollectionView willDisplayItem:(SSCollectionViewItem *)item forIndexPath:(NSIndexPath *)indexPath;
//
//- (UITableViewItemEditingStyle)tableView:(UITableView *)tableView editingStyleForItemAtIndexPath:(NSIndexPath *)indexPath;
//- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForItemAtIndexPath:(NSIndexPath *)indexPath;
//- (void)tableView:(UITableView*)tableView willBeginEditingItemAtIndexPath:(NSIndexPath *)indexPath;
//- (void)tableView:(UITableView*)tableView didEndEditingItemAtIndexPath:(NSIndexPath *)indexPath;
//
//- (NSUInteger)aCollectionView:(SSCollectionView *)aCollectionView targetIndexPathForMoveFromItemAtIndexPath:(NSIndexPath *)indexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath;               

@end
