//
//  TWViewController.m
//  TWToolkit
//
//  Created by Sam Soffes on 7/14/10.
//  Copyright 2010 Tasteful Works. All rights reserved.
//

#import "TWViewController.h"
#import "UIImage+TWToolkitAdditions.h"
#import "UIView+TWToolkitAdditions.h"
#import <QuartzCore/QuartzCore.h>

@interface TWViewController (PrivateMethods)
- (void)_cleanUpModal;
- (void)_presentModalAnimationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context;
- (void)_dismissModalAnimationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context;
- (void)_dismissVignetteAnimationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context;
@end


@implementation TWViewController

@synthesize modalParentViewController = _modalParentViewController;
@synthesize customModalViewController = _customModalViewController;

#pragma mark NSObject

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
	CGSize size;
	
	// Landscape
	if (orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight) {
		size = CGSizeMake(1024.0, 768.0);
		_vignetteView.frame = CGRectMake(0.0, -128.0, 1024.0, 1024.0);
	}
	
	// Portrait
	else {
		size = CGSizeMake(768.0, 1024.0);
		_vignetteView.frame = CGRectMake(-128.0, 0.0, 1024.0, 1024.0);
	}
	
	_modalContainerBackgroundView.frame = CGRectMake(roundf(size.width - 554.0) / 2.0, (roundf(size.height - 634.0) / 2.0), 554.0, 634.0);
}

#pragma mark Modal

- (void)presentCustomModalViewController:(id<TWModalViewController>)viewController {
	_customModalViewController = [viewController retain];
	
	if (_customModalViewController == nil) {
		return;
	}
	
	_customModalViewController.modalParentViewController = self;
	
	if (_vignetteView == nil) {
		_vignetteView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"images/vignette-ipad.png" bundle:@"TWToolkit.bundle"]];
		_vignetteView.alpha = 0.0;
		_vignetteView.userInteractionEnabled = YES;
	}
	
	[self.view addSubview:_vignetteView];
	[_vignetteView fadeIn];
	
	if (_modalContainerBackgroundView == nil) {
		_modalContainerBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"form-background.png"]];
		_modalContainerBackgroundView.autoresizesSubviews = NO;
		_modalContainerBackgroundView.userInteractionEnabled = YES;
	}
	
	[self.view addSubview:_modalContainerBackgroundView];
	
	if (_modalContainerView == nil) {
		_modalContainerView = [[UIView alloc] initWithFrame:CGRectMake(7.0, 7.0, 540.0, 620.0)];
		_modalContainerView.layer.cornerRadius = 5.0;
		_modalContainerView.clipsToBounds = YES;
		[_modalContainerBackgroundView addSubview:_modalContainerView];
	}
	
	UIView *modalView = _customModalViewController.view;
	[_modalContainerView addSubview:modalView];
	modalView.frame = CGRectMake(0.0, 0.0, 540.0, 620.0);
	
	CGSize size;
	if (self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft || self.interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
		size = CGSizeMake(1024.0, 768.0);
	} else {
		size = CGSizeMake(768.0, 1024.0);
	}
	
	_modalContainerBackgroundView.frame = CGRectMake(roundf(size.width - 554.0) / 2.0, (roundf(size.height - 634.0) / 2.0) + size.height, 554.0, 634.0);
	
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
	CGSize size;
	if (self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft || self.interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
		size = CGSizeMake(1024.0, 768.0);
	} else {
		size = CGSizeMake(768.0, 1024.0);
	}
	
	[UIView beginAnimations:@"com.tastefulworks.twviewcontroller.dismiss-modal" context:self];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationDuration:0.4];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(_dismissModalAnimationDidStop:finished:context:)];
	_modalContainerBackgroundView.frame = CGRectMake(roundf(size.width - 554.0) / 2.0, (roundf(size.height - 634.0) / 2.0) + size.height, 554.0, 634.0);
	[UIView commitAnimations];
	
	[UIView beginAnimations:@"com.tastefulworks.twviewcontroller.remove-vignette" context:self];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationDelay:0.2];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(_dismissVignetteAnimationDidStop:finished:context:)];
	_vignetteView.alpha = 0.0;
	[UIView commitAnimations];	
}

#pragma mark Private Methods

- (void)_cleanUpModal {
	[_modalContainerBackgroundView removeFromSuperview];
	[_modalContainerBackgroundView release];
	_modalContainerBackgroundView = nil;
	
	[_vignetteView removeFromSuperview];
	[_vignetteView release];
	_vignetteView = nil;
	
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
