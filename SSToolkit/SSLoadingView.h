//
//  SSLoadingView.h
//  SSToolkit
//
//  Created by Sam Soffes on 7/8/09.
//  Copyright 2009 Sam Soffes. All rights reserved.
//

@interface SSLoadingView : UIView {

	UIActivityIndicatorView *_activityIndicator;
	NSString *_text;
	UIFont *_font;
	UIColor *_textColor;
	UIColor *_shadowColor;
}

@property (nonatomic, retain, readonly) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, retain) UIFont *font;
@property (nonatomic, retain) UIColor *textColor;
@property (nonatomic, retain) UIColor *shadowColor;

@end
