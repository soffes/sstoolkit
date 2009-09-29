//
//  TWHUDView.h
//  TWToolkit
//
//  Created by Sam Soffes on 9/29/09.
//  Copyright 2009 Tasteful Works, Inc. All rights reserved.
//

#import "TWHUDView.h"

@implementation TWHUDView

@synthesize backgroundImage;
@synthesize textLabel;
@synthesize activityIndicator;

#pragma mark -
#pragma mark NSObject
#pragma mark -

- (void)dealloc {
	[activityIndicator release];
	[textLabel release];
	[backgroundImage release];
    [super dealloc];
}


#pragma mark -
#pragma mark UIView
#pragma mark -

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
		
		// Background color
        self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.25];
		
		// TODO: Abstract this out to make things easier
		NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
		NSString *imagePath = [resourcePath stringByAppendingPathComponent:@"TWToolkit.bundle/images/HUD.png"];
		
		// Background image
		self.backgroundImage = [UIImage imageWithContentsOfFile:imagePath];
		
		// Indicator
		activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
		[activityIndicator startAnimating];
		[self addSubview:activityIndicator];
		
		// Text Label
		textLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		textLabel.font = [UIFont boldSystemFontOfSize:14];
		textLabel.backgroundColor = [UIColor clearColor];
		textLabel.textColor = [UIColor whiteColor];
		textLabel.shadowColor = [UIColor blackColor];
		textLabel.shadowOffset = CGSizeMake(0.0, 1.0);
		textLabel.textAlignment = UITextAlignmentCenter;
		textLabel.lineBreakMode = UILineBreakModeTailTruncation;
		textLabel.text = @"Loading";
		[self addSubview:textLabel];
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
	CGRect backgroundImageRect = CGRectMake(round((self.frame.size.width - backgroundImage.size.width) / 2.0), round((self.frame.size.height - backgroundImage.size.height) / 2.0), backgroundImage.size.width, backgroundImage.size.height);
	[backgroundImage drawInRect:backgroundImageRect];
}

- (void)layoutSubviews {
	[super layoutSubviews];
	
	static CGFloat indicatorSize = 40.0;
	
	activityIndicator.frame = CGRectMake(round((self.frame.size.width - indicatorSize) / 2.0), round((self.frame.size.height - indicatorSize) / 2.0), indicatorSize, indicatorSize);
	textLabel.frame = CGRectMake(round((self.frame.size.width - backgroundImage.size.width) / 2.0), (round((self.frame.size.height - backgroundImage.size.height) / 2.0)) + (backgroundImage.size.height - 30.0), backgroundImage.size.width, 20);
}

@end
