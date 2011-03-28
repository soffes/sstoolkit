//
//  SSSwitch.m
//  SSToolkit
//
//  Created by Sam Soffes on 11/19/10.
//  Copyright 2010-2011 Sam Soffes. All rights reserved.
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
	self.leftHandleImage = nil;
	self.leftHandleImageHighlighted = nil;
	self.centerHandleImage = nil;
	self.centerHandleImageHighlighted = nil;
	self.rightHandleImage = nil;
	self.rightHandleImageHighlighted = nil;
	[_handle release];
	[_onBackgroundImageView release];
	[_onLabel release];
	[_onView release];
	[_offBackgroundImageView release];
	[_offLabel release];
	[_offView release];
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


- (void)willMoveToSuperview:(UIView *)newSuperview {
	[super willMoveToSuperview:newSuperview];
	
	if (newSuperview) {
		[self addObserver:self forKeyPath:@"on" options:NSKeyValueObservingOptionNew context:nil];
		[self addObserver:self forKeyPath:@"style" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
		[self addObserver:self forKeyPath:@"leftHandleImage" options:NSKeyValueObservingOptionNew context:nil];
		[self addObserver:self forKeyPath:@"leftHandleImageHighlighted" options:NSKeyValueObservingOptionNew context:nil];
		[self addObserver:self forKeyPath:@"centerHandleImage" options:NSKeyValueObservingOptionNew context:nil];
		[self addObserver:self forKeyPath:@"centerHandleImageHighlighted" options:NSKeyValueObservingOptionNew context:nil];
		[self addObserver:self forKeyPath:@"rightHandleImage" options:NSKeyValueObservingOptionNew context:nil];
		[self addObserver:self forKeyPath:@"rightHandleImageHighlighted" options:NSKeyValueObservingOptionNew context:nil];
		[self addObserver:self forKeyPath:@"handleShadowWidth" options:NSKeyValueObservingOptionNew context:nil];
		[self addObserver:self forKeyPath:@"trackEdgeInsets" options:NSKeyValueObservingOptionNew context:nil];
		[self addObserver:self forKeyPath:@"switchLabelStyle" options:NSKeyValueObservingOptionNew context:nil];
	} else {
		[self removeObserver:self forKeyPath:@"on"];
		[self removeObserver:self forKeyPath:@"style"];
		[self removeObserver:self forKeyPath:@"leftHandleImage"];
		[self removeObserver:self forKeyPath:@"leftHandleImageHighlighted"];
		[self removeObserver:self forKeyPath:@"centerHandleImage"];
		[self removeObserver:self forKeyPath:@"centerHandleImageHighlighted"];
		[self removeObserver:self forKeyPath:@"rightHandleImage"];
		[self removeObserver:self forKeyPath:@"rightHandleImageHighlighted"];
		[self removeObserver:self forKeyPath:@"handleShadowWidth"];
		[self removeObserver:self forKeyPath:@"trackEdgeInsets"];
		[self removeObserver:self forKeyPath:@"switchLabelStyle"];
	}
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
		[UIView setAnimationDuration:0.2f];
		[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
	}
	
	[self _layoutSubviewsWithHandlePosition:(_on ? self.frame.size.width - _handleWidth : 0.0f)];
	
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
	CGFloat labelClipWidth = 3.0f;
	NSUInteger position = 1;
	
	_labelMaskView.frame = UIEdgeInsetsInsetRect(CGRectMake(labelClipWidth, 0.0f, width - labelClipWidth * 2.0f, height), _trackEdgeInsets);
	
	// Enforce limits
	x = fminf(fmaxf(0.0f, x), sideWidth);
	
	// Calculate shadow width
	if (_handleShadowWidth > 0.0f) {
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
	
	_handle.frame = UIEdgeInsetsInsetRect(CGRectMake(x - _handleShadowWidth, 0.0f, _handleWidth + _handleShadowWidth + _handleShadowWidth, height), _trackEdgeInsets);
	_onBackgroundImageView.frame = CGRectMake(0.0f, 0.0f, width, height);

	CGFloat leftCapWidth = _leftHandleImage.leftCapWidth;
	_offBackgroundImageView.frame = CGRectMake(x + _trackEdgeInsets.left + leftCapWidth, 0.0f, width - x - _trackEdgeInsets.left - leftCapWidth, height);
	
	// TODO: These are still a bit hacky (with the +2 and -1)
	_onLabel.frame = CGRectMake(x - labelWidth - _trackEdgeInsets.left - labelClipWidth + 2.0f, 0.0f, labelWidth, labelHeight);
	_offLabel.frame = CGRectMake(x + _handleWidth - _trackEdgeInsets.right - labelClipWidth - 1.0f, 0.0f, labelWidth, labelHeight);
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
			
			self.leftHandleImage = [[UIImage imageNamed:@"UISwitchButtonRightShadowed.png" bundle:kSSToolkitBundleName] stretchableImageWithLeftCapWidth:leftCap topCapHeight:0];
			self.leftHandleImageHighlighted = [[UIImage imageNamed:@"UISwitchButtonRightShadowedDown.png" bundle:kSSToolkitBundleName] stretchableImageWithLeftCapWidth:leftCap topCapHeight:0];
			self.centerHandleImage = [[UIImage imageNamed:@"UISwitchButtonFullShadowed.png" bundle:kSSToolkitBundleName] stretchableImageWithLeftCapWidth:leftCap topCapHeight:0];
			self.centerHandleImageHighlighted = [[UIImage imageNamed:@"UISwitchButtonFullShadowedDown.png" bundle:kSSToolkitBundleName] stretchableImageWithLeftCapWidth:leftCap topCapHeight:0];
			self.rightHandleImage = [[UIImage imageNamed:@"UISwitchButtonLeftShadowed.png" bundle:kSSToolkitBundleName] stretchableImageWithLeftCapWidth:leftCap topCapHeight:0];
			self.rightHandleImageHighlighted = [[UIImage imageNamed:@"UISwitchButtonLeftShadowedDown.png" bundle:kSSToolkitBundleName] stretchableImageWithLeftCapWidth:leftCap topCapHeight:0];
			
			self.handleWidth = 42;
			self.handleShadowWidth = 2;
			
			self.onBackgroundImageView.image = [[UIImage imageNamed:@"UISwitchTrackBlue.png" bundle:kSSToolkitBundleName] stretchableImageWithLeftCapWidth:5 topCapHeight:0];

			self.onLabel.textColor = [UIColor whiteColor];
			self.onLabel.font = [UIFont boldSystemFontOfSize:16.0f];
			self.onLabel.shadowColor = [UIColor colorWithWhite:0.0f alpha:0.5f];
			self.onLabel.shadowOffset = CGSizeMake(0.0f, -1.0f);
			
			self.offBackgroundImageView.image = [[UIImage imageNamed:@"UISwitchTrackClear.png" bundle:kSSToolkitBundleName] stretchableImageWithLeftCapWidth:5 topCapHeight:0];
			
			self.offLabel.textColor = [UIColor colorWithWhite:0.475f alpha:1.0f];
			self.offLabel.font = [UIFont boldSystemFontOfSize:16.0f];
			self.offLabel.shadowColor = nil;			
			
			self.trackEdgeInsets = UIEdgeInsetsZero;

			break;
		}
			
		case SSSwitchStyleAirplane: {
			self.onBackgroundImageView.image = [[UIImage imageNamed:@"UISwitchTrackOrange.png" bundle:kSSToolkitBundleName] stretchableImageWithLeftCapWidth:5 topCapHeight:0];
			break;
		}
	}
	
	[self _layoutSubviewsWithHandlePosition:_on ? 1.0f : 0.0f];
}



#pragma mark NSKeyValueObserving

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
	if ([keyPath isEqualToString:@"on"] || [keyPath isEqualToString:@"style"] || [keyPath isEqualToString:@"leftHandleImage"] ||
		[keyPath isEqualToString:@"leftHandleImageHighlighted"] || [keyPath isEqualToString:@"centerHandleImage"] ||
		[keyPath isEqualToString:@"centerHandleImageHighlighted"] || [keyPath isEqualToString:@"rightHandleImage"] ||
		[keyPath isEqualToString:@"rightHandleImageHighlighted"] || [keyPath isEqualToString:@"handleShadowWidth"] ||
		[keyPath isEqualToString:@"trackEdgeInsets"] || [keyPath isEqualToString:@"switchLabelStyle"]) {
		[self setNeedsDisplay];
		return;
	}
	
	[super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
}

@end
