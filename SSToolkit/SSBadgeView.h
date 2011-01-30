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

@property (nonatomic, copy) NSString *text;
@property (nonatomic, retain) UIColor *textColor;
@property (nonatomic, retain) UIColor *highlightedTextColor;
@property (nonatomic, retain) UIFont *font;
@property (nonatomic, retain) UIColor *badgeColor;
@property (nonatomic, retain) UIColor *highlightedBadgeColor;
@property (nonatomic, assign) CGFloat cornerRadius;
@property (nonatomic, assign) SSBadgeViewAlignment badgeAlignment;
@property (nonatomic, assign, getter=isHighlighted) BOOL highlighted;

@end
