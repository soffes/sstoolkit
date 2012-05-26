//
//  SSCollectionViewItem.h
//  SSToolkit
//
//  Created by Sam Soffes on 6/11/10.
//  Copyright 2010-2011 Sam Soffes. All rights reserved.
//

/**
 An enumeration for the various styles of items.
 */
typedef enum {
	SSCollectionViewItemStyleDefault = UITableViewCellStyleDefault,
	SSCollectionViewItemStyleSubtitle = UITableViewCellStyleSubtitle,
	SSCollectionViewItemStyleBlank,
	SSCollectionViewItemStyleImage
} SSCollectionViewItemStyle;

@class SSLabel;
@class SSCollectionView;

/**
 View for display in a collection view.
 */
@interface SSCollectionViewItem : UIView

/**
 Returns the image view of the collection view item. (read-only)
 
 Returns the image view (`UIImageView` object) of the collection view item, which initially has no image set.
 `SSCollectionViewItem` creates the image view object when you create the item.
 */
@property (nonatomic, strong) UIImageView *imageView;

/**
 Returns the label used for the main textual content of the table cell. (read-only)
 
 Holds the main label of the item. `SSCollectionViewItem` adds an appropriate label when you create the cell in a given
 item style.
 */
@property (nonatomic, strong) SSLabel *textLabel;

/**
 Returns the secondary label of the collection view item. (read-only)
 
 Holds the secondary label of the item. `SSCollectionViewItem` adds an appropriate label when you create the cell in a
 given item style.
 */
@property (nonatomic, strong) SSLabel *detailTextLabel;

/** The view used as the background of the item.
 
 The default is `nil`. `SSCollectionViewItem` adds the background view as a subview behind all other views and uses its
 current frame location.
 */
@property (nonatomic, strong) UIView *backgroundView;

/**
 The view used as the background of the item when it is selected.
 
 The default is `nil`. `SSCollectionViewItem` adds the value of this property as a subview only when the cell is
 selected. It adds the selected background view as a subview directly above the background view (`backgroundView`) if it
 is not `nil`, or behind all other views. Calling `setSelected:animated:` causes the `selectedBackground` view to
 animate in and out with an alpha fade.
 */
@property (nonatomic, strong) UIView *selectedBackgroundView;

/**
 A string used to identify an item that is reusable. (read-only)
 
 The reuse identifier is associated with a `SSCollectionViewItem` object that the collection view's delegate creates
 with the intent to reuse it as the basis (for performance reasons) for multiple items of a collection view. It is
 assigned to the item object in `initWithFrame:reuseIdentifier:` and cannot be changed thereafter. A `SSCollectionView`
 object maintains a queue (or list) of the currently reusable items, each with its own reuse identifier, and makes them
 available to the delegate in the `dequeueReusableCellWithIdentifier:` method.
 */
@property (nonatomic, readonly, copy) NSString *reuseIdentifier;

/**
 A Boolean value that indicates whether the cell is selected.
 
 The selection affects the appearance of labels, image, and background. The default value is `NO`.
 
 @see setSelected:animated:
*/
@property (nonatomic, getter=isSelected) BOOL selected;

/**
 A Boolean value that indicates whether the item is highlighted.
 
 The highlighting affects the appearance of labels, image, and background. When the the highlighted state of an item is
 set to `YES`, labels are drawn in their highlighted text color. The default value is `NO`. If you set the highlighted
 state to `YES` through this property, the transition to the new state appearance is not animated. For animated
 highlighted-state transitions, see the `setHighlighted:animated:` method.
 
 Note that for highlighting to work properly, you must fetch the items's labels using the textLabel and
 `detailTextLabel` properties and set each label's `highlightedTextColor` property; for images, get the item's image
 using the `imageView` property and set the `UIImageView` object's `highlightedImage` property.
 
  @see setHighlighted:animated:
 */
@property (nonatomic, getter=isHighlighted) BOOL highlighted;

/**
 Initializes a collection view item with a style and a reuse identifier and returns it to the caller.
 
 @param style A constant indicating a item style.
 
 @param aReuseIdentifier A string used to identify the item object if it is to be reused for drawing multiple items of a
 collection view. Pass `nil` if the cell object is not to be reused. You should use the same reuse identifier for all
 cells of the same form.
 
 @return An initialized `SSCollectionViewItem` object or nil if the object could not be created.
 */
- (id)initWithStyle:(SSCollectionViewItemStyle)style reuseIdentifier:(NSString *)aReuseIdentifier;

/**
 Prepares a reusable item for reuse by the table view's delegate.
 */
- (void)prepareForReuse;

/**
 Sets the selected state of the item, optionally animating the transition between states.
 
 The selection affects the appearance of labels, image, and background. When the the selected state of a cell to `YES`,
 it draws the background for selected items with its title in its `highlightedTextColor`.
 
 @param selected `YES` to set the item as selected, `NO` to set it as unselected. The default is `NO`.
 
 @param animated `YES` to animate the transition between selected states, `NO` to make the transition immediate.
 */
- (void)setSelected:(BOOL)selected animated:(BOOL)animated;

/**
 Sets the highlighted state of the item, optionally animating the transition between states.
 
 Highlights or unhighlights the item, animating the transition between regular and highlighted state if animated is
 `YES`. Highlighting affects the appearance of the items's labels, image, and background.
 
 Note that for highlighting to work properly, you must fetch the item's label (or labels) using the `textLabel`
 (and `detailTextLabel`) properties and set the label's `highlightedTextColor` property; for images, get the items's
 image using the `imageView` property and set the `UIImageView` object's `highlightedImage` property.
 
 A custom table item may override this method to make any transitory appearance changes.
 
 @param highlighted `YES` to set the item as highlighted, `NO` to set it as
 unhighlighted. The default is `NO`.
 
 @param animated `YES` to animate the transition between highlighted states, `NO`
 to make the transition immediate.
 */
- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated;

@end
