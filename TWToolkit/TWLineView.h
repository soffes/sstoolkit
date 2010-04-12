//
//  TWLineView.h
//  TWToolkit
//
//  Created by Sam Soffes on 4/12/10.
//  Copyright 2010 Tasteful Works, Inc. All rights reserved.
//

@interface TWLineView : UIView {

	UIColor *_lineColor;
	CGFloat _insetAlpha;
	
	@private
	
	BOOL _hasDrawn;
}

@property (nonatomic, retain) UIColor *lineColor;
@property (nonatomic, assign) CGFloat insetAlpha;

@end
