//
//  SSPieProgressView.h
//  SSToolkit
//
//  Created by Sam Soffes on 4/22/10.
//  Copyright 2009-2010 Sam Soffes. All rights reserved.
//

@interface SSPieProgressView : UIView {

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
