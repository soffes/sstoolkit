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

@synthesize activityIndicatorView = _activityIndicatorView;
@synthesize text = _text;
@synthesize font = _font;
@synthesize textColor = _textColor;
@synthesize shadowColor = _shadowColor;
@synthesize shadowOffset = _shadowOffset;

#pragma mark NSObject

- (void)dealloc {
	[self removeObserver:self forKeyPath:@"text"];
	[self removeObserver:self forKeyPath:@"font"];
	[self removeObserver:self forKeyPath:@"textColor"];
	[self removeObserver:self forKeyPath:@"shadowColor"];
	[self removeObserver:self forKeyPath:@"shadowOffset"];
	
	self.font = nil;
	self.text = nil;
	self.textColor = nil;
	self.shadowColor = nil;
	[_activityIndicatorView release];
	[super dealloc];
}


#pragma mark UIView

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        
		// View defaults
		self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		self.backgroundColor = [UIColor whiteColor];
		self.opaque = YES;
		
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
		
		// Add observers
		[self addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:nil];
		[self addObserver:self forKeyPath:@"font" options:NSKeyValueObservingOptionNew context:nil];
		[self addObserver:self forKeyPath:@"textColor" options:NSKeyValueObservingOptionNew context:nil];
		[self addObserver:self forKeyPath:@"shadowColor" options:NSKeyValueObservingOptionNew context:nil];
		[self addObserver:self forKeyPath:@"shadowOffset" options:NSKeyValueObservingOptionNew context:nil];
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


#pragma mark NSKeyValueObserving

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {	
	
	// Redraw if colors or borders changed
	if ([keyPath isEqualToString:@"text"] || [keyPath isEqualToString:@"font"] || 
		[keyPath isEqualToString:@"textColor"] || [keyPath isEqualToString:@"shadowColor"]) {
		[self setNeedsDisplay];
		return;
	}
	
	[super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
}

@end
