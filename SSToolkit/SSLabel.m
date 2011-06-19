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
@synthesize textEdgeInsets = _textEdgeInsets;

#pragma mark -
#pragma mark UIView

- (id)initWithFrame:(CGRect)aFrame {
	if ((self = [super initWithFrame:aFrame])) {
		self.verticalTextAlignment = SSLabelVerticalTextAlignmentMiddle;
		self.textEdgeInsets = UIEdgeInsetsZero;
	}
	return self;
}


- (void)willMoveToSuperview:(UIView *)newSuperview {
	[super willMoveToSuperview:newSuperview];
	if (newSuperview && ![self observationInfo]) {
		[self addObserver:self forKeyPath:@"verticalTextAlignment" options:NSKeyValueObservingOptionNew context:nil];
		[self addObserver:self forKeyPath:@"textEdgeInsets" options:NSKeyValueObservingOptionNew context:nil];
		return;
	}
	
	if (!newSuperview && [self observationInfo]) {
		[self removeObserver:self forKeyPath:@"verticalTextAlignment"];
        [self removeObserver:self forKeyPath:@"textEdgeInsets"];
	}	
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


#pragma mark -
#pragma mark NSKeyValueObserving

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
	// Relayout when properties change
	if ([keyPath isEqualToString:@"verticalTextAlignment"] || [keyPath isEqualToString:@"textEdgeInsets"]) {
		[self setNeedsLayout];
		return;
	}
	
	[super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
}

@end
