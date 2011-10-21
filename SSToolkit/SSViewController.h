//
//  SSViewController.h
//  SSToolkit
//
//  Created by Sam Soffes on 7/14/10.
//  Copyright 2010-2011 Sam Soffes. All rights reserved.
//

#import "SSModalViewController.h"

/**
 UIViewController subclass that displaying custom modals and
 other nice enhancements.

 Note: Currently only iPad is supported.
 */
@interface SSViewController : UIViewController <SSModalViewController>

@property (nonatomic, assign) SSViewController *modalParentViewController;
@property (nonatomic, retain, readonly) UIViewController<SSModalViewController> *customModalViewController;
@property (nonatomic, assign) BOOL dismissCustomModalOnVignetteTap;
@property (nonatomic, assign) CGSize contentSizeForViewInCustomModal;
@property (nonatomic, assign) CGPoint originOffsetForViewInCustomModal;

- (void)layoutViews;
- (void)layoutViewsWithOrientation:(UIInterfaceOrientation)orientation;

- (void)presentCustomModalViewController:(UIViewController<SSModalViewController> *)viewController;
- (void)presentCustomModalViewController:(UIViewController<SSModalViewController> *)viewController animated:(BOOL)animated;
- (void)dismissCustomModalViewController;
- (void)dismissCustomModalViewController:(BOOL)animated;

- (void)customModalWillAppear:(BOOL)animated;
- (void)customModalDidAppear:(BOOL)animated;
- (void)customModalWillDisappear:(BOOL)animated;
- (void)customModalDidDisappear:(BOOL)animated;

@end
