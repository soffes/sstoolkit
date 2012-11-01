//
//  SSTextView.m
//  SSToolkit
//
//  Created by Sam Soffes on 8/18/10.
//  Copyright 2010-2011 Sam Soffes. All rights reserved.
//

#import "SSTextView.h"

@interface SSTextView ()
- (void)_initialize;
- (void)_updateShouldDrawPlaceholder;
- (void)_textChanged:(NSNotification *)notification;
@end


@implementation SSTextView {
	BOOL _shouldDrawPlaceholder;
}


#pragma mark - Accessors

@synthesize placeholder = _placeholder;
@synthesize placeholderTextColor = _placeholderTextColor;

- (void)setText:(NSString *)string {
	[super setText:string];
	[self _updateShouldDrawPlaceholder];
}


- (void)setPlaceholder:(NSString *)string {
	if ([string isEqual:_placeholder]) {
		return;
	}
	
	_placeholder = string;
	[self _updateShouldDrawPlaceholder];
}


- (void)setContentInset:(UIEdgeInsets)contentInset {
	[super setContentInset:contentInset];
	[self _updateShouldDrawPlaceholder];
}


- (void)setFont:(UIFont *)font {
	[super setFont:font];
	[self _updateShouldDrawPlaceholder];
}


- (void)setTextAlignment:(NSTextAlignment)textAlignment {
	[super setTextAlignment:textAlignment];
	[self _updateShouldDrawPlaceholder];
}


#pragma mark - NSObject

- (void)dealloc {
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:self];
}


#pragma mark - UIView

- (id)initWithCoder:(NSCoder *)aDecoder {
	if ((self = [super initWithCoder:aDecoder])) {
		[self _initialize];
	}
	return self;
}


- (id)initWithFrame:(CGRect)frame {
	if ((self = [super initWithFrame:frame])) {
		[self _initialize];
	}
	return self;
}


- (void)drawRect:(CGRect)rect {
	[super drawRect:rect];

	if (_shouldDrawPlaceholder) {
		// Inset the rect
		rect = UIEdgeInsetsInsetRect(rect, self.contentInset);

		// TODO: This is hacky. Not sure why 8 is the magic number
		if (self.contentInset.left == 0.0f) {
			rect.origin.x += 8.0f;
		}
		rect.origin.y += 8.0f;

		// Draw the text
		[_placeholderTextColor set];
		[_placeholder drawInRect:rect withFont:self.font lineBreakMode:UILineBreakModeTailTruncation alignment:self.textAlignment];
	}
}


#pragma mark - Private

- (void)_initialize {
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_textChanged:) name:UITextViewTextDidChangeNotification object:self];
	
	self.placeholderTextColor = [UIColor colorWithWhite:0.702f alpha:1.0f];
	_shouldDrawPlaceholder = NO;
}


- (void)_updateShouldDrawPlaceholder {
	BOOL previous = _shouldDrawPlaceholder;
	_shouldDrawPlaceholder = self.placeholder && self.placeholderTextColor && self.text.length == 0;
	
	if (previous != _shouldDrawPlaceholder) {
		[self setNeedsDisplay];
	}
}


- (void)_textChanged:(NSNotification *)notification {
	[self _updateShouldDrawPlaceholder];	
}

@end
