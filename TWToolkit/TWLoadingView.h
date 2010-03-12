//
//  TWLoadingView.h
//  TWToolkit
//
//  Created by Sam Soffes on 7/8/09.
//  Copyright 2009 Tasteful Works, Inc. All rights reserved.
//

@interface TWLoadingView : UIView {

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
