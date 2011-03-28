//
//  SSLabel.m
//  SSToolkit
//
//  Created by Sam Soffes on 7/12/10.
//  Copyright 2010-2011 Sam Soffes. All rights reserved.
//

#import "SSLabel.h"

@implementation SSLabel

@synthesize verticalTextAlignment = _verticalTextAlignment;
@synthesize textEdgeInsets = _textEdgeInsets;

#pragma mark NSObject

- (void)dealloc {
    if ([self observationInfo] != nil) {
        [self removeObserver:self forKeyPath:@"verticalTextAlignment"];
        [self removeObserver:self forKeyPath:@"textEdgeInsets"];
    }
	[super dealloc];
}


#pragma mark UIView

- (id)initWithFrame:(CGRect)aFrame {
	if ((self = [super initWithFrame:aFrame])) {
		self.verticalTextAlignment = SSLabelVerticalTextAlignmentMiddle;
		self.textEdgeInsets = UIEdgeInsetsZero;
		
		[self addObserver:self forKeyPath:@"verticalTextAlignment" options:NSKeyValueObservingOptionNew context:nil];
		[self addObserver:self forKeyPath:@"textEdgeInsets" options:NSKeyValueObservingOptionNew context:nil];
	}
	return self;
}


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
