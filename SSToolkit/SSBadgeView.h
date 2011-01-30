//
//  SSBadgeView.h
//  SSToolkit
//
//  Created by Sam Soffes on 1/29/11.
//  Copyright 2011 Sam Soffes. All rights reserved.
//

typedef enum {
	SSBadgeViewAlignmentLeft = UITextAlignmentLeft,
	SSBadgeViewAlignmentCenter = UITextAlignmentCenter,
	SSBadgeViewAlignmentRight = UITextAlignmentRight
} SSBadgeViewAlignment;

/**
 @brief Badge view.
 
 Provides the accesory view for a SSBadgeTableViewCell, available through the 
 badgeView property of the same.
 
 Acts very much like the badges in Mail.app, with the key difference being that 
 Apple uses images and SSBadgeView is rendered with CoreGraphics for improved 
 scrolling performance.
 
 Not limited to numbers, strings should still be short enough to fit within the 
 accesoryView bounds. 
 
 */

@interface SSBadgeView : UIView {

	NSString *_text;
	UIColor *_textColor;
	UIColor *_highlightedTextColor;
	UIFont *_font;
	UIColor *_badgeColor;
	UIColor *_highlightedBadgeColor;
	CGFloat _cornerRadius;
	SSBadgeViewAlignment _badgeAlignment;
	BOOL _highlighted;
	
@protected
	
	BOOL _hasDrawn;
}

/**
 @brief Display value.

 Default is 0.
 */
@property (nonatomic, copy) NSString *text;

/**
 @brief The color of the badge display value.
 
 Default is white.
 */
@property (nonatomic, retain) UIColor *textColor;

/**
 @brief The color of the badge display value while its cell is highlighted.
 
 Default is blue (matches UITableViewCell's default highlight background color).
 */
@property (nonatomic, retain) UIColor *highlightedTextColor;

/**
 @brief Read-only value for cell's highlighted status.
 */
@property (nonatomic, retain) UIFont *font;

/**
 @brief The badge's background color.
 
 Default is grayish blue.
 */
@property (nonatomic, retain) UIColor *badgeColor;

/**
 @brief The badge's background color while its cell is highlighted.
 
 Default is white.
 */
@property (nonatomic, retain) UIColor *highlightedBadgeColor;

/**
 @brief The corner radius used when rendering the badge's outline.
 
 Default is 10.
 */
@property (nonatomic, assign) CGFloat cornerRadius;

/**
 @brief The badge's horizontal alignment within the accesoryView frame.
 
 Default is <code>SSBadgeViewAlignmentRight</code>.
 */
@property (nonatomic, assign) SSBadgeViewAlignment badgeAlignment;

/**
 @brief Parent cell's highlighted status. (read-only)
 */
@property (nonatomic, assign, getter=isHighlighted) BOOL highlighted;

@end
