//
//  SSIndicatorLabel.m
//  SSToolkit
//
//  Created by Sam Soffes on 7/13/10.
//  Copyright 2010 Sam Soffes, Inc. All rights reserved.
//

#import "SSIndicatorLabel.h"

@implementation SSIndicatorLabel

@synthesize label = _label;
@synthesize indicator = _indicator;
@synthesize loading = _loading;

#pragma mark Class Methods

+ (CGSize)indicatorSize {
	return CGSizeMake(20.0, 20.0);
}


+ (CGFloat)padding {
	return 6.0;
}

#pragma mark NSObject

- (void)dealloc {
	[_label release];
	[_indicator release]; 
	[super dealloc];
}

#pragma mark UIView

- (id)initWithFrame:(CGRect)rect {
	if ((self = [super initWithFrame:rect])) {
		self.clipsToBounds = YES;
		
		_label = [[UILabel alloc] initWithFrame:CGRectZero];
		[self addSubview:_label];
		
		_indicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectZero];
		[_indicator startAnimating];
		[self addSubview:_indicator];
		
		_loading = NO;
		[self layoutSubviews];
	}
	return self;
}


- (void)layoutSubviews {
	CGRect rect = self.frame;
	CGSize size = [[self class] indicatorSize];
	CGFloat x = size.width + [[self class] padding];
	
	// Loading
	if (_loading) {
		_label.frame = CGRectMake(x, 0.0, rect.size.width - x, size.height);
		_indicator.frame = CGRectMake(0.0, 0.0, size.width, size.height);
	}
	
	// Not loading
	else {
		_label.frame = CGRectMake(0.0, 0.0, rect.size.width, size.height);
		_indicator.frame = CGRectMake(-x, 0.0, size.width, size.height);
	}
}


- (void)setBackgroundColor:(UIColor *)color {
	[super setBackgroundColor:color];
	_label.backgroundColor = color;
	_indicator.backgroundColor = color;
}


- (void)setOpaque:(BOOL)o {
	[super setOpaque:o];
	_label.opaque = o;
	_indicator.opaque = o;
}

#pragma mark Status

- (void)startWithText:(NSString *)text {
	self.loading = YES;
	_label.text = text;
}

- (void)completeWithText:(NSString *)text {
	self.loading = NO;
	_label.text = text;
}

#pragma mark Custom Setters

- (void)setLoading:(BOOL)l {
	if (_loading == l) {
		return;
	}
	
	[UIView beginAnimations:@"loading" context:nil];
	_loading = l;
	[self layoutSubviews];
	[UIView commitAnimations];
}

@end
