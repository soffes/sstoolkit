//
//  SSHUDView.h
//  SSToolkit
//
//  Created by Sam Soffes on 9/29/09.
//  Copyright 2009-2011 Sam Soffes. All rights reserved.
//

@interface SSHUDView : UIView

@property (nonatomic, retain, readonly) UILabel *textLabel;
@property (nonatomic, assign) BOOL textLabelHidden;
@property (nonatomic, retain, readonly) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, assign) CGSize hudSize;
@property (nonatomic, assign, getter=isLoading) BOOL loading;
@property (nonatomic, assign, getter=isSuccessful) BOOL successful;
@property (nonatomic, assign) BOOL hidesVignette;
@property (nonatomic, retain) UIImage *completeImage;
@property (nonatomic, retain) UIImage *failImage;

- (id)initWithTitle:(NSString *)aTitle;
- (id)initWithTitle:(NSString *)aTitle loading:(BOOL)isLoading;

- (void)show;
- (void)dismiss;
- (void)dismissAnimated:(BOOL)animated;

- (void)completeWithTitle:(NSString *)aTitle;
- (void)completeAndDismissWithTitle:(NSString *)aTitle;
- (void)completeQuicklyWithTitle:(NSString *)aTitle;

- (void)failWithTitle:(NSString *)aTitle;
- (void)failAndDismissWithTitle:(NSString *)aTitle;
- (void)failQuicklyWithTitle:(NSString *)aTitle;

@end
