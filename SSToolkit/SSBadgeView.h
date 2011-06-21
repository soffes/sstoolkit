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

@class SSLabel;

/**
 @brief Badge view.
 
 Provides the accesory view for a SSBadgeTableViewCell, available through the <code>badgeView</code> property.
 
 Acts very much like the badges in Mail.app, with the key difference being that Apple uses images and SSBadgeView is
 rendered with CoreGraphics for improved scrolling performance (although images are supported). This also allows for
 more flexible resizing. 
 
 Not limited to numbers, strings should still be short enough to fit within the accesoryView bounds.
 */
@interface SSBadgeView : UIView {

@private
	
	SSLabel *_textLabel;
	UIColor *_badgeColor;
	UIColor *_highlightedBadgeColor;
	UIImage *_badgeImage;
	UIImage *_highlightedBadgeImage;
	CGFloat _cornerRadius;
	SSBadgeViewAlignment _badgeAlignment;
	BOOL _highlighted;
}

/**
 @brief The badge text label.
 */
@property (nonatomic, retain, readonly) SSLabel *textLabel;

/**
 @brief The badge's background color.
 
 The default value of this property is grayish blue (that matches Mail.app).
 
 @see defaultBadgeColor
 */
@property (nonatomic, retain) UIColor *badgeColor;

/**
 @brief The badge's background color while its cell is highlighted.
 
 The default value of this property is white.
 */
@property (nonatomic, retain) UIColor *highlightedBadgeColor;

/**
 @brief The badge's background image.
 
 The default value of this property is <code>nil</code>. If the value is non-nil, it will be draw instead of the color.
 
 Setting a strechable image for this property is recommended.
 */
@property (nonatomic, retain) UIImage *badgeImage;

/**
 @brief The badge's background image while its cell is highlighted.
 
 The default value of this property is <code>nil</code>. If the value is non-nil, it will be draw instead of the color.
 
 Setting a strechable image for this property is recommended.
 */
@property (nonatomic, retain) UIImage *highlightedBadgeImage;

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
