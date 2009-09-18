//
//  SSLoadingView.m
//  Four80
//
//  Created by Sam Soffes on 7/8/09.
//  Copyright 2009 Sam Soffes. All rights reserved.
//

#import "SSLoadingView.h"

@implementation SSLoadingView

@synthesize indicator;
@synthesize text;
@synthesize font;
@synthesize color;
@synthesize shadowColor;

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
		self.color = aColor;
		[aColor release];
		self.shadowColor = [UIColor whiteColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
	
	// Indicator is 20px x 20px
	// There are 8px of space between the indicator and the text
	
	CGSize maxSize = CGSizeMake(self.frame.size.width - 68.0, 20.0);
	CGSize textSize = [text sizeWithFont:font constrainedToSize:maxSize lineBreakMode:UILineBreakModeWordWrap];
	
	CGFloat totalWidth = textSize.width + 28.0;
	NSInteger y = (NSInteger)((self.frame.size.height / 2.0) - 10.0);
	
	indicator.frame = CGRectMake((NSInteger)((self.frame.size.width - totalWidth) / 2.0), y, 20.0, 20.0);
	
	CGRect textRect = CGRectMake(indicator.frame.origin.x + 28.0, y, textSize.width, textSize.height);
	
	// Shadow
	// The offset is (0, 1)
	[shadowColor set];
	CGRect shadowRect = CGRectMake(textRect.origin.x, textRect.origin.y + 1.0, textRect.size.width, textRect.size.height);
	[text drawInRect:shadowRect withFont:font lineBreakMode:UILineBreakModeTailTruncation alignment:UITextAlignmentLeft];	
	
	// Text
	[color set];
	[text drawInRect:textRect withFont:font lineBreakMode:UILineBreakModeTailTruncation alignment:UITextAlignmentLeft];
}

- (void)dealloc {
	[font release];
	[color release];
	[shadowColor release];
	[indicator release];
	[super dealloc];
}

@end
