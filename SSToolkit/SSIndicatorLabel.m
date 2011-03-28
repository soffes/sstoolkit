//
//  SSIndicatorLabel.m
//  SSToolkit
//
//  Created by Sam Soffes on 7/13/10.
//  Copyright 2010-2011 Sam Soffes. All rights reserved.
//

#import "SSIndicatorLabel.h"

@interface SSIndicatorLabel (PrivateMethods)
+ (CGSize)indicatorSize;
+ (CGFloat)padding;
@end

@implementation SSIndicatorLabel

@synthesize textLabel = _textLabel;
@synthesize activityIndicatorView = _activityIndicatorView;
@synthesize loading = _loading;

#pragma mark Class Methods

+ (CGSize)indicatorSize {
	return CGSizeMake(20.0f, 20.0f);
}


+ (CGFloat)padding {
	return 6.0f;
}


#pragma mark NSObject

- (void)dealloc {
	[_textLabel release];
	[_activityIndicatorView release]; 
	[super dealloc];
}


#pragma mark UIView

- (id)initWithFrame:(CGRect)rect {
	if ((self = [super initWithFrame:rect])) {
		self.clipsToBounds = YES;
		
		_textLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		[self addSubview:_textLabel];
		
		_activityIndicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectZero];
		[_activityIndicatorView startAnimating];
		[self addSubview:_activityIndicatorView];
		
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
		_textLabel.frame = CGRectMake(x, 0.0f, rect.size.width - x, size.height);
		_activityIndicatorView.frame = CGRectMake(0.0f, 0.0f, size.width, size.height);
	}
	
	// Not loading
	else {
		_textLabel.frame = CGRectMake(0.0f, 0.0f, rect.size.width, size.height);
		_activityIndicatorView.frame = CGRectMake(-x, 0.0f, size.width, size.height);
	}
}


- (void)setBackgroundColor:(UIColor *)color {
	[super setBackgroundColor:color];
	_textLabel.backgroundColor = color;
	_activityIndicatorView.backgroundColor = color;
}


- (void)setOpaque:(BOOL)o {
	[super setOpaque:o];
	_textLabel.opaque = o;
	_activityIndicatorView.opaque = o;
}


#pragma mark Status

- (void)startWithText:(NSString *)text {
	self.loading = YES;
	_textLabel.text = text;
}

- (void)completeWithText:(NSString *)text {
	self.loading = NO;
	_textLabel.text = text;
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
