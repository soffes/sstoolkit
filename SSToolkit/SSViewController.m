//
//  SSViewController.m
//  SSToolkit
//
//  Created by Sam Soffes on 7/14/10.
//  Copyright 2010 Sam Soffes. All rights reserved.
//

#import "SSViewController.h"
#import "UIImage+SSToolkitAdditions.h"
#import "UIView+SSToolkitAdditions.h"
#import <QuartzCore/QuartzCore.h>

static CGFloat kSSViewControllerModalPadding = 22.0;
#define kSSViewControllerDefaultContentSizeForViewInCustomModal CGSizeMake(540.0, 620.0)

@interface SSViewController (PrivateMethods)
- (void)_cleanUpModal;
- (void)_presentModalAnimationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context;
- (void)_dismissModalAnimationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context;
- (void)_dismissVignetteAnimationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context;
@end


@implementation SSViewController

@synthesize modalParentViewController = _modalParentViewController;
@synthesize customModalViewController = _customModalViewController;
@synthesize dismissCustomModalOnVignetteTap = _dismissCustomModalOnVignetteTap;
@synthesize contentSizeForViewInCustomModal = _contentSizeForViewInCustomModal;

#pragma mark NSObject

- (id)init {
	if ((self = [super init])) {
		_dismissCustomModalOnVignetteTap = NO;
		_contentSizeForViewInCustomModal = kSSViewControllerDefaultContentSizeForViewInCustomModal;
	}
	return self;
}


- (void)dealloc {
	[self _cleanUpModal];
	[super dealloc];
}

#pragma mark UIViewController

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
	[UIView beginAnimations:@"rotate" context:self];
	[UIView setAnimationDuration:duration];
	[self layoutViewsWithOrientation:toInterfaceOrientation];
	[UIView commitAnimations];
}


- (void)viewWillAppear:(BOOL)animated {
	[self layoutViews];
}

#pragma mark Layout

- (void)layoutViews {
	[self layoutViewsWithOrientation:self.interfaceOrientation];
}


- (void)layoutViewsWithOrientation:(UIInterfaceOrientation)orientation {
	CGSize screenSize;
	
	// TODO: Make this not iPad specific
	
	// Landscape
	if (orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight) {
		screenSize = CGSizeMake(1024.0, 768.0);
		_vignetteButton.frame = CGRectMake(0.0, -128.0, 1024.0, 1024.0);
	}
	
	// Portrait
	else {
		screenSize = CGSizeMake(768.0, 1024.0);
		_vignetteButton.frame = CGRectMake(-128.0, 0.0, 1024.0, 1024.0);
	}
	
	CGSize modalSize = kSSViewControllerDefaultContentSizeForViewInCustomModal;
	if ([_customModalViewController respondsToSelector:@selector(contentSizeForViewInCustomModal)]) {
		modalSize = [_customModalViewController contentSizeForViewInCustomModal];
	}
	_modalContainerBackgroundView.frame = CGRectMake(roundf(screenSize.width - modalSize.width - kSSViewControllerModalPadding - kSSViewControllerModalPadding) / 2.0, (roundf(screenSize.height - modalSize.height - kSSViewControllerModalPadding - kSSViewControllerModalPadding) / 2.0), modalSize.width + kSSViewControllerModalPadding + kSSViewControllerModalPadding, modalSize.height + kSSViewControllerModalPadding + kSSViewControllerModalPadding);
}

#pragma mark Modal

