//
//  SSAddressBarTextFieldBackgroundView.m
//  SSToolkit
//
//  Created by Sam Soffes on 2/8/11.
//  Copyright 2011 Sam Soffes. All rights reserved.
//

#import "SSAddressBarTextFieldBackgroundView.h"
#import "SSAddressBarTextFieldBackgroundViewInnerView.h"
#import "UIView+SSToolkitAdditions.h"
#import <QuartzCore/QuartzCore.h>

static CGFloat kLoadingBackgroundWidth = 49.0f;

@interface SSAddressBarTextFieldBackgroundView (PrivateMethods)

- (void)_setupAnimation;

@end

@implementation SSAddressBarTextFieldBackgroundView {
	SSAddressBarTextFieldBackgroundViewInnerView *_innerView;
}


@synthesize loading = _loading;

- (void)setLoading:(BOOL)isLoading {
	if (_loading == isLoading) {
		return;
	}
	_loading = isLoading;
	
	if (_loading) {
		[self _setupAnimation];
		[_innerView fadeIn];
	} else {
		[_innerView fadeOut];
	}
	[self setNeedsDisplay];
}


#pragma mark - UIView

- (id)initWithFrame:(CGRect)aFrame {
	if ((self = [super initWithFrame:aFrame])) {
		self.layer.cornerRadius = 6.0f;
		
		self.backgroundColor = [UIColor clearColor];
		self.alpha = 0.8f;
		self.opaque = NO;
		self.clipsToBounds = YES;
		self.userInteractionEnabled = NO;
		self.contentMode = UIViewContentModeRedraw;
		
		_innerView = [[SSAddressBarTextFieldBackgroundViewInnerView alloc] initWithFrame:CGRectZero];
		[self addSubview:_innerView];		
	}
	return self;
}


#pragma mark - Private Methods

- (void)_setupAnimation {
	
	if (![_innerView.layer animationForKey:@"translation"]) {
		_innerView.frame = CGRectMake(0, 0, self.frame.size.width + kLoadingBackgroundWidth, self.frame.size.height);	
		CABasicAnimation *translation = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
		translation.duration = 3;
		translation.repeatCount = INFINITY;
		translation.autoreverses = NO;
		translation.fromValue = [NSNumber numberWithFloat: - kLoadingBackgroundWidth];
		translation.toValue = [NSNumber numberWithFloat: 0.0f];
		
		CAMediaTimingFunction *easeInEffect = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
		[translation setTimingFunction:easeInEffect];
		[_innerView.layer addAnimation:translation forKey:@"translation"];
	}
}

@end
