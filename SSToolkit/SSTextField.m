//
//  SSTextField.m
//  SSToolkit
//
//  Created by Sam Soffes on 3/11/10.
//  Copyright 2010-2011 Sam Soffes. All rights reserved.
//

#import "SSTextField.h"
#import "SSDrawingUtilities.h"

@implementation SSTextField

@synthesize textEdgeInsets = _textEdgeInsets;
@synthesize clearButtonEdgeInsets = _clearButtonEdgeInsets;

#pragma mark UIView

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        _textEdgeInsets = UIEdgeInsetsZero;
		_clearButtonEdgeInsets = UIEdgeInsetsZero;
    }
    return self;
}


#pragma mark UITextField

- (CGRect)textRectForBounds:(CGRect)bounds {
	return UIEdgeInsetsInsetRect([super textRectForBounds:bounds], _textEdgeInsets);
}


- (CGRect)editingRectForBounds:(CGRect)bounds {
	return [self textRectForBounds:bounds];
}


- (CGRect)clearButtonRectForBounds:(CGRect)bounds {
	CGRect rect = [super clearButtonRectForBounds:bounds];
	rect = CGRectSetY(rect, rect.origin.y + _clearButtonEdgeInsets.top);
	return CGRectSetX(rect, rect.origin.x + _clearButtonEdgeInsets.right);
}

@end
