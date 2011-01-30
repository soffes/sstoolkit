//
//  SSBadgeView.m
//  SSToolkit
//
//  Created by Sam Soffes on 1/29/11.
//  Copyright 2011 Sam Soffes. All rights reserved.
//

#import "SSBadgeView.h"
#import "SSDrawingMacros.h"

@interface SSBadgeView (PrivateMethod)
- (CGSize)_textSize;
@end

@implementation SSBadgeView

@synthesize text = _text;
@synthesize textColor = _textColor;
@synthesize highlightedTextColor = _highlightedTextColor;
@synthesize font = _font;
@synthesize badgeColor = _badgeColor;
@synthesize highlightedBadgeColor = _highlightedBadgeColor;
@synthesize cornerRadius = _cornerRadius;
@synthesize badgeAlignment = _badgeAlignment;
@synthesize highlighted = _highlighted;

#pragma mark NSObject

- (void)dealloc {
	[self removeObserver:self forKeyPath:@"text"];
	[self removeObserver:self forKeyPath:@"textColor"];
	[self removeObserver:self forKeyPath:@"highlightedTextColor"];
	[self removeObserver:self forKeyPath:@"font"];
	[self removeObserver:self forKeyPath:@"badgeColor"];
	[self removeObserver:self forKeyPath:@"highlightedBadgeColor"];
	[self removeObserver:self forKeyPath:@"cornerRadius"];
	[self removeObserver:self forKeyPath:@"badgeAlignment"];
	[self removeObserver:self forKeyPath:@"highlighted"];
		
	[_text release];
	[_textColor release];
	[_highlightedTextColor release];
	[_font release];
	[_badgeColor release];
	[_highlightedBadgeColor release];
	[super dealloc];
}


#pragma mark UIView

- (id)initWithFrame:(CGRect)rect {
	if ((self = [super initWithFrame:rect])) {
		self.backgroundColor = [UIColor whiteColor];
		self.opaque = YES;
		
		self.text = @"0";
		self.textColor = [UIColor whiteColor];
		self.highlightedTextColor = [UIColor colorWithRed:0.125f green:0.369f blue:0.871f alpha:1.0f];
		self.font = [UIFont boldSystemFontOfSize:16.0f];
		self.badgeColor = [UIColor colorWithRed:0.541f green:0.596f blue:0.694f alpha:1.0f];
		self.highlightedBadgeColor = [UIColor whiteColor];
		self.cornerRadius = 10.0f;
		self.badgeAlignment = SSBadgeViewAlignmentCenter;
		self.highlighted = NO;
		
		_hasDrawn = NO;
	}
	return self;
}


- (void)drawRect:(CGRect)rect {
	if (!_hasDrawn) {
		[self addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:nil];
		[self addObserver:self forKeyPath:@"textColor" options:NSKeyValueObservingOptionNew context:nil];
		[self addObserver:self forKeyPath:@"highlightedTextColor" options:NSKeyValueObservingOptionNew context:nil];
		[self addObserver:self forKeyPath:@"font" options:NSKeyValueObservingOptionNew context:nil];
		[self addObserver:self forKeyPath:@"badgeColor" options:NSKeyValueObservingOptionNew context:nil];
		[self addObserver:self forKeyPath:@"highlightedBadgeColor" options:NSKeyValueObservingOptionNew context:nil];
		[self addObserver:self forKeyPath:@"cornerRadius" options:NSKeyValueObservingOptionNew context:nil];
		[self addObserver:self forKeyPath:@"badgeAlignment" options:NSKeyValueObservingOptionNew context:nil];
		[self addObserver:self forKeyPath:@"highlighted" options:NSKeyValueObservingOptionNew context:nil];
		
		_hasDrawn = YES;
	}
	
	UIColor *aTextColor = nil;
	if (_highlighted) {
		[_highlightedBadgeColor set];
		aTextColor = _highlightedTextColor;
	} else {
		[_badgeColor set];
		aTextColor = _textColor;
	}
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	// Badge
	CGSize size = self.frame.size;
	CGSize badgeSize = [self sizeThatFits:size];
	badgeSize.height = fminf(badgeSize.height, size.height);
	
	CGFloat x = 0.0f;
	if (_badgeAlignment == SSBadgeViewAlignmentCenter) {
		x = roundf((size.width - badgeSize.width) / 2.0f);
	} else if (_badgeAlignment == SSBadgeViewAlignmentRight) {
		x = size.width - badgeSize.width;
	}
	
	CGRect badgeRect = CGRectMake(x, roundf((size.height - badgeSize.height) / 2.0f), badgeSize.width, badgeSize.height);
	SSDrawRoundedRect(context, badgeRect, _cornerRadius);
	
	// Text
	[aTextColor set];
	CGSize textSize = [self _textSize];
	CGRect textRect = CGRectMake(badgeRect.origin.x + roundf((badgeSize.width - textSize.width) / 2.0f), badgeRect.origin.y, textSize.width, badgeSize.height);
	[_text drawInRect:textRect withFont:_font];
}


- (CGSize)sizeThatFits:(CGSize)size {
	CGSize textSize = [self _textSize];
	return CGSizeMake(fmaxf(textSize.width + 12.0f, 30.0f), textSize.height + 8.0f);
}


#pragma mark Private Methods

- (CGSize)_textSize {
	return [_text sizeWithFont:_font];
}


#pragma mark NSKeyValueObserving

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
	// Redraw if something we care about changed	
	if ([keyPath isEqual:@"text"] || [keyPath isEqual:@"textColor"] || [keyPath isEqual:@"highlightedTextColor"] ||
		[keyPath isEqual:@"font"] || [keyPath isEqual:@"badgeColor"] || [keyPath isEqual:@"highlightedBadgeColor"] ||
		[keyPath isEqual:@"cornerRadius"] || [keyPath isEqual:@"badgeAlignment"] || [keyPath isEqual:@"highlighted"]) {
		[self setNeedsDisplay];
		return;
	}
	
	[super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
}


@end
