//
//  SSLoadingView.m
//  SSToolkit
//
//  Created by Sam Soffes on 7/8/09.
//  Copyright 2009-2011 Sam Soffes. All rights reserved.
//

#import "SSLoadingView.h"

static CGFloat interiorPadding = 20.0f;
static CGFloat indicatorSize = 20.0f;
static CGFloat indicatorRightMargin = 8.0f;

@interface SSLoadingView ()
- (void)_initialize;
@end

@implementation SSLoadingView

#pragma mark - Accessors

@synthesize textLabel = _textLabel;
@synthesize activityIndicatorView = _activityIndicatorView;


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
	
	CGRect frame = self.frame;
	
	// Calculate sizes
	CGSize maxSize = CGSizeMake(frame.size.width - (interiorPadding * 2.0f) - indicatorSize - indicatorRightMargin,
								indicatorSize);
	
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_6_0
	CGSize textSize = [_textLabel.text sizeWithFont:_textLabel.font constrainedToSize:maxSize
									  lineBreakMode:NSLineBreakByWordWrapping];
#else
	CGSize textSize = [_textLabel.text sizeWithFont:_textLabel.font constrainedToSize:maxSize
									  lineBreakMode:UILineBreakModeWordWrap];
#endif
	
	// Calculate position
	CGFloat totalWidth = textSize.width + indicatorSize + indicatorRightMargin;
	NSInteger y = (NSInteger)((frame.size.height / 2.0f) - (indicatorSize / 2.0f));
	
	// Position the indicator
	_activityIndicatorView.frame = CGRectMake((NSInteger)((frame.size.width - totalWidth) / 2.0f), y, indicatorSize,
											  indicatorSize);
	
	// Calculate text position
	CGRect textRect = CGRectMake(_activityIndicatorView.frame.origin.x + indicatorSize + indicatorRightMargin, y,
								 textSize.width, textSize.height);
	
	// Draw text
	[_textLabel drawTextInRect:textRect];
}


#pragma mark - Private

- (void)_initialize {
	// View defaults
	self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	self.backgroundColor = [UIColor whiteColor];
	self.opaque = YES;
	self.contentMode = UIViewContentModeRedraw;
	
	// Setup label
	_textLabel = [[UILabel alloc] initWithFrame:CGRectZero];
	
	// Setup the indicator
	_activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
	_activityIndicatorView.hidesWhenStopped = NO;
	[_activityIndicatorView startAnimating];
	[self addSubview:_activityIndicatorView];
	
	// Defaults
	_textLabel.text = @"Loading...";
	_textLabel.font = [UIFont systemFontOfSize:16.0f];
	_textLabel.textColor = [UIColor darkGrayColor];
	_textLabel.shadowColor = [UIColor whiteColor];
	_textLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
}

@end
