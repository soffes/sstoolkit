//
//  SSLabel.m
//  SSToolkit
//
//  Created by Sam Soffes on 7/12/10.
//  Copyright 2009-2010 Sam Soffes. All rights reserved.
//

#import "SSLabel.h"

@implementation SSLabel

@synthesize verticalTextAlignment = _verticalTextAlignment;
@synthesize textInsets = _textInsets;

#pragma mark UIView

- (id)initWithFrame:(CGRect)aFrame {
	if ((self = [super initWithFrame:aFrame])) {
		self.verticalTextAlignment = SSLabelVerticalTextAlignmentMiddle;
		self.textInsets = UIEdgeInsetsZero;
	}
	return self;
}

#pragma mark UILabel

- (void)drawTextInRect:(CGRect)rect {
	rect = UIEdgeInsetsInsetRect(rect, self.textInsets);
	
	if (self.verticalTextAlignment == SSLabelVerticalTextAlignmentTop) {
		CGSize sizeThatFits = [self sizeThatFits:rect.size];
		rect = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, sizeThatFits.height);
	} else if (self.verticalTextAlignment == SSLabelVerticalTextAlignmentBottom) {
		CGSize sizeThatFits = [self sizeThatFits:rect.size];
		rect = CGRectMake(rect.origin.x, rect.origin.y + (rect.size.height - sizeThatFits.height), rect.size.width, sizeThatFits.height);
	}
		
	[super drawTextInRect:rect];
}

@end
