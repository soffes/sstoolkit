//
//  SSHUDView.h
//  SSToolkit
//
//  Created by Sam Soffes on 9/29/09.
//  Copyright 2009-2010 Sam Soffes. All rights reserved.
//

@class SSHUDWindow;

@interface SSHUDView : UIView {
	
	SSHUDWindow *_hudWindow;
	UILabel *_textLabel;
	UIActivityIndicatorView *_activityIndicator;
	
	CGSize _hudSize;
	BOOL _textLabelHidden;
	BOOL _loading;
	BOOL _successful;
}

@property (nonatomic, retain, readonly) UILabel *textLabel;
@property (nonatomic, assign) BOOL textLabelHidden;
@property (nonatomic, retain, readonly) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, assign) CGSize hudSize;
@property (nonatomic, assign, getter=isLoading) BOOL loading;
@property (nonatomic, assign, getter=isSuccessful) BOOL successful;
@property (nonatomic, assign) BOOL showsVignette;

- (id)initWithTitle:(NSString *)aTitle;
- (id)initWithTitle:(NSString *)aTitle loading:(BOOL)isLoading;
- (void)show;
- (void)completeWithTitle:(NSString *)aTitle;
- (void)completeAndDismissWithTitle:(NSString *)aTitle;
- (void)failWithTitle:(NSString *)aTitle;
- (void)failAndDismissWithTitle:(NSString *)aTitle;
- (void)dismiss;
- (void)dismissAnimated:(BOOL)animated;

@end
