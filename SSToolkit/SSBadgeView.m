//
//  SSBadgeView.m
//  SSToolkit
//
//  Created by Sam Soffes on 1/29/11.
//  Copyright 2011 Sam Soffes. All rights reserved.
//

#import "SSBadgeView.h"
#import "SSLabel.h"
#import "SSDrawingUtilities.h"

@implementation SSBadgeView

#pragma mark -
#pragma mark Accessors

@synthesize textLabel = _textLabel;
@synthesize badgeColor = _badgeColor;
@synthesize highlightedBadgeColor = _highlightedBadgeColor;
@synthesize badgeImage = _badgeImage;
@synthesize highlightedBadgeImage = _highlightedBadgeImage;
@synthesize cornerRadius = _cornerRadius;
@synthesize badgeAlignment = _badgeAlignment;
@synthesize highlighted = _highlighted;

#pragma mark -
#pragma mark Class Methods

+ (UIColor *)defaultBadgeColor {
	return [UIColor colorWithRed:0.541f green:0.596f blue:0.694f alpha:1.0f];
}


#pragma mark -
#pragma mark NSObject

- (void)dealloc {
	[_textLabel release];
	[_badgeColor release];
	[_highlightedBadgeColor release];
	[_badgeImage release];
	[_highlightedBadgeImage release];
	[super dealloc];
}


#pragma mark -
#pragma mark UIView

- (id)initWithFrame:(CGRect)rect {
	if ((self = [super initWithFrame:rect])) {
		self.backgroundColor = [UIColor whiteColor];
		self.opaque = YES;
		
		_textLabel = [[SSLabel alloc] initWithFrame:CGRectZero];
		_textLabel.text = @"0";
		_textLabel.textColor = [UIColor whiteColor];
		_textLabel.highlightedTextColor = [UIColor colorWithRed:0.125f green:0.369f blue:0.871f alpha:1.0f];
		_textLabel.font = [UIFont boldSystemFontOfSize:16.0f];
		_textLabel.textAlignment = UITextAlignmentCenter;
		
		self.badgeColor = [[self class] defaultBadgeColor];
		self.highlightedBadgeColor = [UIColor whiteColor];
		self.cornerRadius = 10.0f;
		self.badgeAlignment = SSBadgeViewAlignmentCenter;
		self.highlighted = NO;
	}
	return self;
}


- (void)drawRect:(CGRect)rect {
	UIColor *currentBadgeColor = nil;
	UIImage *currentBadgeImage = nil;
	
	if (_highlighted) {
		currentBadgeColor = _highlightedBadgeColor ? _highlightedBadgeColor : _badgeColor;
		currentBadgeImage = _highlightedBadgeImage ? _highlightedBadgeImage : _badgeImage;
	} else {
		currentBadgeColor = _badgeColor;
		currentBadgeImage = _badgeImage;
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
	
	// Draw image
	if (currentBadgeImage) {
		[currentBadgeImage drawInRect:badgeRect];
	}
	
	// Draw rectangle
	else if (currentBadgeColor) {
		[currentBadgeColor set];		
		SSDrawRoundedRect(context, badgeRect, _cornerRadius);
	}
	
	// Text
	[_textLabel drawTextInRect:badgeRect];
}


- (CGSize)sizeThatFits:(CGSize)size {
	CGSize textSize = [_textLabel sizeThatFits:self.bounds.size];
	return CGSizeMake(fmaxf(textSize.width + 12.0f, 30.0f), textSize.height + 8.0f);
}


- (void)willMoveToSuperview:(UIView *)newSuperview {
	[super willMoveToSuperview:newSuperview];
	
	if (newSuperview) {
		[_textLabel addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:nil];
		[self addObserver:self forKeyPath:@"badgeColor" options:0 context:nil];
		[self addObserver:self forKeyPath:@"highlightedBadgeColor" options:0 context:nil];
		[self addObserver:self forKeyPath:@"badgeImage" options:0 context:nil];
		[self addObserver:self forKeyPath:@"highlightedBadgeImage" options:0 context:nil];
		[self addObserver:self forKeyPath:@"cornerRadius" options:0 context:nil];
		[self addObserver:self forKeyPath:@"badgeAlignment" options:0 context:nil];
		[self addObserver:self forKeyPath:@"highlighted" options:0 context:nil];
		
		self.hidden = ([_textLabel.text length] == 0);
	} else {
		[_textLabel removeObserver:self forKeyPath:@"text"];
		[self removeObserver:self forKeyPath:@"badgeColor"];
		[self removeObserver:self forKeyPath:@"highlightedBadgeColor"];
		[self removeObserver:self forKeyPath:@"badgeImage"];
		[self removeObserver:self forKeyPath:@"highlightedBadgeImage"];
		[self removeObserver:self forKeyPath:@"cornerRadius"];
		[self removeObserver:self forKeyPath:@"badgeAlignment"];
		[self removeObserver:self forKeyPath:@"highlighted"];
	}
}


#pragma mark -
#pragma mark NSKeyValueObserving

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
	// Redraw if something we care about changed	
	if ([keyPath isEqualToString:@"badgeColor"] || [keyPath isEqualToString:@"highlightedBadgeColor"] ||
		[keyPath isEqualToString:@"badgeImage"] || [keyPath isEqualToString:@"highlightedBadgeImage"] ||
		[keyPath isEqualToString:@"cornerRadius"] || [keyPath isEqualToString:@"badgeAlignment"] ||
		[keyPath isEqualToString:@"highlighted"]) {
		[self setNeedsDisplay];
		return;
	}
	
	if (object == _textLabel && [keyPath isEqualToString:@"text"]) {
		NSString *text = [change objectForKey:NSKeyValueChangeNewKey];
		if ([text isEqual:[NSNull null]]) {
			text = nil;
		}
		self.hidden = ([text length] == 0);
		
		if (!self.hidden) {
			[self setNeedsDisplay];
		}
		return;
	}
	
	[super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
}

@end
