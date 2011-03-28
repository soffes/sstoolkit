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
 <code>badgeView</code> property.
 
 Acts very much like the badges in Mail.app, with the key difference being that 
 Apple uses images and SSBadgeView is rendered with CoreGraphics for improved 
 scrolling performance. This also allows for more flexible resizing. 
 
 Not limited to numbers, strings should still be short enough to fit within the 
 accesoryView bounds.
 */
@interface SSBadgeView : UIView {

@private
	
	NSString *_text;
	UIColor *_textColor;
	UIColor *_highlightedTextColor;
	UIFont *_font;
	UIColor *_badgeColor;
	UIColor *_highlightedBadgeColor;
	CGFloat _cornerRadius;
	SSBadgeViewAlignment _badgeAlignment;
	BOOL _highlighted;
}

/**
 @brief Display value.

 The default value of this property is "0". If this property is set to <code>nil</code> or an empty string, the receiver
 will automatically hide itself.
 */
@property (nonatomic, copy) NSString *text;

/**
 @brief The color of the badge display value.
 
 The default value of this property is white.
 */
@property (nonatomic, retain) UIColor *textColor;

/**
 @brief The color of the badge display value while its cell is highlighted.
 
 The default value of this property is dark blue (that UITableViewCell's default highlighted background color).
 */
@property (nonatomic, retain) UIColor *highlightedTextColor;

/**
 @brief The font of the text.
 
 The default value of this property is bold system font at size 16.
 */
@property (nonatomic, retain) UIFont *font;

/**
 @brief The badge's background color.
 
 The default value of this property is grayish blue (that matches Mail.app).
 */
@property (nonatomic, retain) UIColor *badgeColor;

/**
 @brief The badge's background color while its cell is highlighted.
 
 The default value of this property is white.
 */
@property (nonatomic, retain) UIColor *highlightedBadgeColor;

/**
 @brief The corner radius used when rendering the badge's outline.
 
 The default value of this property is 10.
 */
@property (nonatomic, assign) CGFloat cornerRadius;

/**
 @brief The badge's horizontal alignment within the accesoryView frame.
 
 This will position the badge in the view's bounds accordinly.
 
 The default value of this property is <code>SSBadgeViewAlignmentCenter</code>.
 */
@property (nonatomic, assign) SSBadgeViewAlignment badgeAlignment;

/**
 @brief A Boolean value indicating whether the receiver should be drawn with a highlight.
 
 Setting this property causes the receiver to redraw with the appropriate highlight state.
 
 The default value of this property is <code>NO</code>.
 */
@property (nonatomic, assign, getter=isHighlighted) BOOL highlighted;

/**
 @brief The default badge color.
 
 @return A color with its value set to the default badge color.
 */
+ (UIColor *)defaultBadgeColor;

@end
