//
//  TWLineView.h
//  TWToolkit
//
//  Created by Sam Soffes on 4/12/10.
//  Copyright 2010 Tasteful Works, Inc. All rights reserved.
//

@interface TWLineView : UIView {

	UIColor *_lineColor;
	UIColor *_insetColor;
	
	@private
	
	BOOL _hasDrawn;
}

@property (nonatomic, retain) UIColor *lineColor;
@property (nonatomic, retain) UIColor *insetColor;
@property (nonatomic, assign) CGFloat insetAlpha;

@end
