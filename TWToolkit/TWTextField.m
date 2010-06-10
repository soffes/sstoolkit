//
//  TWTextField.m
//  TWToolkit
//
//  Created by Sam Soffes on 3/11/10.
//  Copyright 2010 Tasteful Works, Inc. All rights reserved.
//

#import "TWTextField.h"

@implementation TWTextField

@synthesize textInset = _textInset;

#pragma mark UIView

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        self.textInset = UIEdgeInsetsZero;
    }
    return self;
}

#pragma mark UITextField

- (CGRect)textRectForBounds:(CGRect)bounds {
	return UIEdgeInsetsInsetRect(bounds, self.textInset);
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
	return [self textRectForBounds:bounds];
}

@end
