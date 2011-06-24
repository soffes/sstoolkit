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

@implementation SSLoadingView

#pragma mark -
#pragma mark Accessors

@synthesize activityIndicatorView = _activityIndicatorView;

@synthesize text = _text;

- (void)setText:(NSString *)text {
	[_text release];
	_text = [text copy];
	
	[self setNeedsDisplay];
}


@synthesize font = _font;

- (void)setFont:(UIFont *)font {
	[_font release];
	_font = [font retain];
	
	[self setNeedsDisplay];
}


@synthesize textColor = _textColor;

- (void)setTextColor:(UIColor *)textColor {
	[_textColor release];
	_textColor = [textColor retain];
	
	[self setNeedsDisplay];
}


@synthesize shadowColor = _shadowColor;

- (void)setShadowColor:(UIColor *)shadowColor {
	[_shadowColor release];
	_shadowColor = [shadowColor retain];
	
	[self setNeedsDisplay];
}


@synthesize shadowOffset = _shadowOffset;

- (void)setShadowOffset:(CGSize)shadowOffset {
	_shadowOffset = shadowOffset;
	
	[self setNeedsDisplay];
}


#pragma mark -
#pragma mark NSObject

- (void)dealloc {	
	[_font release];
	[_text release];
	[_textColor release];
	[_shadowColor release];
	[_activityIndicatorView release];
	[super dealloc];
}


#pragma mark -
#pragma mark UIView

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        
		// View defaults
		self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		self.backgroundColor = [UIColor whiteColor];
		self.opaque = YES;
		self.contentMode = UIViewContentModeRedraw;
		
		// Setup the indicator
		_activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
		_activityIndicatorView.hidesWhenStopped = NO;
		[_activityIndicatorView startAnimating];
		[self addSubview:_activityIndicatorView];
		
		// Defaults
		self.text = @"Loading...";
		self.font = [UIFont systemFontOfSize:16.0f];
		self.textColor = [UIColor darkGrayColor];
		self.shadowColor = [UIColor whiteColor];
		_shadowOffset = CGSizeMake(0.0f, 1.0f);
   }
    return self;
}


- (void)drawRect:(CGRect)rect {
	
	CGRect frame = self.frame;
	
	// Calculate sizes
	CGSize maxSize = CGSizeMake(frame.size.width - (interiorPadding * 2.0f) - indicatorSize - indicatorRightMargin, indicatorSize);
	CGSize textSize = [_text sizeWithFont:_font constrainedToSize:maxSize lineBreakMode:UILineBreakModeWordWrap];
	
	// Calculate position
	CGFloat totalWidth = textSize.width + indicatorSize + indicatorRightMargin;
	NSInteger y = (NSInteger)((frame.size.height / 2.0f) - (indicatorSize / 2.0f));
	
	// Position the indicator
	_activityIndicatorView.frame = CGRectMake((NSInteger)((frame.size.width - totalWidth) / 2.0f), y, indicatorSize, indicatorSize);
	
	// Calculate text position
	CGRect textRect = CGRectMake(_activityIndicatorView.frame.origin.x + indicatorSize + indicatorRightMargin, y, textSize.width, textSize.height);
	
	// Draw shadow
	if (_shadowColor) {
		[_shadowColor set];
		CGRect shadowRect = CGRectMake(textRect.origin.x + _shadowOffset.width, textRect.origin.y + _shadowOffset.height, textRect.size.width, textRect.size.height);
		[_text drawInRect:shadowRect withFont:_font lineBreakMode:UILineBreakModeTailTruncation alignment:UITextAlignmentLeft];	
	}
	
	// Draw text
	[_textColor set];
	[_text drawInRect:textRect withFont:_font lineBreakMode:UILineBreakModeTailTruncation alignment:UITextAlignmentLeft];
}

@end
