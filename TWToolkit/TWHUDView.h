//
//  TWHUDView.h
//  TWToolkit
//
//  Created by Sam Soffes on 9/29/09.
//  Copyright 2009 Tasteful Works, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TWHUDView : UIView {
	UIImage *background;
	UILabel *label;
	UIActivityIndicatorView *activityIndicator;
}

@property (nonatomic, retain) UIImage *background;
@property (nonatomic, retain) UILabel *label;
@property (nonatomic, retain) UIActivityIndicatorView *activityIndicator;

@end