- (void)presentCustomModalViewController:(id<SSModalViewController>)viewController {
	_customModalViewController = [viewController retain];
	
	if (_customModalViewController == nil) {
		return;
	}
	
	_customModalViewController.modalParentViewController = self;
	
	CGSize modalSize = kSSViewControllerDefaultContentSizeForViewInCustomModal;
	if ([_customModalViewController respondsToSelector:@selector(contentSizeForViewInCustomModal)]) {
		modalSize = [_customModalViewController contentSizeForViewInCustomModal];
	}
	
	if (_vignetteButton == nil) {
		_vignetteButton = [[UIButton alloc] initWithFrame:CGRectZero];
		[_vignetteButton setImage:[UIImage imageNamed:@"images/SSViewControllerModalVignetteiPad.png" bundle:@"SSToolkit.bundle"] forState:UIControlStateNormal];
		_vignetteButton.adjustsImageWhenHighlighted = NO;
		_vignetteButton.alpha = 0.0;
		
		if ([_customModalViewController dismissCustomModalOnVignetteTap] == YES) {
			[_vignetteButton addTarget:self action:@selector(dismissCustomModalViewController) forControlEvents:UIControlEventTouchUpInside];
		}
	}
	
	[self.view addSubview:_vignetteButton];
	[_vignetteButton fadeIn];
	
	if (_modalContainerBackgroundView == nil) {
		UIImage *modalBackgroundImage = [[UIImage imageNamed:@"images/SSViewControllerFormBackground.png" bundle:@"SSToolkit.bundle"] stretchableImageWithLeftCapWidth:43.0 topCapHeight:45.0];
		_modalContainerBackgroundView = [[UIImageView alloc] initWithImage:modalBackgroundImage];
		_modalContainerBackgroundView.autoresizesSubviews = NO;
		_modalContainerBackgroundView.userInteractionEnabled = YES;
	}
	
	[self.view addSubview:_modalContainerBackgroundView];
	
	if (_modalContainerView == nil) {
		_modalContainerView = [[UIView alloc] initWithFrame:CGRectMake(kSSViewControllerModalPadding, kSSViewControllerModalPadding, modalSize.width, modalSize.height)];
		_modalContainerView.layer.cornerRadius = 5.0;
		_modalContainerView.clipsToBounds = YES;
		[_modalContainerBackgroundView addSubview:_modalContainerView];
	}
	
	UIView *modalView = _customModalViewController.view;
	[_modalContainerView addSubview:modalView];
	modalView.frame = CGRectMake(0.0, 0.0, modalSize.width, modalSize.height);
	
	CGSize screenSize;
	if (self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft || self.interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
		screenSize = CGSizeMake(1024.0, 768.0);
	} else {
		screenSize = CGSizeMake(768.0, 1024.0);
	}
	
	_modalContainerBackgroundView.frame = CGRectMake(roundf(screenSize.width - modalSize.width - kSSViewControllerModalPadding - kSSViewControllerModalPadding) / 2.0, (roundf(screenSize.height - modalSize.height - kSSViewControllerModalPadding - kSSViewControllerModalPadding) / 2.0) + screenSize.height, modalSize.width + kSSViewControllerModalPadding + kSSViewControllerModalPadding, modalSize.height + kSSViewControllerModalPadding + kSSViewControllerModalPadding);
	
	
	if ([_customModalViewController respondsToSelector:@selector(viewWillAppear:)]) {
		[_customModalViewController viewWillAppear:YES];
	}
	[UIView beginAnimations:@"com.tastefulworks.twviewcontroller.present-modal" context:self];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationDuration:0.5];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(_presentModalAnimationDidStop:finished:context:)];
	[self layoutViewsWithOrientation:self.interfaceOrientation];
	[UIView commitAnimations];
}


- (void)dismissCustomModalViewController {
	CGSize screenSize;
	if (self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft || self.interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
		screenSize = CGSizeMake(1024.0, 768.0);
	} else {
		screenSize = CGSizeMake(768.0, 1024.0);
	}
	
	CGSize modalSize = kSSViewControllerDefaultContentSizeForViewInCustomModal;
	if ([_customModalViewController respondsToSelector:@selector(contentSizeForViewInCustomModal)]) {
		modalSize = [_customModalViewController contentSizeForViewInCustomModal];
	}
	
	
	[UIView beginAnimations:@"com.tastefulworks.twviewcontroller.dismiss-modal" context:self];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationDuration:0.4];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(_dismissModalAnimationDidStop:finished:context:)];
	_modalContainerBackgroundView.frame = CGRectMake(roundf(screenSize.width - modalSize.width - kSSViewControllerModalPadding - kSSViewControllerModalPadding) / 2.0, (roundf(screenSize.height - modalSize.height - kSSViewControllerModalPadding - kSSViewControllerModalPadding) / 2.0) + screenSize.height, modalSize.width + kSSViewControllerModalPadding + kSSViewControllerModalPadding, modalSize.height + kSSViewControllerModalPadding + kSSViewControllerModalPadding);
	[UIView commitAnimations];
	
	[UIView beginAnimations:@"com.tastefulworks.twviewcontroller.remove-vignette" context:self];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationDelay:0.2];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(_dismissVignetteAnimationDidStop:finished:context:)];
	_vignetteButton.alpha = 0.0;
	[UIView commitAnimations];	
}

#pragma mark Private Methods

- (void)_cleanUpModal {
	[_modalContainerBackgroundView removeFromSuperview];
	[_modalContainerBackgroundView release];
	_modalContainerBackgroundView = nil;
	
	[_vignetteButton removeFromSuperview];
	[_vignetteButton release];
	_vignetteButton = nil;
	
	[_customModalViewController release];
	_customModalViewController = nil;
	
	[_modalContainerView release];
	_modalContainerView = nil;
}


- (void)_presentModalAnimationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
	if ([_customModalViewController respondsToSelector:@selector(viewDidAppear:)]) {
		[_customModalViewController viewDidAppear:YES];
	}
}


- (void)_dismissModalAnimationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
	if ([_customModalViewController respondsToSelector:@selector(viewDidDisappear:)]) {
		[_customModalViewController viewDidDisappear:YES];
	}
}


- (void)_dismissVignetteAnimationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
	[self _cleanUpModal];
}

@end
