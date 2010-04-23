//
//  TWPieProgressView.h
//  TWToolkit
//
//  Created by Sam Soffes on 4/22/10.
//  Copyright 2010 Tasteful Works, Inc. All rights reserved.
//

@interface TWPieProgressView : UIView {

	CGFloat _progress;
	CGFloat _pieBorderWidth;
	UIColor *_pieBorderColor;
	UIColor *_pieFillColor;
	UIColor *_pieBackgroundColor;
	
@private
	
	BOOL _hasDrawn;
}

@property (nonatomic, assign) CGFloat progress;
@property (nonatomic, assign) CGFloat pieBorderWidth;
@property (nonatomic, retain) UIColor *pieBorderColor;
@property (nonatomic, retain) UIColor *pieFillColor;
@property (nonatomic, retain) UIColor *pieBackgroundColor;

@end
