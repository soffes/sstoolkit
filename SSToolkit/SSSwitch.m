//
//  SSSwitch.m
//  SSToolkit
//
//  Created by Sam Soffes on 11/19/10.
//  Copyright 2010 Sam Soffes. All rights reserved.
//

#import "SSSwitch.h"
#import "UIImage+SSToolkitAdditions.h"

@interface SSSwitch (PrivateMethods)
- (void)_layoutSubviewsWithHandlePosition:(CGFloat)x;
- (void)_handleReleased:(id)sender;
- (void)_handleDragged:(id)sender event:(UIEvent *)event;
- (void)_handleDraggingEnded:(id)sender;
@end

@implementation SSSwitch

@synthesize on = _on;
@synthesize style = _style;
@synthesize handle = _handle;
@synthesize leftHandleImage = _leftHandleImage;
@synthesize leftHandleImageHighlighted = _leftHandleImageHighlighted;
@synthesize centerHandleImage = _centerHandleImage;
@synthesize centerHandleImageHighlighted = _centerHandleImageHighlighted;
@synthesize rightHandleImage = _rightHandleImage;
@synthesize rightHandleImageHighlighted = _rightHandleImageHighlighted;
@synthesize handleWidth = _handleWidth;
@synthesize handleLeftCapWidth = _handleLeftCapWidth;
@synthesize handleShadowWidth = _handleShadowWidth;
@synthesize onBackgroundImageView = _onBackgroundImageView;
@synthesize onLabel = _onLabel;
@synthesize onView = _onView;
@synthesize offBackgroundImageView = _offBackgroundImageView;
@synthesize offLabel = _offLabel;
@synthesize offView = _offView;
@synthesize trackEdgeInsets = _trackEdgeInsets;
@synthesize switchLabelStyle = _switchLabelStyle;

#pragma mark NSObject

- (void)dealloc {
	self.handle = nil;
	self.leftHandleImage = nil;
	self.leftHandleImageHighlighted = nil;
	self.centerHandleImage = nil;
	self.centerHandleImageHighlighted = nil;
	self.rightHandleImage = nil;
	self.rightHandleImageHighlighted = nil;
	self.onBackgroundImageView = nil;
	self.onLabel = nil;
	self.onView = nil;
	self.onBackgroundImageView = nil;
	self.offLabel = nil;	
	self.offView = nil;
	[_labelMaskView release];
	[super dealloc];
}


#pragma mark UIView

- (id)initWithFrame:(CGRect)frame {
	if ((self = [super initWithFrame:frame])) {
		self.backgroundColor = [UIColor clearColor];
		self.clipsToBounds = YES;
		self.autoresizesSubviews = NO; // TODO: Possibly remove
		
		// On background
		_onBackgroundImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
		_onBackgroundImageView.autoresizesSubviews = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		_onBackgroundImageView.clipsToBounds = YES;
		[self addSubview:_onBackgroundImageView];
		
		// Off background
		_offBackgroundImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
		_offBackgroundImageView.autoresizesSubviews = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		_offBackgroundImageView.clipsToBounds = YES;
		[self addSubview:_offBackgroundImageView];
		
		// Label mask
		_labelMaskView = [[UIView alloc] initWithFrame:CGRectZero];
		_labelMaskView.backgroundColor = [UIColor clearColor];
		_labelMaskView.autoresizesSubviews = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		_labelMaskView.clipsToBounds = YES;
		[self addSubview:_labelMaskView];
		
		// On label
		_onLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		_onLabel.backgroundColor = [UIColor clearColor];
		_onLabel.text = @"ON";
		_onLabel.textAlignment = UITextAlignmentCenter;
		[_labelMaskView addSubview:_onLabel];
		
		// Off label
		_offLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		_offLabel.backgroundColor = [UIColor clearColor];
		_offLabel.text = @"OFF";
		_offLabel.textAlignment = UITextAlignmentCenter;
		[_labelMaskView addSubview:_offLabel];
		
		// Handle
		_handle = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
		[_handle addTarget:self action:@selector(_handleReleased:) forControlEvents:UIControlEventTouchUpInside];
		[_handle addTarget:self action:@selector(_handleDragged:event:) forControlEvents:UIControlEventTouchDragInside];
		[_handle addTarget:self action:@selector(_handleDraggingEnded:) forControlEvents:UIControlEventTouchUpOutside];
		[self addSubview:_handle];
		
		// Defaults
		_dragging = NO;
		_hitCount = 0;
		_switchLabelStyle = SSSwitchLabelStyleDefault;
		_on = NO;
		self.style = SSSwitchStyleDefault;
	}
	return self;
}


- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
	// Forward all touches to the handle
	return [super hitTest:point withEvent:event] ? _handle : nil;
}


#pragma mark Switch

- (void)setOn:(BOOL)on {
	[self setOn:on animated:NO];
}


- (void)setOn:(BOOL)on animated:(BOOL)animated {
	_on = on;
	// TODO: UIControl stuff
	
	if (animated) {
		[UIView beginAnimations:[NSString stringWithFormat:@"SSSwitchAnimate%@", (_on ? @"On" : @"Off")] context:nil];
		[UIView setAnimationDuration:0.2];
		[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
	}
	
	[self _layoutSubviewsWithHandlePosition:(_on ? self.frame.size.width - _handleWidth : 0.0)];
	
	if (animated) {
		[UIView commitAnimations];
	}
	
	[self sendActionsForControlEvents:UIControlEventValueChanged];
}


- (void)toggle {
	[self toggleAnimated:YES];
}


- (void)toggleAnimated:(BOOL)animated {
	[self setOn:!_on animated:animated];
}


#pragma mark Private Methods

- (void)_layoutSubviewsWithHandlePosition:(CGFloat)x {	
	CGFloat width = self.frame.size.width;
	CGFloat height = self.frame.size.height;
	CGFloat sideWidth = width - _handleWidth;
	CGFloat labelWidth = sideWidth - _trackEdgeInsets.left - _trackEdgeInsets.right;
	CGFloat labelHeight = height - _trackEdgeInsets.top - _trackEdgeInsets.bottom;
	NSUInteger position = 1;
	
	_labelMaskView.frame = UIEdgeInsetsInsetRect(CGRectMake(0.0, 0.0, width, height), _trackEdgeInsets);
	
	// Enforce limits
	x = fmin(fmax(0.0, x), sideWidth);
	
	// Calculate shadow width
	if (_handleShadowWidth > 0.0) {
		position = x == 0 ? 0 : (x == sideWidth ? 2 : 1); // 0: left, 1: center, 2: right
		
		if (position == 0) {
			[_handle setBackgroundImage:_leftHandleImage forState:UIControlStateNormal];
			[_handle setBackgroundImage:_leftHandleImageHighlighted forState:UIControlStateHighlighted];
		} else if (position == 1) {
			[_handle setBackgroundImage:_centerHandleImage forState:UIControlStateNormal];
			[_handle setBackgroundImage:_centerHandleImageHighlighted forState:UIControlStateHighlighted];
		} else {
			[_handle setBackgroundImage:_rightHandleImage forState:UIControlStateNormal];
			[_handle setBackgroundImage:_rightHandleImageHighlighted forState:UIControlStateHighlighted];			
		}
	} else {
		[_handle setBackgroundImage:_centerHandleImage forState:UIControlStateNormal];
		[_handle setBackgroundImage:_centerHandleImageHighlighted forState:UIControlStateHighlighted];
	}
	
	_handle.frame = UIEdgeInsetsInsetRect(CGRectMake(x - _handleShadowWidth, 0.0, _handleWidth + _handleShadowWidth + _handleShadowWidth, height), _trackEdgeInsets);
	_onBackgroundImageView.frame = CGRectMake(0.0, 0.0, width, height);
	_offBackgroundImageView.frame = CGRectMake(x + _trackEdgeInsets.left + (CGFloat)_handleLeftCapWidth, 0.0, width - x - _trackEdgeInsets.left - (CGFloat)_handleLeftCapWidth, height);
	
	// TODO: These are still a bit hacky (with the +2 and -1)
	_onLabel.frame = CGRectMake(x - labelWidth - _trackEdgeInsets.left + 2.0, 0.0, labelWidth, labelHeight);
	_offLabel.frame = CGRectMake(x + _handleWidth - _trackEdgeInsets.right - 1.0, 0.0, labelWidth, labelHeight);
}


- (void)_handleReleased:(id)sender {
	// Tapped
	if (_dragging == NO) {
		_hitCount++;
		[self toggle];
		return;
	}
	
	// Drag release
	_dragging = NO;
	if (_on) {
		[self setOn:(_handle.frame.origin.x >= self.frame.size.width - _handleWidth + _trackEdgeInsets.right) animated:YES];
	} else {
		[self setOn:(_handle.frame.origin.x > _trackEdgeInsets.right) animated:YES];
	}
}


- (void)_handleDragged:(id)sender event:(UIEvent *)event {
	UITouch *touch = [[event touchesForView:_handle] anyObject];
	
	if (_dragging == NO) {
		_dragOffset = [touch locationInView:_handle].x;
	}
	
	_dragging = YES;
	[self _layoutSubviewsWithHandlePosition:[touch locationInView:self].x - _dragOffset];
}


- (void)_handleDraggingEnded:(id)sender {
	_dragging = NO;
	[self _handleReleased:sender];
}


#pragma mark Setters

- (void)setStyle:(SSSwitchStyle)s {
	_style = s;
	
	// TODO: Always apply default style before changing style for more consistent results
	
	switch (_style) {
		case SSSwitchStyleDefault: {
			NSInteger leftCap = 8;
			
			self.leftHandleImage = [[UIImage imageNamed:@"images/UISwitchButtonRightShadowed.png" bundle:@"SSToolkit.bundle"] stretchableImageWithLeftCapWidth:leftCap topCapHeight:0];
			self.leftHandleImageHighlighted = [[UIImage imageNamed:@"images/UISwitchButtonRightShadowedDown.png" bundle:@"SSToolkit.bundle"] stretchableImageWithLeftCapWidth:leftCap topCapHeight:0];
			self.centerHandleImage = [[UIImage imageNamed:@"images/UISwitchButtonFullShadowed.png" bundle:@"SSToolkit.bundle"] stretchableImageWithLeftCapWidth:leftCap topCapHeight:0];
			self.centerHandleImageHighlighted = [[UIImage imageNamed:@"images/UISwitchButtonFullShadowedDown.png" bundle:@"SSToolkit.bundle"] stretchableImageWithLeftCapWidth:leftCap topCapHeight:0];
			self.rightHandleImage = [[UIImage imageNamed:@"images/UISwitchButtonLeftShadowed.png" bundle:@"SSToolkit.bundle"] stretchableImageWithLeftCapWidth:leftCap topCapHeight:0];
			self.rightHandleImageHighlighted = [[UIImage imageNamed:@"images/UISwitchButtonLeftShadowedDown.png" bundle:@"SSToolkit.bundle"] stretchableImageWithLeftCapWidth:leftCap topCapHeight:0];
			
			self.handleWidth = 42;
			self.handleLeftCapWidth = leftCap;
			self.handleShadowWidth = 2;
			
			self.onBackgroundImageView.image = [[UIImage imageNamed:@"images/UISwitchTrackBlue.png" bundle:@"SSToolkit.bundle"] stretchableImageWithLeftCapWidth:5 topCapHeight:0];

			self.onLabel.textColor = [UIColor whiteColor];
			self.onLabel.font = [UIFont boldSystemFontOfSize:16.0];
			self.onLabel.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
			self.onLabel.shadowOffset = CGSizeMake(0.0, -1.0);
			
			self.offBackgroundImageView.image = [[UIImage imageNamed:@"images/UISwitchTrackClear.png" bundle:@"SSToolkit.bundle"] stretchableImageWithLeftCapWidth:5 topCapHeight:0];
			
			self.offLabel.textColor = [UIColor colorWithWhite:0.475 alpha:1.0];
			self.offLabel.font = [UIFont boldSystemFontOfSize:16.0];
			self.offLabel.shadowColor = nil;			
			
			self.trackEdgeInsets = UIEdgeInsetsZero;

			break;
		}
			
		case SSSwitchStyleAirplane: {
			self.onBackgroundImageView.image = [[UIImage imageNamed:@"images/UISwitchTrackOrange.png" bundle:@"SSToolkit.bundle"] stretchableImageWithLeftCapWidth:5 topCapHeight:0];
			break;
		}
	}
	
	[self _layoutSubviewsWithHandlePosition:_on ? 1.0 : 0.0];
}

@end
