//
//  TWStripView.h
//  TWToolkit
//
//  Created by Sam Soffes on 8/18/08.
//  Copyright 2009 Tasteful Works, Inc. All rights reserved.
//

typedef enum {
	TWStripViewStyleCustom,
    TWStripViewStyleLight = 1,
    TWStripViewStyleDark = 2,
	TWStripViewStyleBlue = 3,
	TWStripViewStyleDefault = TWStripViewStyleBlue
} TWStripViewStyle;

@interface TWStripView : UIView {

	CGGradientRef gradient;
	CGContextRef context;

	UIColor *borderColor;
	UIColor *startColor;
	UIColor *endColor;
	NSInteger borderHeight;
	TWStripViewStyle style;

	NSDictionary *styles;
}

@property (nonatomic, retain) UIColor *borderColor;
@property (nonatomic, retain) UIColor *startColor;
@property (nonatomic, retain) UIColor *endColor;
@property (nonatomic) NSInteger borderHeight;
@property (nonatomic) TWStripViewStyle style;

- (void)setStyle:(TWStripViewStyle)aStyle;

// You must call this after setting the start and end color. This is done
// manually for performance reasons. I guess it doesn't matter that much.
// If you don't like it, change it. :)
- (void)refreshBackground;

@end
