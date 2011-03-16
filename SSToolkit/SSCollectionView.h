//
//  SSCollectionView.h
//  SSToolkit
//
//  Created by Sam Soffes on 6/11/10.
//  Copyright 2009-2010 Sam Soffes. All rights reserved.
//

#import "SSCollectionViewItem.h"

@protocol SSCollectionViewDelegate;
@protocol SSCollectionViewDataSource;

/**
 @brief Simple collection view.
 
 This is very alphay. My goals are to be similar to UITableView and NSCollectionView when 
 possible. Currently it's pretty inefficient and doesn't reuse items and all items have to
 be the same size. Only scrolling vertically is currently supported.
 
 Multiple sections are not supported.
 
 Editing and performance will be my next focus. Then animating changes when data changes 
 and an option to disable that.
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

@property (nonatomic, assign) CGFloat minimumColumnSpacing;

/**
 @brief The spacing between each row in the receiver. This does not add space 
 above the first row or below the last.
 
 The row spacing is in points. The default is 20.
 */
@property (nonatomic, assign) CGFloat rowSpacing;

/**
 @brief The background view of the collection view.
 */
@property (nonatomic, retain) UIView *backgroundView;

/**
 @brief A Boolean value that determines whether selecting items is enabled.
 
 If the value of this property is <code>YES</code>, selecting is enabled, and if it is <code>NO</code>, 
 selecting is disabled. The default is <code>YES</code>.
 */
@property (nonatomic, assign) BOOL allowsSelection;

@property (nonatomic, retain, readonly) UIScrollView *scrollView;

/**
 @brief Reloads the items and sections of the receiver.
 */
- (void)reloadData;

/**
 @brief Returns a reusable collection view item object located by its identifier.
 
 @param identifier A string identifying the cell object to be reused.
 
 @return A SSCollectionViewItem object with the associated identifier or nil if no such object
 exists in the reusable-item queue.
 */
- (SSCollectionViewItem *)dequeueReusableItemWithIdentifier:(NSString *)identifier;

/**
 @brief Returns the collection view item at the specified index path.
 
 @param indexPath The index path locating the item in the receiver.
 
 @return An object representing a cell of the table or nil if the cell is not visible or indexPath is
 out of range.
 
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

- (void)selectItemAtIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated;

/**
 @brief Deselects a given item identified by index path, with an option to animate the deselection.
 
 <strong>Currently not implemented.</strong>
 
 @param indexPath An index path identifying an item in the receiver.
 @param animated <code>YES</code> if you want to animate the deselection and <code>NO</code> if the
 change should be immediate.
 */
- (void)deselectItemAtIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated;

/**
 @brief Scrolls the receiver until a row identified by index path is at a particular location on the screen.
 
 @param indexPath An index path that identifies an item in the collection view by its row index and its section index.
 @param animated <code>YES</code> if you want to animate the deselection and <code>NO</code> if the
 change should be immediate.
 */
- (void)scrollToItemAtIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated;

/**
 @brief Reloads the specified item.
 
 @param indexPath An index path that identifies an item in the collection view by its row index and its section index.
 */
- (void)reloadItemAtIndexPaths:(NSIndexPath *)indexPaths;

@end


@protocol SSCollectionViewDataSource <NSObject>

@required

- (NSInteger)collectionView:(SSCollectionView *)aCollectionView numberOfItemsInSection:(NSInteger)section;
- (SSCollectionViewItem *)collectionView:(SSCollectionView *)aCollectionView itemForIndexPath:(NSIndexPath *)indexPath;

@optional

- (NSInteger)numberOfSectionsInCollectionView:(SSCollectionView *)aCollectionView;

@end


@protocol SSCollectionViewDelegate <NSObject>

@required

- (CGSize)collectionView:(SSCollectionView *)aCollectionView itemSizeForSection:(NSInteger)section;

@optional

- (CGFloat)collectionView:(SSCollectionView *)aCollectionView heightForHeaderInSection:(NSInteger)section;
- (CGFloat)collectionView:(SSCollectionView *)aCollectionView heightForFooterInSection:(NSInteger)section;
- (void)collectionView:(SSCollectionView *)aCollectionView willSelectItemAtIndexPath:(NSIndexPath *)indexPath;
- (void)collectionView:(SSCollectionView *)aCollectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
- (void)collectionView:(SSCollectionView *)aCollectionView willDeselectItemAtIndexPath:(NSIndexPath *)indexPath;
- (void)collectionView:(SSCollectionView *)aCollectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath;

@end
