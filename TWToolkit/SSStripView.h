//
//  SSStripView.h
//  Four80
//
//  Created by Sam Soffes on 8/18/08.
//  Copyright 2008 Sam Soffes. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
	SSStripViewStyleCustom,
    SSStripViewStyleLight = 1,
    SSStripViewStyleDark = 2,
	SSStripViewStyleBlue = 3,
	SSStripViewStyleDefault = SSStripViewStyleBlue
} SSStripViewStyle;

@interface SSStripView : UIView {

	CGGradientRef gradient;
	CGContextRef context;

	UIColor *borderColor;
	UIColor *startColor;
	UIColor *endColor;
	NSInteger borderHeight;
	SSStripViewStyle style;

	NSDictionary *styles;
}

@property (nonatomic, retain) UIColor *borderColor;
@property (nonatomic, retain) UIColor *startColor;
@property (nonatomic, retain) UIColor *endColor;
@property (nonatomic) NSInteger borderHeight;
@property (nonatomic) SSStripViewStyle style;

- (void)setStyle:(SSStripViewStyle)aStyle;

// You must call this after setting the start and end color. This is done
// manually for performance reasons. I guess it doesn't matter that much.
// If you don't like it, change it. :)
- (void)refreshBackground;

@end
