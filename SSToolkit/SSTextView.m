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
@synthesize placeholderColor = _placeholderColor;

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
		[_placeholderColor set];
		[_placeholder drawInRect:CGRectMake(8.0f, 8.0f, self.frame.size.width - 16.0f, self.frame.size.height - 16.0f) withFont:self.font];
	}
}


#pragma mark - Private

- (void)_initialize {
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_textChanged:) name:UITextViewTextDidChangeNotification object:self];
	
	self.placeholderColor = [UIColor colorWithWhite:0.702f alpha:1.0f];
	_shouldDrawPlaceholder = NO;
}


- (void)_updateShouldDrawPlaceholder {
	BOOL prev = _shouldDrawPlaceholder;
	_shouldDrawPlaceholder = self.placeholder && self.placeholderColor && self.text.length == 0;
	
	if (prev != _shouldDrawPlaceholder) {
		[self setNeedsDisplay];
	}
}


- (void)_textChanged:(NSNotification *)notificaiton {
	[self _updateShouldDrawPlaceholder];	
}

@end
