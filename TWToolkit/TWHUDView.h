//
//  TWHUDView.h
//  TWToolkit
//
//  Created by Sam Soffes on 9/29/09.
//  Copyright 2009 Tasteful Works, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TWHUDView : UIView {
	UIImage *backgroundImage;
	UILabel *textLabel;
	UIActivityIndicatorView *activityIndicator;
}

@property (nonatomic, retain) UIImage *backgroundImage;
@property (nonatomic, retain) UILabel *textLabel;
@property (nonatomic, retain) UIActivityIndicatorView *activityIndicator;

@end
