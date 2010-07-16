//
//  TWModalViewController.h
//  TWToolkit
//
//  Created by Sam Soffes on 7/14/10.
//  Copyright 2010 Tasteful Works. All rights reserved.
//

@class TWViewController;

@protocol TWModalViewController <NSObject, NSCoding>

@required

@property (nonatomic, assign) TWViewController *modalParentViewController;

- (UIView *)view;

@optional

- (void)viewWillAppear:(BOOL)animated;
- (void)viewDidAppear:(BOOL)animated;
- (void)viewWillDisappear:(BOOL)animated;
- (void)viewDidDisappear:(BOOL)animated;

@end
