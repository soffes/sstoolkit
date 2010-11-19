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

@interface SSSwitch : UIControl {
	
	UIButton *_handleView;
	UILabel *_onLabel;
	UILabel *_offLabel;
	UIImageView *_onBackgroundImageView;
	UIImageView *_offBackgroundImageView;
	CGFloat _handleWidth;
	UIEdgeInsets _trackEdgeInsets;
	SSSwitchStyle _style;
	
	UIView *_labelMaskView;
	BOOL _on;
	BOOL _dragging;
	CGFloat _dragOffset;
	NSInteger _hitCount;
}

@property (nonatomic, assign, getter=isOn) BOOL on;
@property (nonatomic, retain) UIButton *handleView;
@property (nonatomic, copy) UILabel *onLabel;
@property (nonatomic, copy) UILabel *offLabel;
@property (nonatomic, retain) UIImageView *onBackgroundImageView;
@property (nonatomic, retain) UIImageView *offBackgroundImageView;
@property (nonatomic, assign) CGFloat handleWidth;
@property (nonatomic, assign) UIEdgeInsets trackEdgeInsets;
@property (nonatomic, assign) SSSwitchStyle style;

- (void)setOn:(BOOL)on animated:(BOOL)animated;
- (void)toggle;
- (void)toggleAnimated:(BOOL)animated;

@end
