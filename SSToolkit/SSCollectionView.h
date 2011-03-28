//
//  SSCollectionView.h
//  SSToolkit
//
//  Created by Sam Soffes on 6/11/10.
//  Copyright 2010-2011 Sam Soffes. All rights reserved.
//

#import "SSCollectionViewItem.h"

typedef enum {
	SSCollectionViewScrollPositionNone = UITableViewScrollPositionNone,
	SSCollectionViewScrollPositionTop = UITableViewScrollPositionTop,
	SSCollectionViewScrollPositionMiddle = UITableViewScrollPositionMiddle,
	SSCollectionViewScrollPositionBottom = UITableViewScrollPositionBottom
} SSCollectionViewScrollPosition;

@protocol SSCollectionViewDelegate;
@protocol SSCollectionViewDataSource;

/**
 @brief Simple collection view.
 
 My goals are to be similar to UITableView and NSCollectionView when possible. Only scrolling vertically is currently
 supported.
 
 Editing will be my next focus. Then animating changes when data changes and an option to disable that.
 
 Note: NSIndexPath is uses the same way UITableView uses it. The <code>row</code> property is used to specify the item
 instead of row. This is done to make working with other classes that use NSIndexPath (like NSFetchedResultsController)
 easier.
 */
@interface SSCollectionView : UIView <UITableViewDataSource, UITableViewDelegate> {
	
@private
	
	id<SSCollectionViewDelegate> _delegate;
	id<SSCollectionViewDataSource> _dataSource;
	
	CGFloat _minimumColumnSpacing;
	CGFloat _rowSpacing;
	BOOL _allowsSelection;
	NSMutableSet *_visibleItems;
	NSMutableDictionary *_reuseableItems;
	NSMutableDictionary *_sectionCache;
	
	UITableView *_tableView;
}

/**
 @brief The object that acts as the data source of the receiving collection view.
 */
@property (nonatomic, assign) id<SSCollectionViewDataSource> dataSource;

/**
 @brief The object that acts as the delegate of the receiving collection view.
 */
@property (nonatomic, assign) id<SSCollectionViewDelegate> delegate;

/**
 @brief The minimum column spacing.
 
 The default is 0.
 */
@property (nonatomic, assign) CGFloat minimumColumnSpacing;

/**
 @brief The spacing between each row in the receiver. This does not add space above the first row or below the last.
 
 The row spacing is in points. The default is 20.
 */
@property (nonatomic, assign) CGFloat rowSpacing;

/**
 @brief The background view of the collection view.
 */
@property (nonatomic, retain) UIView *backgroundView;

/**
 @brief A Boolean value that determines whether selecting items is enabled.
 
 If the value of this property is <code>YES</code>, selecting is enabled, and if it is <code>NO</code>, selecting is
 disabled. The default is <code>YES</code>.
 */
@property (nonatomic, assign) BOOL allowsSelection;

/**
 @brief The internal scroll view of the collection view. The delegate must not be overridden.
 */
@property (nonatomic, retain, readonly) UIScrollView *scrollView;

/**
 @brief The number of sections in the collection view.
 
 <code>SSCollectionView</code> gets the value returned by this method from its data source and caches it.
 */
@property (nonatomic, assign, readonly) NSInteger numberOfSections;

/**
 @brief Reloads the items and sections of the receiver.
 */
- (void)reloadData;

/**
 @brief Returns a reusable collection view item object located by its identifier.
 
 @param identifier A string identifying the cell object to be reused.
 
 @return A <code>SSCollectionViewItem</code< object with the associated identifier or nil if no such object exists in the
 reusable-item queue.
 */
- (SSCollectionViewItem *)dequeueReusableItemWithIdentifier:(NSString *)identifier;

/**
 @brief Returns the collection view item at the specified index path.
 
 @param indexPath The index path locating the item in the receiver.
 
 @return An object representing a cell of the table or nil if the cell is not visible or indexPath is out of range.
 
 @see indexPathForItem:
 */
- (SSCollectionViewItem *)itemPathForIndex:(NSIndexPath *)indexPath;

/**
 @brief Returns an index path representing the row (index) and section of a given collection view item.
 
 @param item An item object of the collection view.
 
 @return An index path representing the row and section of the cell or nil if the index path is invalid.
 
 @see itemPathForIndex:
 */
- (NSIndexPath *)indexPathForItem:(SSCollectionViewItem *)item;

