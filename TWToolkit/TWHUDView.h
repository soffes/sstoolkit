//
//  TWHUDView.h
//  TWToolkit
//
//  Created by Sam Soffes on 9/29/09.
//  Copyright 2009 Tasteful Works, Inc. All rights reserved.
//

@interface TWHUDView : UIAlertView {
	
	UILabel *_textLabel;
	UIActivityIndicatorView *_activityIndicator;
	BOOL _loading;
	BOOL _successful;
}

@property (nonatomic, retain, readonly) UILabel *textLabel;
@property (nonatomic, retain, readonly) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, assign, getter=isLoading) BOOL loading;
@property (nonatomic, assign, getter=isSuccessful) BOOL successful;

- (id)initWithTitle:(NSString *)aTitle;
- (id)initWithTitle:(NSString *)aTitle loading:(BOOL)isLoading;
- (void)completeWithTitle:(NSString *)aTitle;
- (void)completeAndDismissWithTitle:(NSString *)aTitle;
- (void)completeWithErrorAndTitle:(NSString *)aTitle;
- (void)completeWithErrorAndDismissWithTitle:(NSString *)aTitle;
- (void)dismiss;
- (void)dismissAnimated:(BOOL)animated;

@end
