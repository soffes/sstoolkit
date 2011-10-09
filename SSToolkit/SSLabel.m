//
//  SSLabel.m
//  SSToolkit
//
//  Created by Sam Soffes on 7/12/10.
//  Copyright 2010-2011 Sam Soffes. All rights reserved.
//

#import "SSLabel.h"

@interface SSLabel ()
- (void)_initialize;
@end

@implementation SSLabel

#pragma mark - Accessors

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


#pragma mark - UIView

- (id)initWithCoder:(NSCoder *)aDecoder {
	if ((self = [super initWithCoder:aDecoder])) {
		[self _initialize];
	}
	return self;
}


- (id)initWithFrame:(CGRect)aFrame {
	if ((self = [super initWithFrame:aFrame])) {
		[self _initialize];
	}
	return self;
}


#pragma mark - UILabel

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


#pragma mark - Private

- (void)_initialize {
	self.verticalTextAlignment = SSLabelVerticalTextAlignmentMiddle;
	self.textEdgeInsets = UIEdgeInsetsZero;
}

@end