/**
 @brief Selects an item in the receiver identified by index path, optionally scrolling the item to a location in the
 receiver.
 
 @param indexPath An index path identifying an item in the receiver.
 @param animated <code>YES</code> if you want to animate the selection and any change in position, <code>NO</code> if
 the change should be immediate.
 @param scrollPosition A constant that identifies a relative position in the receiving collection view (top, middle,
 bottom) for the row when scrolling concludes.
 
 Calling this method does cause the delegate to receive a <code>collectionView:willSelectRowAtIndexPath:</code> and
 <code>collectionView:didSelectRowAtIndexPath:</code> message, which differs from <code>UITableView</code>.
 */
- (void)selectItemAtIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated scrollPosition:(SSCollectionViewScrollPosition)scrollPosition;

/**
 @brief Deselects a given item identified by index path, with an option to animate the deselection.
 
 @param indexPath An index path identifying an item in the receiver.
 @param animated <code>YES</code> if you want to animate the deselection and <code>NO</code> if the change should be
 immediate.
 */
- (void)deselectItemAtIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated;

/**
 @brief Scrolls the receiver until an item identified by index path is at a particular location on the screen.
 
 @param indexPath An index path that identifies an item in the table view by its row index and its section index.
 @param scrollPosition A constant that identifies a relative position in the receiving collection view (top, middle,
 bottom) for row when scrolling concludes.
 @param animated <code>YES</code> if you want to animate the change in position, <code>NO</code> if it should be
 immediate.
 */
- (void)scrollToItemAtIndexPath:(NSIndexPath *)indexPath atScrollPosition:(SSCollectionViewScrollPosition)scrollPosition animated:(BOOL)animated;

/**
 @brief Reloads the specified item.
 
 @param indexPath An index path that identifies an item in the collection view by its row index and its section index.
 */
- (void)reloadItemsAtIndexPaths:(NSArray *)indexPaths;

/**
 @brief Returns the number of item (collection view items) in a specified section.
 
 @param section An index number that identifies a section of the collection.
 
 @return The number of items in the section.
 */
- (NSInteger)numberOfItemsInSection:(NSInteger)section;

/**
 @brief Returns the drawing area for a specified section of the receiver.
 
 @param section An index number identifying a section of the collection view.
 
 @return A rectangle defining the area in which the collection view draws the section.
 */
- (CGRect)rectForSection:(NSInteger)section;

/**
 @brief Returns the drawing area for the header of the specified section.
 
 @param section An index number identifying a section of the collection view.
 
 @return A rectangle defining the area in which the collection view draws the section header.
 */
- (CGRect)rectForHeaderInSection:(NSInteger)section;

/**
 @brief Returns the drawing area for the footer of the specified section.
 
 @param section An index number identifying a section of the collection view.
 
 @return A rectangle defining the area in which the collection view draws the section footer.
 */
- (CGRect)rectForFooterInSection:(NSInteger)section;

@end


@protocol SSCollectionViewDataSource <NSObject>

@required

- (NSInteger)collectionView:(SSCollectionView *)aCollectionView numberOfItemsInSection:(NSInteger)section;
- (SSCollectionViewItem *)collectionView:(SSCollectionView *)aCollectionView itemForIndexPath:(NSIndexPath *)indexPath;

@optional

- (NSInteger)numberOfSectionsInCollectionView:(SSCollectionView *)aCollectionView;

@end


@protocol SSCollectionViewDelegate <NSObject, UIScrollViewDelegate>

@required

- (CGSize)collectionView:(SSCollectionView *)aCollectionView itemSizeForSection:(NSInteger)section;

@optional

- (UIView *)collectionView:(SSCollectionView *)aCollectionView viewForHeaderInSection:(NSInteger)section;
- (CGFloat)collectionView:(SSCollectionView *)aCollectionView heightForHeaderInSection:(NSInteger)section;
- (UIView *)collectionView:(SSCollectionView *)aCollectionView viewForFooterInSection:(NSInteger)section;
- (CGFloat)collectionView:(SSCollectionView *)aCollectionView heightForFooterInSection:(NSInteger)section;
- (void)collectionView:(SSCollectionView *)aCollectionView willSelectItemAtIndexPath:(NSIndexPath *)indexPath;
- (void)collectionView:(SSCollectionView *)aCollectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
- (void)collectionView:(SSCollectionView *)aCollectionView willDeselectItemAtIndexPath:(NSIndexPath *)indexPath;
- (void)collectionView:(SSCollectionView *)aCollectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath;

@end
