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
	UIView *_modalContainerView;
	UIImageView *_modalContainerBackgroundView;
	UIImageView *_vignetteView;
}

@property (nonatomic, assign) TWViewController *modalParentViewController;
@property (nonatomic, retain, readonly) UIViewController *customModalViewController;

- (void)layoutViews;
- (void)layoutViewsWithOrientation:(UIInterfaceOrientation)orientation;

- (void)presentCustomModalViewController:(id<TWModalViewController>)viewController;
- (void)dismissCustomModalViewController;

@end
