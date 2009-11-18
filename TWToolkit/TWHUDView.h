//
//  TWHUDView.h
//  TWToolkit
//
//  Created by Sam Soffes on 9/29/09.
//  Copyright 2009 Tasteful Works, Inc. All rights reserved.
//

@interface TWHUDView : UIAlertView {
	
	UILabel *textLabel;
	UIActivityIndicatorView *activityIndicator;
}

@property (nonatomic, retain) UILabel *textLabel;
@property (nonatomic, retain) UIActivityIndicatorView *activityIndicator;

- (id)initWithTitle:(NSString *)aTitle loading:(BOOL)loading;
- (void)dismiss;
- (void)dismissAnimated:(BOOL)animated;

@end
