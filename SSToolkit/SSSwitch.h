//
//  SSSwitch.h
//  SSToolkit
//
//  Created by Sam Soffes on 11/19/10.
//  Copyright 2010-2011 Sam Soffes. All rights reserved.
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

@interface SSSwitch : UIControl

@property (nonatomic, assign, getter=isOn) BOOL on;
@property (nonatomic, assign) SSSwitchStyle style;
@property (nonatomic, retain, readonly) UIButton *handle;
@property (nonatomic, retain) UIImage *leftHandleImage;
@property (nonatomic, retain) UIImage *leftHandleImageHighlighted;
@property (nonatomic, retain) UIImage *centerHandleImage;
@property (nonatomic, retain) UIImage *centerHandleImageHighlighted;
@property (nonatomic, retain) UIImage *rightHandleImage;
@property (nonatomic, retain) UIImage *rightHandleImageHighlighted;
@property (nonatomic, assign) CGFloat handleWidth;
@property (nonatomic, assign) CGFloat handleShadowWidth;
@property (nonatomic, retain, readonly) UIImageView *onBackgroundImageView;
@property (nonatomic, retain, readonly) UILabel *onLabel;
@property (nonatomic, retain, readonly) UIView *onView;
@property (nonatomic, retain, readonly) UIImageView *offBackgroundImageView;
@property (nonatomic, retain, readonly) UILabel *offLabel;
@property (nonatomic, retain, readonly) UIView *offView;
@property (nonatomic, assign) UIEdgeInsets trackEdgeInsets;
@property (nonatomic, assign) SSSwitchLabelStyle switchLabelStyle;

- (void)setOn:(BOOL)on animated:(BOOL)animated;
- (void)toggle;
- (void)toggleAnimated:(BOOL)animated;

@end
