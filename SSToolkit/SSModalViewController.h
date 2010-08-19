//
//  SSModalViewController.h
//  SSToolkit
//
//  Created by Sam Soffes on 7/14/10.
//  Copyright 2010 Sam Soffes. All rights reserved.
//

@class SSViewController;

@protocol SSModalViewController <NSObject, NSCoding>

@required

@property (nonatomic, assign) SSViewController *modalParentViewController;

- (UIView *)view;

@optional

- (BOOL)dismissCustomModalOnVignetteTap;
- (CGSize)contentSizeForViewInCustomModal;

- (void)viewWillAppear:(BOOL)animated;
- (void)viewDidAppear:(BOOL)animated;
- (void)viewWillDisappear:(BOOL)animated;
- (void)viewDidDisappear:(BOOL)animated;

@end
