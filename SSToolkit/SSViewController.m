//
//  SSViewController.m
//  SSToolkit
//
//  Created by Sam Soffes on 7/14/10.
//  Copyright 2010-2011 Sam Soffes. All rights reserved.
//

#import "SSViewController.h"
#import "UIImage+SSToolkitAdditions.h"
#import "UIView+SSToolkitAdditions.h"
#import <QuartzCore/QuartzCore.h>

static CGFloat const kSSViewControllerModalPadding = 22.0f;
static CGSize const kSSViewControllerDefaultContentSizeForViewInCustomModal = {540.0f, 620.0f};

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
@synthesize originOffsetForViewInCustomModal = _originOffsetForViewInCustomModal;

#pragma mark NSObject

- (id)init {
	if ((self = [super init])) {
		_dismissCustomModalOnVignetteTap = NO;
		_contentSizeForViewInCustomModal = kSSViewControllerDefaultContentSizeForViewInCustomModal;
		_originOffsetForViewInCustomModal = CGPointZero;
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
	if (!_customModalViewController) {
		return;
	}
	
	CGSize screenSize;
	
	// TODO: Make this not iPad specific
	
	// Landscape
	if (orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight) {
		screenSize = CGSizeMake(1024.0f, 768.0f);
		_vignetteButton.frame = CGRectMake(0.0f, -128.0f, 1024.0f, 1024.0f);
	}
	
	// Portrait
	else {
		screenSize = CGSizeMake(768.0f, 1024.0f);
		_vignetteButton.frame = CGRectMake(-128.0f, 0.0f, 1024.0f, 1024.0f);
	}
	
	CGSize modalSize = kSSViewControllerDefaultContentSizeForViewInCustomModal;
	if ([_customModalViewController respondsToSelector:@selector(contentSizeForViewInCustomModal)]) {
		modalSize = [_customModalViewController contentSizeForViewInCustomModal];
	}
	
	CGPoint originOffset = CGPointZero;
	if ([_customModalViewController respondsToSelector:@selector(originOffsetForViewInCustomModal)]) {
		originOffset = [_customModalViewController originOffsetForViewInCustomModal];
	}
	_modalContainerBackgroundView.frame = CGRectMake((roundf(screenSize.width - modalSize.width - kSSViewControllerModalPadding - kSSViewControllerModalPadding) / 2.0f) + originOffset.x, (roundf(screenSize.height - modalSize.height - kSSViewControllerModalPadding - kSSViewControllerModalPadding) / 2.0f) + originOffset.y, modalSize.width + kSSViewControllerModalPadding + kSSViewControllerModalPadding, modalSize.height + kSSViewControllerModalPadding + kSSViewControllerModalPadding);
}


#pragma mark Modal

- (void)presentCustomModalViewController:(UIViewController<SSModalViewController> *)viewController {
	[self presentCustomModalViewController:viewController animated:YES];
}


- (void)presentCustomModalViewController:(UIViewController<SSModalViewController> *)viewController animated:(BOOL)animated {
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
		[_vignetteButton setImage:[UIImage imageNamed:@"SSVignetteiPad.png" bundle:kSSToolkitBundleName] forState:UIControlStateNormal];
		_vignetteButton.adjustsImageWhenHighlighted = NO;
		_vignetteButton.alpha = 0.0f;
	}
	
	[self.view addSubview:_vignetteButton];
	[_vignetteButton fadeIn];
	
	if (_modalContainerBackgroundView == nil) {
		UIImage *modalBackgroundImage = [[UIImage imageNamed:@"SSViewControllerFormBackground.png" bundle:kSSToolkitBundleName] stretchableImageWithLeftCapWidth:43 topCapHeight:45];
		_modalContainerBackgroundView = [[UIImageView alloc] initWithImage:modalBackgroundImage];
		_modalContainerBackgroundView.autoresizesSubviews = NO;
		_modalContainerBackgroundView.userInteractionEnabled = YES;
	}
	
	[self.view addSubview:_modalContainerBackgroundView];
	
	if (_modalContainerView == nil) {
		_modalContainerView = [[UIView alloc] initWithFrame:CGRectMake(kSSViewControllerModalPadding, kSSViewControllerModalPadding, modalSize.width, modalSize.height)];
		_modalContainerView.layer.cornerRadius = 5.0f;
		_modalContainerView.clipsToBounds = YES;
		[_modalContainerBackgroundView addSubview:_modalContainerView];
	}
	
	UIView *modalView = _customModalViewController.view;
	[_modalContainerView addSubview:modalView];
	modalView.frame = CGRectMake(0.0f, 0.0f, modalSize.width, modalSize.height);
	
	CGSize screenSize;
	if (self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft || self.interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
		screenSize = CGSizeMake(1024.0f, 768.0f);
	} else {
		screenSize = CGSizeMake(768.0f, 1024.0f);
	}
	
	CGPoint originOffset = CGPointZero;
	if ([_customModalViewController respondsToSelector:@selector(originOffsetForViewInCustomModal)]) {
		originOffset = [_customModalViewController originOffsetForViewInCustomModal];
	}
	
	_modalContainerBackgroundView.frame = CGRectMake((roundf(screenSize.width - modalSize.width - kSSViewControllerModalPadding - kSSViewControllerModalPadding) / 2.0f) + originOffset.x, (roundf(screenSize.height - modalSize.height - kSSViewControllerModalPadding - kSSViewControllerModalPadding) / 2.0f) + originOffset.y + screenSize.height, modalSize.width + kSSViewControllerModalPadding + kSSViewControllerModalPadding, modalSize.height + kSSViewControllerModalPadding + kSSViewControllerModalPadding);
	
	
	if ([_customModalViewController respondsToSelector:@selector(viewWillAppear:)]) {
		[_customModalViewController viewWillAppear:animated];
	}
	
	[self customModalWillAppear:animated];
	
	if (animated) {
		[UIView beginAnimations:@"com.samsoffes.sstoolkit.ssviewcontroller.present-modal" context:self];
		[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
		[UIView setAnimationDuration:0.5];
		[UIView setAnimationDelegate:self];
		[UIView setAnimationDidStopSelector:@selector(_presentModalAnimationDidStop:finished:context:)];
	}
	
	[self layoutViews];
	
	if (animated) {
		[UIView commitAnimations];
	} else {
		[self _presentModalAnimationDidStop:nil finished:nil context:nil];
	}
}


- (void)dismissCustomModalViewController {
	[self dismissCustomModalViewController:YES];
}


- (void)dismissCustomModalViewController:(BOOL)animated {
	CGSize screenSize;
	if (self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft || self.interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
		screenSize = CGSizeMake(1024.0f, 768.0f);
	} else {
		screenSize = CGSizeMake(768.0f, 1024.0f);
	}
	
	CGSize modalSize = kSSViewControllerDefaultContentSizeForViewInCustomModal;
	if ([_customModalViewController respondsToSelector:@selector(contentSizeForViewInCustomModal)]) {
		modalSize = [_customModalViewController contentSizeForViewInCustomModal];
	}
	
	if ([_customModalViewController respondsToSelector:@selector(viewWillDisappear:)]) {
		[_customModalViewController viewWillDisappear:animated];
	}
	
	[self customModalWillDisappear:animated];	
	
	if (animated) {
		[UIView beginAnimations:@"com.samsoffes.sstoolkit.ssviewcontroller.dismiss-modal" context:self];
		[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
		[UIView setAnimationDuration:0.4];
		[UIView setAnimationDelegate:self];
		[UIView setAnimationDidStopSelector:@selector(_dismissModalAnimationDidStop:finished:context:)];
	} else {
		[self _dismissModalAnimationDidStop:nil finished:nil context:nil];
	}
	
	_modalContainerBackgroundView.frame = CGRectMake(roundf(screenSize.width - modalSize.width - kSSViewControllerModalPadding - kSSViewControllerModalPadding) / 2.0f, (roundf(screenSize.height - modalSize.height - kSSViewControllerModalPadding - kSSViewControllerModalPadding) / 2.0f) + screenSize.height, modalSize.width + kSSViewControllerModalPadding + kSSViewControllerModalPadding, modalSize.height + kSSViewControllerModalPadding + kSSViewControllerModalPadding);
	
	if (animated) {
		[UIView commitAnimations];
		
		[UIView beginAnimations:@"com.samsoffes.sstoolkit.ssviewcontroller.remove-vignette" context:self];
		[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
		[UIView setAnimationDelay:0.2];
		[UIView setAnimationDelegate:self];
		[UIView setAnimationDidStopSelector:@selector(_dismissVignetteAnimationDidStop:finished:context:)];
	}
	
	_vignetteButton.alpha = 0.0f;
	
	if (animated) {
		[UIView commitAnimations];
	} else {
		[self _dismissVignetteAnimationDidStop:nil finished:nil context:nil];
	}
}


- (void)customModalWillAppear:(BOOL)animated {
	// Can be overridden by a subclass
}


- (void)customModalDidAppear:(BOOL)animated {
	// Can be overridden by a subclass
}


- (void)customModalWillDisappear:(BOOL)animated {
	// Can be overridden by a subclass
}


- (void)customModalDidDisappear:(BOOL)animated {
	// Can be overridden by a subclass
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
	BOOL animated = (animationID != nil);
	
	if ([_customModalViewController respondsToSelector:@selector(viewDidAppear:)]) {
		[_customModalViewController viewDidAppear:animated];
	}
	
	[self customModalDidAppear:animated];
	
	if ([_customModalViewController respondsToSelector:@selector(dismissCustomModalOnVignetteTap)] && [_customModalViewController dismissCustomModalOnVignetteTap] == YES) {
		[_vignetteButton addTarget:self action:@selector(dismissCustomModalViewController) forControlEvents:UIControlEventTouchUpInside];
	}
}


- (void)_dismissModalAnimationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
	BOOL animated = (animationID != nil);
		
	if ([_customModalViewController respondsToSelector:@selector(viewDidDisappear:)]) {
		[_customModalViewController viewDidDisappear:animated];
	}
	
	[self customModalDidDisappear:animated];
}


- (void)_dismissVignetteAnimationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
	[self _cleanUpModal];
}

@end
