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
@synthesize handleView = _handleView;
@synthesize onLabel = _onLabel;
@synthesize offLabel = _offLabel;
@synthesize onBackgroundImageView = _onBackgroundImageView;
@synthesize offBackgroundImageView = _offBackgroundImageView;
@synthesize handleWidth = _handleWidth;
@synthesize trackEdgeInsets = _trackEdgeInsets;
@synthesize style = _style;

#pragma mark NSObject

- (void)dealloc {
	self.handleView = nil;
	self.onLabel = nil;
	self.offLabel = nil;
	self.onBackgroundImageView = nil;
	self.offBackgroundImageView = nil;
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
		_onLabel.font = [UIFont boldSystemFontOfSize:16.0];
		_onLabel.text = @"ON";
		_onLabel.textAlignment = UITextAlignmentCenter;
		_onLabel.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
		_onLabel.shadowOffset = CGSizeMake(0.0, -1.0);
		[_labelMaskView addSubview:_onLabel];
		
		// Off label
		_offLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		_offLabel.backgroundColor = [UIColor clearColor];
		_offLabel.font = [UIFont boldSystemFontOfSize:16.0];
		_offLabel.text = @"OFF";
		_offLabel.textAlignment = UITextAlignmentCenter;
		_offLabel.shadowColor = [UIColor whiteColor];
		_offLabel.shadowOffset = CGSizeMake(0.0, 1.0);
		[_labelMaskView addSubview:_offLabel];
		
		// Handle
		_handleView = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
		[_handleView addTarget:self action:@selector(_handleReleased:) forControlEvents:UIControlEventTouchUpInside];
		[_handleView addTarget:self action:@selector(_handleDragged:event:) forControlEvents:UIControlEventTouchDragInside];
		[_handleView addTarget:self action:@selector(_handleDraggingEnded:) forControlEvents:UIControlEventTouchUpOutside];
		[self addSubview:_handleView];
		
		// Defaults
		_dragging = NO;
		_hitCount = 0;
		_handleWidth = 42.0;
		_trackEdgeInsets = UIEdgeInsetsMake(2.0, 2.0, 2.0, 2.0);
		_on = NO;
		[self _layoutSubviewsWithHandlePosition:0.0];
		self.style = SSSwitchStyleDefault;
	}
	return self;
}


- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
	// Forward all touches to the handle
	return [super hitTest:point withEvent:event] ? _handleView : nil;
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
		[UIView setAnimationDuration:0.15];
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
	
	_labelMaskView.frame = UIEdgeInsetsInsetRect(CGRectMake(0.0, 0.0, width, height), _trackEdgeInsets);
	
	// Enforce limits
	x = fmin(fmax(0.0, x), sideWidth);
	
	_handleView.frame = UIEdgeInsetsInsetRect(CGRectMake(x, 0.0, _handleWidth, height), _trackEdgeInsets);
	_onBackgroundImageView.frame = CGRectMake(0.0, 0.0, width, height);
	_offBackgroundImageView.frame = CGRectMake(x + _trackEdgeInsets.left + 3.0, 0.0, width - x - _trackEdgeInsets.left - 3.0, height); // TODO: Make 3 a property for round
	
	_onLabel.frame = CGRectMake(x - labelWidth - _trackEdgeInsets.left, 0.0, labelWidth, labelHeight);
	_offLabel.frame = CGRectMake(x + _handleWidth - _trackEdgeInsets.right, 0.0, labelWidth, labelHeight);
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
		[self setOn:(_handleView.frame.origin.x >= self.frame.size.width - _handleWidth + _trackEdgeInsets.right) animated:YES];
	} else {
		[self setOn:(_handleView.frame.origin.x > _trackEdgeInsets.right) animated:YES];
	}
}


- (void)_handleDragged:(id)sender event:(UIEvent *)event {
	UITouch *touch = [[event touchesForView:_handleView] anyObject];
	
	if (_dragging == NO) {
		_dragOffset = [touch locationInView:_handleView].x;
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
	
	switch (_style) {
		case SSSwitchStyleDefault: {
			_onBackgroundImageView.image = [[UIImage imageNamed:@"images/UISwitchTrackBlue.png" bundle:@"SSToolkit.bundle"] stretchableImageWithLeftCapWidth:5 topCapHeight:0];
			_onLabel.textColor = [UIColor whiteColor];
			
			_offBackgroundImageView.image = [[UIImage imageNamed:@"images/UISwitchTrackClear.png" bundle:@"SSToolkit.bundle"] stretchableImageWithLeftCapWidth:5 topCapHeight:0];
			_offLabel.textColor = [UIColor colorWithWhite:0.475 alpha:1.0];
			
			[_handleView setBackgroundImage:[[UIImage imageNamed:@"images/UISwitchButtonFullShadowed.png" bundle:@"SSToolkit.bundle"] stretchableImageWithLeftCapWidth:3 topCapHeight:0] forState:UIControlStateNormal];
			[_handleView setBackgroundImage:[[UIImage imageNamed:@"images/UISwitchButtonFullShadowedDown.png" bundle:@"SSToolkit.bundle"] stretchableImageWithLeftCapWidth:3 topCapHeight:0] forState:UIControlStateHighlighted];
			break;
		}
			
		case SSSwitchStyleAirplane: {
			_onBackgroundImageView.image = [[UIImage imageNamed:@"images/UISwitchTrackOrange.png" bundle:@"SSToolkit.bundle"] stretchableImageWithLeftCapWidth:5 topCapHeight:0];
			_onLabel.textColor = [UIColor whiteColor];
			
			_offBackgroundImageView.image = [[UIImage imageNamed:@"images/UISwitchTrackClear.png" bundle:@"SSToolkit.bundle"] stretchableImageWithLeftCapWidth:5 topCapHeight:0];
			_offLabel.textColor = [UIColor colorWithRed:0.482 green:0.376 blue:0.278 alpha:1.0];
			
			[_handleView setBackgroundImage:[[UIImage imageNamed:@"images/UISwitchButtonFullShadowed.png" bundle:@"SSToolkit.bundle"] stretchableImageWithLeftCapWidth:3 topCapHeight:0] forState:UIControlStateNormal];
			[_handleView setBackgroundImage:[[UIImage imageNamed:@"images/UISwitchButtonFullShadowedDown.png" bundle:@"SSToolkit.bundle"] stretchableImageWithLeftCapWidth:3 topCapHeight:0] forState:UIControlStateHighlighted];
			break;
		}
	}
}

@end
