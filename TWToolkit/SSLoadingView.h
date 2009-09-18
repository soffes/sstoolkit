//
//  SSLoadingView.h
//  Four80
//
//  Created by Sam Soffes on 7/8/09.
//  Copyright 2009 Sam Soffes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SSLoadingView : UIView {

	UIActivityIndicatorView *indicator;
	NSString *text;
	UIFont *font;
	UIColor *color;
	UIColor *shadowColor;
}

@property (nonatomic, retain) UIActivityIndicatorView *indicator;
@property (nonatomic, retain) NSString *text;
@property (nonatomic, retain) UIFont *font;
@property (nonatomic, retain) UIColor *color;
@property (nonatomic, retain) UIColor *shadowColor;

@end
