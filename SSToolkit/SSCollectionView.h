//
//  SSCollectionView.h
//  SSToolkit
//
//  Created by Sam Soffes on 6/11/10.
//  Copyright 2010-2011 Sam Soffes. All rights reserved.
//

#import "SSCollectionViewItem.h"

/**
 The position in the collection view (top, middle, bottom) to which a given item is scrolled.
 */
typedef enum {
	/**
	 The collection view scrolls the items of interest to be fully visible with a minimum of movement. If the item is
	 already fully visible, no scrolling occurs. For example, if the item is above the visible area, the behavior is
	 identical to that specified by `SSCollectionViewScrollPositionTop`. This is the default.
	 */
	SSCollectionViewScrollPositionNone = UITableViewScrollPositionNone,
	
	/** The collection view scrolls the item of interest to the top of the visible collection view. */
	SSCollectionViewScrollPositionTop = UITableViewScrollPositionTop,
	
	/** The collection view scrolls the item of interest to the middle of the visible collection view. */
	SSCollectionViewScrollPositionMiddle = UITableViewScrollPositionMiddle,
	
	/** The collection view scrolls the item of interest to the bottom of the visible collection view. */
	SSCollectionViewScrollPositionBottom = UITableViewScrollPositionBottom
} SSCollectionViewScrollPosition;

/**
 The style of how headers and footers scroll.
 */
typedef enum {
	/** Headers and footer to behave like a `UITableView` with its style set to `UITableViewStylePlain`. */
	SSCollectionViewExtremitiesStyleFixed = UITableViewStylePlain,
	
	/** Headers and footer to behave like a `UITableView` with its style set to `UITableViewStyleGrouped`. */
	SSCollectionViewExtremitiesStyleScrolling = UITableViewStyleGrouped
} SSCollectionViewExtremitiesStyle;

@protocol SSCollectionViewDataSource;
@protocol SSCollectionViewDelegate;

/**
 Simple collection view.
 
 My goals are to be similar to UITableView and NSCollectionView when possible. Only scrolling vertically is currently
 supported.
 
 Editing will be my next focus. Then animating changes when data changes and an option to disable that.
 
 Note: NSIndexPath is uses the same way UITableView uses it. The `row` property is used to specify the item
 instead of row. This is done to make working with other classes that use NSIndexPath (like NSFetchedResultsController)
 easier.
 */
@interface SSCollectionView : UIView <UITableViewDataSource, UITableViewDelegate> {
	
@private
	
	id<SSCollectionViewDelegate> _delegate;
	id<SSCollectionViewDataSource> _dataSource;
	
	SSCollectionViewExtremitiesStyle _extremitiesStyle;
	CGFloat _minimumColumnSpacing;
	CGFloat _rowSpacing;
	BOOL _allowsSelection;
	NSMutableSet *_visibleItems;
	NSMutableDictionary *_reuseableItems;
	NSMutableDictionary *_sectionCache;
	
	UITableView *_tableView;
}

/**
 The object that acts as the data source of the receiving collection view.
 */
@property (nonatomic, assign) id<SSCollectionViewDataSource> dataSource;

/**
 The object that acts as the delegate of the receiving collection view.
 */
@property (nonatomic, assign) id<SSCollectionViewDelegate> delegate;

/**
 The style of the receiving collection view's headers and footers.
 
 Setting to `SSCollectionViewExtremitiesStyleFixed` will cause the headers and footer to behave like a `UITableView`
 with its style set to `UITableViewStylePlain`. Setting to `SSCollectionViewExtremitiesStyleScrolling` will cause the
 headers and footer to behave like a `UITableView` with its style set to `UITableViewStyleGrouped`. The default is
 `SSCollectionViewExtremitiesStyleFixed`.
 */
@property (nonatomic, assign) SSCollectionViewExtremitiesStyle extremitiesStyle;

/**
 The minimum column spacing.
 
 The default is `0.0`.
 */
@property (nonatomic, assign) CGFloat minimumColumnSpacing;

/**
 The spacing between each row in the receiver. This does not add space above the first row or below the last.
 
 The row spacing is in points. The default is `20.0`.
 */
@property (nonatomic, assign) CGFloat rowSpacing;

/**
 The background view of the collection view.
 */
@property (nonatomic, retain) UIView *backgroundView;

/**
 Returns an accessory view that is displayed above the collection.
 
 The default value is `nil`. The collection header view is different from a section header.
 */
@property (nonatomic, retain) UIView *collectionHeaderView;

/**
 Returns an accessory view that is displayed below the collection.
 
 The default value is `nil`. The collection footer view is different from a section footer.
 */
@property (nonatomic, retain) UIView *collectionFooterView;

/**
 A Boolean value that determines whether selecting items is enabled.
 
 If the value of this property is `YES`, selecting is enabled, and if it is `NO`, selecting is disabled. The default is
 `YES`.
 */
@property (nonatomic, assign) BOOL allowsSelection;

/**
 The internal scroll view of the collection view. The delegate must not be overridden.
 */
@property (nonatomic, retain, readonly) UIScrollView *scrollView;

/**
 The number of sections in the collection view.
 
 `SSCollectionView` gets the value returned by this method from its data source and caches it.
 */
@property (nonatomic, assign, readonly) NSUInteger numberOfSections;

/**
 Reloads the items and sections of the receiver.
 */
- (void)reloadData;

