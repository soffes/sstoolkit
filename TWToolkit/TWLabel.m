//
//  TWLabel.m
//  TWToolkit
//
//  Created by Sam Soffes on 7/12/10.
//  Copyright 2010 Tasteful Works, Inc. All rights reserved.
//

#import "TWLabel.h"

@implementation TWLabel

@synthesize verticalTextAlignment = _verticalTextAlignment;
@synthesize textInsets = _textInsets;

#pragma mark UIView

- (id)initWithFrame:(CGRect)aFrame {
	if ((self = [super initWithFrame:aFrame])) {
		self.verticalTextAlignment = TWLabelVerticalTextAlignmentTop;
		self.textInsets = UIEdgeInsetsZero;
	}
	return self;
}

#pragma mark UILabel

- (void)drawTextInRect:(CGRect)rect {
	rect = UIEdgeInsetsInsetRect(rect, self.textInsets);
	
	if (self.verticalTextAlignment == TWLabelVerticalTextAlignmentTop) {
		CGSize sizeThatFits = [self sizeThatFits:rect.size];
		rect = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, sizeThatFits.height);
	} else if (self.verticalTextAlignment == TWLabelVerticalTextAlignmentBottom) {
		CGSize sizeThatFits = [self sizeThatFits:rect.size];
		rect = CGRectMake(rect.origin.x, rect.origin.y + (rect.size.height - sizeThatFits.height), rect.size.width, sizeThatFits.height);
	}
		
	[super drawTextInRect:rect];
}

@end
