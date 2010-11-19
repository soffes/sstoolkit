//
//  SSSwitch.h
//  SSToolkit
//
//  Created by Sam Soffes on 11/19/10.
//  Copyright 2010 Sam Soffes. All rights reserved.
//

typedef enum {
	SSSwitchStyleDefault,
	SSSwitchStyleAirplane
} SSSwitchStyle;

typedef enum {
	SSSwitchLabelStyleDefault,		// Uses text in English and view for all others
	SSSwitchLabelStyleAlwaysText,	// Always use text
	SSSwitchLabelStyleAlwaysView,	// Always use views
} SSSwitchLabelStyle;

@interface SSSwitch : UIControl {
	
	BOOL _on;
	SSSwitchStyle _style;
	UIButton *_handle;
	CGFloat _handleWidth;
	NSInteger _handleLeftCapWidth;
	CGFloat _handleShadowWidth;
	UIImageView *_onBackgroundImageView;
	UILabel *_onLabel;
	UIView *_onView;
	UIImageView *_offBackgroundImageView;
	UILabel *_offLabel;
	UIView *_offView;
	UIEdgeInsets _trackEdgeInsets;
	SSSwitchLabelStyle _switchLabelStyle;
	
@private
	
	UIView *_labelMaskView;
	BOOL _dragging;
	CGFloat _dragOffset;
	NSInteger _hitCount;
}

@property (nonatomic, assign, getter=isOn) BOOL on;
@property (nonatomic, assign) SSSwitchStyle style;
@property (nonatomic, retain) UIButton *handle;
@property (nonatomic, assign) CGFloat handleWidth;
@property (nonatomic, assign) NSInteger handleLeftCapWidth;
@property (nonatomic, assign) CGFloat handleShadowWidth;
@property (nonatomic, retain) UIImageView *onBackgroundImageView;
@property (nonatomic, retain) UILabel *onLabel;
@property (nonatomic, retain) UIView *onView;
@property (nonatomic, retain) UIImageView *offBackgroundImageView;
@property (nonatomic, retain) UILabel *offLabel;
@property (nonatomic, retain) UIView *offView;
@property (nonatomic, assign) UIEdgeInsets trackEdgeInsets;
@property (nonatomic, assign) SSSwitchLabelStyle switchLabelStyle;

- (void)setOn:(BOOL)on animated:(BOOL)animated;
- (void)toggle;
- (void)toggleAnimated:(BOOL)animated;

@end
