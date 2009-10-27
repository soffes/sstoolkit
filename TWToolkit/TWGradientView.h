//
//  TWGradientView.h
//  TWToolkit
//
//  Created by Sam Soffes on 10/27/09.
//  Copyright 2009 Tasteful Works, Inc. All rights reserved.
//
//	Greatly inspired by BWGradientBox. http://brandonwalkin.com/bwtoolkit
//

#import <UIKit/UIKit.h>

@interface TWGradientView : UIView {
	
	UIColor *topColor;
	UIColor *bottomColor;
	UIColor *topBorderColor;
	UIColor *bottomBorderColor;
	CGFloat topInsetAlpha;
	CGFloat bottomInsetAlpha;	
	BOOL hasTopBorder;
	BOOL hasBottomBorder;
	
	CGGradientRef gradient;
}

@property (nonatomic, retain) UIColor *topColor;
@property (nonatomic, retain) UIColor *bottomColor;
@property (nonatomic, retain) UIColor *topBorderColor;
@property (nonatomic, retain) UIColor *bottomBorderColor;
@property (nonatomic, assign) CGFloat topInsetAlpha;
@property (nonatomic, assign) CGFloat bottomInsetAlpha;	
@property (nonatomic, assign) BOOL hasTopBorder;
@property (nonatomic, assign) BOOL hasBottomBorder;

@end
