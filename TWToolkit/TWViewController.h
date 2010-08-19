//
//  TWViewController.h
//  TWToolkit
//
//  Created by Sam Soffes on 7/14/10.
//  Copyright 2010 Tasteful Works. All rights reserved.
//
//  TODO: Support iPhone and iPhone 4
//

#import "TWModalViewController.h"

@interface TWViewController : UIViewController <TWModalViewController> {

	TWViewController *_modalParentViewController;
	id<TWModalViewController> _customModalViewController;
	BOOL _dismissCustomModalOnVignetteTap;
	CGSize _contentSizeForViewInCustomModal;
	
	UIView *_modalContainerView;
	UIImageView *_modalContainerBackgroundView;
	UIButton *_vignetteButton;
}

@property (nonatomic, assign) TWViewController *modalParentViewController;
@property (nonatomic, retain, readonly) UIViewController *customModalViewController;
@property (nonatomic, assign) BOOL dismissCustomModalOnVignetteTap;
@property (nonatomic, assign) CGSize contentSizeForViewInCustomModal;

- (void)layoutViews;
- (void)layoutViewsWithOrientation:(UIInterfaceOrientation)orientation;

- (void)presentCustomModalViewController:(id<TWModalViewController>)viewController;
- (void)dismissCustomModalViewController;

@end
