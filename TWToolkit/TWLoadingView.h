//
//  TWLoadingView.h
//  TWToolkit
//
//  Created by Sam Soffes on 7/8/09.
//  Copyright 2009 Tasteful Works, Inc. All rights reserved.
//

@interface TWLoadingView : UIView {

	UIActivityIndicatorView *indicator;
	NSString *text;
	UIFont *font;
	UIColor *textColor;
	UIColor *shadowColor;
}

@property (nonatomic, retain) UIActivityIndicatorView *indicator;
@property (nonatomic, retain) NSString *text;
@property (nonatomic, retain) UIFont *font;
@property (nonatomic, retain) UIColor *textColor;
@property (nonatomic, retain) UIColor *shadowColor;

@end
