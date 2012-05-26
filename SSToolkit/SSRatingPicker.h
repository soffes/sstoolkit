//
//  SSRatingPicker.h
//  SSToolkit
//
//  Created by Sam Soffes on 2/2/11.
//  Copyright 2011 Sam Soffes. All rights reserved.
//

/**
 A simple control for picking a rating.
 
 The default configuration matches the rating picker in the App Store app (to the pixel). The `textLabel` is
 automatically faded in if there is no rating and faded out when there is a rating.
 
 To receive changes when the `selectedNumberOfStars` changes, add a target for the `UIControlEventValueChanged` control
 event (similar to `UISegmentedControl`).
 */
@interface SSRatingPicker : UIControl


///------------------------------------
/// @name Accessing the Star Attributes
///------------------------------------

/**
 The float value of the selected number of stars. Setting this value will send `UIControlEventValueChanged` to the
 pickers targets.
 
 The default is `0.0`.
 */
@property (nonatomic, assign) CGFloat selectedNumberOfStars;

/**
 The unsigned integer value of the total number of stars.
 
 The default is `5`.
 */
@property (nonatomic, assign) NSUInteger totalNumberOfStars;

///------------------------------------
/// @name Accessing the Star Attributes
///------------------------------------

/**
 The image draw for a star that is empty.
 */
@property (nonatomic, strong) UIImage *emptyStarImage;

/**
 The image draw for a star that is filled.
 */
@property (nonatomic, strong) UIImage *filledStarImage;

/**
 The spacing of stars.
 
 The default is `{21.0, 36.0}`.
 */
@property (nonatomic, assign) CGSize starSize;

/**
 The spacing of stars.
 
 The default is `19.0`.
 */
@property (nonatomic, assign) CGFloat starSpacing;


///-------------------------------
/// @name Accessing the Text Label
///-------------------------------

/**
 The text label drawn under the stars when there is no rating selected. (read-only)
 */
@property (nonatomic, strong, readonly) UILabel *textLabel;

@end