/**
 Returns a reusable collection view item object located by its identifier.
 
 @param identifier A string identifying the cell object to be reused.
 
 @return A `SSCollectionViewItem` object with the associated identifier or nil if no such object exists in the
 reusable-item queue.
 */
- (SSCollectionViewItem *)dequeueReusableItemWithIdentifier:(NSString *)identifier;

/**
 Returns the collection view item at the specified index path.
 
 @param indexPath The index path locating the item in the receiver.
 
 @return An object representing a cell of the table or nil if the cell is not visible or indexPath is out of range.
 
 @see indexPathForItem:
 */
- (SSCollectionViewItem *)itemPathForIndex:(NSIndexPath *)indexPath;

/**
 Returns an index path representing the row (index) and section of a given collection view item.
 
 @param item An item object of the collection view.
 
 @return An index path representing the row and section of the cell or nil if the index path is invalid.
 
 @see itemPathForIndex:
 */
- (NSIndexPath *)indexPathForItem:(SSCollectionViewItem *)item;

/**
 Selects an item in the receiver identified by index path, optionally scrolling the item to a location in the receiver.
 
 @param indexPath An index path identifying an item in the receiver.
 
 @param animated `YES` if you want to animate the selection and any change in position, `NO` if
 the change should be immediate.
 
 @param scrollPosition A constant that identifies a relative position in the receiving collection view (top, middle,
 bottom) for the row when scrolling concludes.
 
 Calling this method does cause the delegate to receive a `collectionView:willSelectRowAtIndexPath:` and
 `collectionView:didSelectRowAtIndexPath:` message, which differs from `UITableView`.
 */
- (void)selectItemAtIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated scrollPosition:(SSCollectionViewScrollPosition)scrollPosition;

/**
 Deselects a given item identified by index path, with an option to animate the deselection.
 
 @param indexPath An index path identifying an item in the receiver.
 
 @param animated `YES` if you want to animate the deselection and `NO` if the change should be
 immediate.
 */
- (void)deselectItemAtIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated;

/**
 Scrolls the receiver until an item identified by index path is at a particular location on the screen.
 
 @param indexPath An index path that identifies an item in the table view by its row index and its section index.
 
 @param scrollPosition A constant that identifies a relative position in the receiving collection view (top, middle,
 bottom) for row when scrolling concludes.
 
 @param animated `YES` if you want to animate the change in position, `NO` if it should be
 immediate.
 */
- (void)scrollToItemAtIndexPath:(NSIndexPath *)indexPath atScrollPosition:(SSCollectionViewScrollPosition)scrollPosition animated:(BOOL)animated;

/**
 Reloads the specified item.
 
 @param indexPaths An index path that identifies an item in the collection view by its row index and its section index.
 */
- (void)reloadItemsAtIndexPaths:(NSArray *)indexPaths;

/**
 Returns the number of item (collection view items) in a specified section.
 
 @param section An index number that identifies a section of the collection.
 
 @return The number of items in the section.
 */
- (NSUInteger)numberOfItemsInSection:(NSUInteger)section;

/**
 Returns the drawing area for a specified section of the receiver.
 
 @param section An index number identifying a section of the collection view.
 
 @return A rectangle defining the area in which the collection view draws the section.
 */
- (CGRect)rectForSection:(NSUInteger)section;

/** Returns the drawing area for the header of the specified section.
 
 @param section An index number identifying a section of the collection view.
 
 @return A rectangle defining the area in which the collection view draws the section header.
 */
- (CGRect)rectForHeaderInSection:(NSUInteger)section;

/**
 Returns the drawing area for the footer of the specified section.
 
 @param section An index number identifying a section of the collection view.
 
 @return A rectangle defining the area in which the collection view draws the section footer.
 */
- (CGRect)rectForFooterInSection:(NSUInteger)section;

@end


@protocol SSCollectionViewDataSource <NSObject>

@required

- (NSUInteger)collectionView:(SSCollectionView *)aCollectionView numberOfItemsInSection:(NSUInteger)section;
- (SSCollectionViewItem *)collectionView:(SSCollectionView *)aCollectionView itemForIndexPath:(NSIndexPath *)indexPath;

@optional

- (NSUInteger)numberOfSectionsInCollectionView:(SSCollectionView *)aCollectionView;

@end


@protocol SSCollectionViewDelegate <NSObject, UIScrollViewDelegate>

@required

- (CGSize)collectionView:(SSCollectionView *)aCollectionView itemSizeForSection:(NSUInteger)section;

@optional

- (UIView *)collectionView:(SSCollectionView *)aCollectionView viewForHeaderInSection:(NSUInteger)section;
- (CGFloat)collectionView:(SSCollectionView *)aCollectionView heightForHeaderInSection:(NSUInteger)section;
- (UIView *)collectionView:(SSCollectionView *)aCollectionView viewForFooterInSection:(NSUInteger)section;
- (CGFloat)collectionView:(SSCollectionView *)aCollectionView heightForFooterInSection:(NSUInteger)section;
- (void)collectionView:(SSCollectionView *)aCollectionView willSelectItemAtIndexPath:(NSIndexPath *)indexPath;
- (void)collectionView:(SSCollectionView *)aCollectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
- (void)collectionView:(SSCollectionView *)aCollectionView willDeselectItemAtIndexPath:(NSIndexPath *)indexPath;
- (void)collectionView:(SSCollectionView *)aCollectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath;
- (void)collectionView:(SSCollectionView *)aCollectionView willDisplayItem:(SSCollectionViewItem *)item atIndexPath:(NSIndexPath *)indexPath;

@end
