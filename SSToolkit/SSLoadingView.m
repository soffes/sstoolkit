//
//  SSLoadingView.m
//  SSToolkit
//
//  Created by Sam Soffes on 7/8/09.
//  Copyright 2009 Sam Soffes. All rights reserved.
//

#import "SSLoadingView.h"

static CGFloat interiorPadding = 20.0;
static CGFloat indicatorSize = 20.0;
static CGFloat indicatorRightMargin = 8.0;

@implementation SSLoadingView

@synthesize activityIndicator = _activityIndicator;
@synthesize text = _text;
@synthesize font = _font;
@synthesize textColor = _textColor;
@synthesize shadowColor = _shadowColor;

#pragma mark NSObject

- (void)dealloc {
	[self removeObserver:self forKeyPath:@"text"];
	[self removeObserver:self forKeyPath:@"font"];
	[self removeObserver:self forKeyPath:@"textColor"];
	[self removeObserver:self forKeyPath:@"shadowColor"];
	self.font = nil;
	self.text = nil;
	self.textColor = nil;
	self.shadowColor = nil;
	[_activityIndicator release];
	[super dealloc];
}

#pragma mark UIView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
		// View defaults
		self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		self.backgroundColor = [UIColor whiteColor];
		self.opaque = YES;
		
		// Setup the indicator
		_activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
		_activityIndicator.hidesWhenStopped = NO;
		[_activityIndicator startAnimating];
		[self addSubview:_activityIndicator];
		
		// Defaults
		self.text = @"Loading...";
		self.font = [UIFont systemFontOfSize:16.0];
		UIColor *aColor = [[UIColor alloc] initWithHue:0.613 saturation:0.3 brightness:0.42 alpha:1.0];
		self.textColor = aColor;
		[aColor release];
		self.shadowColor = [UIColor whiteColor];
		
		// Add observers
		[self addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:nil];
		[self addObserver:self forKeyPath:@"font" options:NSKeyValueObservingOptionNew context:nil];
		[self addObserver:self forKeyPath:@"textColor" options:NSKeyValueObservingOptionNew context:nil];
		[self addObserver:self forKeyPath:@"shadowColor" options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
	
	CGRect frame = self.frame;
	
	// Calculate sizes
	CGSize maxSize = CGSizeMake(frame.size.width - (interiorPadding * 2.0) - indicatorSize - indicatorRightMargin, indicatorSize);
	CGSize textSize = [_text sizeWithFont:_font constrainedToSize:maxSize lineBreakMode:UILineBreakModeWordWrap];
	
	// Calculate position
	CGFloat totalWidth = textSize.width + indicatorSize + indicatorRightMargin;
	NSInteger y = (NSInteger)((frame.size.height / 2.0) - (indicatorSize / 2.0));
	
	// Position the indicator
	_activityIndicator.frame = CGRectMake((NSInteger)((frame.size.width - totalWidth) / 2.0), y, indicatorSize, indicatorSize);
	
	// Calculate text position
	CGRect textRect = CGRectMake(_activityIndicator.frame.origin.x + indicatorSize + indicatorRightMargin, y, textSize.width, textSize.height);
	
	// Draw shadow. The offset is (0, 1)
	[_shadowColor set];
	CGRect shadowRect = CGRectMake(textRect.origin.x, textRect.origin.y + 1.0, textRect.size.width, textRect.size.height);
	[_text drawInRect:shadowRect withFont:_font lineBreakMode:UILineBreakModeTailTruncation alignment:UITextAlignmentLeft];	
	
	// Draw text
	[_textColor set];
	[_text drawInRect:textRect withFont:_font lineBreakMode:UILineBreakModeTailTruncation alignment:UITextAlignmentLeft];
}

#pragma mark Observer

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
