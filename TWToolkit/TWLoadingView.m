//
//  SSLoadingView.m
//  TWToolkit
//
//  Created by Sam Soffes on 7/8/09.
//  Copyright 2009 Tasteful Works, Inc. All rights reserved.
//

#import "TWLoadingView.h"

static CGFloat interiorPadding = 20.0;
static CGFloat indicatorSize = 20.0;
static CGFloat indicatorRightMargin = 8.0;

@implementation TWLoadingView

@synthesize indicator;
@synthesize text;
@synthesize font;
@synthesize textColor;
@synthesize shadowColor;

#pragma mark -
#pragma mark NSObject
#pragma mark -

- (void)dealloc {
	[self removeObserver:self forKeyPath:@"text"];
	[self removeObserver:self forKeyPath:@"font"];
	[self removeObserver:self forKeyPath:@"textColor"];
	[self removeObserver:self forKeyPath:@"shadowColor"];
	[font release];
	[textColor release];
	[shadowColor release];
	[indicator release];
	[super dealloc];
}


#pragma mark -
#pragma mark UIView
#pragma mark -

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
		// View defaults
		self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		self.backgroundColor = [UIColor whiteColor];
		self.opaque = YES;
		
		// Setup the indicator
		indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
		indicator.hidesWhenStopped = NO;
		[indicator startAnimating];
		[self addSubview:indicator];
		
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
	
	// Calculate sizes
	CGSize maxSize = CGSizeMake(self.frame.size.width - (interiorPadding * 2.0) - indicatorSize - indicatorRightMargin, indicatorSize);
	CGSize textSize = [text sizeWithFont:font constrainedToSize:maxSize lineBreakMode:UILineBreakModeWordWrap];
	
	// Calculate position
	CGFloat totalWidth = textSize.width + indicatorSize + indicatorRightMargin;
	NSInteger y = (NSInteger)((self.frame.size.height / 2.0) - (indicatorSize / 2.0));
	
	// Position the indicator
	indicator.frame = CGRectMake((NSInteger)((self.frame.size.width - totalWidth) / 2.0), y, indicatorSize, indicatorSize);
	
	// Calculate text position
	CGRect textRect = CGRectMake(indicator.frame.origin.x + indicatorSize + indicatorRightMargin, y, textSize.width, textSize.height);
	
	// Draw shadow. The offset is (0, 1)
	[shadowColor set];
	CGRect shadowRect = CGRectMake(textRect.origin.x, textRect.origin.y + 1.0, textRect.size.width, textRect.size.height);
	[text drawInRect:shadowRect withFont:font lineBreakMode:UILineBreakModeTailTruncation alignment:UITextAlignmentLeft];	
	
	// Draw text
	[textColor set];
	[text drawInRect:textRect withFont:font lineBreakMode:UILineBreakModeTailTruncation alignment:UITextAlignmentLeft];
}


#pragma mark -
#pragma mark Observer
#pragma mark -

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
