//
//  TWRoundedView.h
//  TWToolkit
//
//	Inspired by http://softwaremaven.innerbrane.com/2009/05/rounding-corners-on-uiview.html
//	This is still buggy and not working the way it is intended to work.
//
//  Created by Sam Soffes on 9/18/09.
//  Copyright 2009 Tasteful Works, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TWRoundedView : UIView {

	NSInteger radius;
    UIColor *cornerColor;
    BOOL roundUpperLeft;
	BOOL roundUpperRight;
	BOOL roundLowerLeft;
	BOOL roundLowerRight;
}

@property (nonatomic,retain) UIColor *cornerColor;
@property (nonatomic, assign) NSInteger radius;
@property (nonatomic, assign) BOOL roundUpperLeft;
@property (nonatomic, assign) BOOL roundUpperRight;
@property (nonatomic, assign) BOOL roundLowerLeft;
@property (nonatomic, assign) BOOL roundLowerRight;

@end
