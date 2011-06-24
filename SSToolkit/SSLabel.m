//
//  SSLabel.m
//  SSToolkit
//
//  Created by Sam Soffes on 7/12/10.
//  Copyright 2010-2011 Sam Soffes. All rights reserved.
//

#import "SSLabel.h"

@implementation SSLabel

#pragma mark -
#pragma mark Accessors

@synthesize verticalTextAlignment = _verticalTextAlignment;

- (void)setVerticalTextAlignment:(SSLabelVerticalTextAlignment)verticalTextAlignment {
	_verticalTextAlignment = verticalTextAlignment;

	[self setNeedsLayout];
}


@synthesize textEdgeInsets = _textEdgeInsets;

- (void)setTextEdgeInsets:(UIEdgeInsets)textEdgeInsets {
	_textEdgeInsets = textEdgeInsets;
	
	[self setNeedsLayout];
}


#pragma mark -
#pragma mark UIView

- (id)initWithFrame:(CGRect)aFrame {
	if ((self = [super initWithFrame:aFrame])) {
		self.verticalTextAlignment = SSLabelVerticalTextAlignmentMiddle;
		self.textEdgeInsets = UIEdgeInsetsZero;
	}
	return self;
}


#pragma mark -
#pragma mark UILabel

- (void)drawTextInRect:(CGRect)rect {
	rect = UIEdgeInsetsInsetRect(rect, _textEdgeInsets);
	
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
