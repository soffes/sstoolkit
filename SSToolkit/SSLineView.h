//
//  SSLineView.h
//  SSToolkit
//
//  Created by Sam Soffes on 4/12/10.
//  Copyright 2010 Sam Soffes, Inc. All rights reserved.
//

@interface SSLineView : UIView {

	UIColor *_lineColor;
	UIColor *_insetColor;
	BOOL _showInset;
	
@private
	
	BOOL _hasDrawn;
}

@property (nonatomic, retain) UIColor *lineColor;
@property (nonatomic, retain) UIColor *insetColor;
@property (nonatomic, assign) BOOL showInset;

@end
