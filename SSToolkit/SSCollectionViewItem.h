//
//  SSCollectionViewItem.h
//  SSToolkit
//
//  Created by Sam Soffes on 6/11/10.
//  Copyright 2010-2011 Sam Soffes. All rights reserved.
//

typedef enum {
	SSCollectionViewItemStyleDefault = UITableViewCellStyleDefault,
	SSCollectionViewItemStyleSubtitle = UITableViewCellStyleSubtitle,
	SSCollectionViewItemStyleBlank,
	SSCollectionViewItemStyleImage
} SSCollectionViewItemStyle;

@class SSLabel;
@class SSCollectionView;

/**
 @brief View for display in a collection view.
 */
@interface SSCollectionViewItem : UIView {
	
@private
	
	SSCollectionViewItemStyle _style;
	
	NSString *_reuseIdentifier;
	UIImageView *_imageView;
	SSLabel *_textLabel;
	SSLabel *_detailTextLabel;
	UIView *_backgroundView;
	UIView *_selectedBackgroundView;

	BOOL _selected;
	BOOL _highlighted;
	
	SSCollectionView *_collectionView;
}

/**
 @brief Returns the image view of the collection view item. (read-only)
 
 Returns the image view (UIImageView object) of the collection view item, which initially has no
 image set. SSCollectionViewItem creates the image view object when you create the item.
 */
@property (nonatomic, retain) UIImageView *imageView;

/**
 @brief Returns the label used for the main textual content of the table cell. (read-only)
 
 Holds the main label of the item. SSCollectionViewItem adds an appropriate label when you create
 the cell in a given item style.
 */
@property (nonatomic, retain) SSLabel *textLabel;

/**
 @brief Returns the secondary label of the collection view item. (read-only)
 
 Holds the secondary label of the item. SSCollectionViewItem adds an appropriate label when you
 create the cell in a given item style.
 */
@property (nonatomic, retain) SSLabel *detailTextLabel;

/**
 @brief The view used as the background of the item.
 
 The default is nil. SSCollectionViewItem adds the background view as a subview behind all other views
 and uses its current frame location.
 */
@property (nonatomic, retain) UIView *backgroundView;

/**
 @brief The view used as the background of the item when it is selected.
 
 The default is nil. SSCollectionViewItem adds the value of this property as a subview only when the
 cell is selected. It adds the selected background view as a subview directly above the background
 view (backgroundView) if it is not nil, or behind all other views. Calling setSelected:animated:
 causes the selected background view to animate in and out with an alpha fade.
 */
@property (nonatomic, retain) UIView *selectedBackgroundView;

/**
 @brief A string used to identify an item that is reusable. (read-only)
 
 The reuse identifier is associated with a SSCollectionViewItem object that the collection view's
 delegate creates with the intent to reuse it as the basis (for performance reasons) for multiple
 items of a collection view. It is assigned to the item object in initWithFrame:reuseIdentifier:
 and cannot be changed thereafter. A SSCollectionView object maintains a queue (or list) of the
 currently reusable items, each with its own reuse identifier, and makes them available to the
 delegate in the dequeueReusableCellWithIdentifier: method.
 */
@property (nonatomic, readonly, copy) NSString *reuseIdentifier;

/**
 @brief A Boolean value that indicates whether the cell is selected.
 
 The selection affects the appearance of labels, image, and background. The default value is
 <code>NO</code>.
 
 @see setSelected:animated:
*/
@property (nonatomic, getter=isSelected) BOOL selected;

/**
 @brief A Boolean value that indicates whether the item is highlighted.
 
 The highlighting affects the appearance of labels, image, and background. When the the highlighted
 state of an item is set to <code>YES</code>, labels are drawn in their highlighted text color. The
 default value is <code>NO</code>. If you set the highlighted state to <code>YES</code> through this
 property, the transition to the new state appearance is not animated. For animated highlighted-state
 transitions, see the setHighlighted:animated: method.
 
 Note that for highlighting to work properly, you must fetch the items's labels using the textLabel
 and detailTextLabel properties and set each label's highlightedTextColor property; for images, get
 the item's image using the imageView property and set the UIImageView object's highlightedImage
 property.
 
  @see setHighlighted:animated:
 */
@property (nonatomic, getter=isHighlighted) BOOL highlighted;

/**
 @brief Initializes a collection view item with a style and a reuse identifier and returns it to
 the caller.
 
 @param style A constant indicating a item style.
 
 @param reuseIdentifier A string used to identify the item object if it is to be reused for drawing
 multiple items of a collection view. Pass nil if the cell object is not to be reused. You should
 use the same reuse identifier for all cells of the same form.
 
 @return An initialized SSCollectionViewItem object or nil if the object could not be created.
 */
- (id)initWithStyle:(SSCollectionViewItemStyle)style reuseIdentifier:(NSString *)aReuseIdentifier;

/**
 @brief Prepares a reusable item for reuse by the table view's delegate.
 */
- (void)prepareForReuse;

/**
 @brief Sets the selected state of the item, optionally animating the transition between states.
 
 @param selected <code>YES</code> to set the item as selected, <code>NO</code> to set it as unselected.
 The default is <code>NO</code>.
 
 @param animated <code>YES</code> to animate the transition between selected states, <code>NO</code> to
 make the transition immediate.
 
 The selection affects the appearance of labels, image, and background. When the the selected state
 of a cell to <code>YES</code>, it draws the background for selected items with its title in its
 highlightedTextColor.
 */
- (void)setSelected:(BOOL)selected animated:(BOOL)animated;

/**
 @brief Sets the highlighted state of the item, optionally animating the transition between states.
 
 @param highlighted <code>YES</code> to set the item as highlighted, <code>NO</code> to set it as
 unhighlighted. The default is <code>NO</code>.
 
 @param animated <code>YES</code> to animate the transition between highlighted states, <code>NO</code>
 to make the transition immediate.

 Highlights or unhighlights the item, animating the transition between regular and highlighted state if
 animated is <code>YES</code>. Highlighting affects the appearance of the items's labels, image, and
 background.
 
 Note that for highlighting to work properly, you must fetch the item's label (or labels) using the
 textLabel (and detailTextLabel) properties and set the label's highlightedTextColor property; for
 images, get the items's image using the imageView property and set the UIImageView object's
 highlightedImage property.
 
 A custom table item may override this method to make any transitory appearance changes.
 */
- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated;

@end
