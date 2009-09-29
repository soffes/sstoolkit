//
//  TWHUDView.h
//  TWToolkit
//
//  Created by Sam Soffes on 9/29/09.
//  Copyright 2009 Tasteful Works, Inc. All rights reserved.
//

#import "TWHUDView.h"

@implementation TWHUDView

@synthesize background;
@synthesize label;
@synthesize activityIndicator;

#pragma mark -
#pragma mark NSObject
#pragma mark -

- (void)dealloc {
	[activityIndicator release];
	[label release];
	[background release];
    [super dealloc];
}


#pragma mark -
#pragma mark UIView
#pragma mark -

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
		
		// TODO: Abstract this out to make things easier
		NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
		NSString *imagePath = [resourcePath stringByAppendingPathComponent:@"TWToolkit.bundle/images/HUD.png"];
		
		self.background = [UIImage imageWithContentsOfFile:imagePath];
		
		activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
		[activityIndicator startAnimating];
		[self addSubview:activityIndicator];
		
		label = [[UILabel alloc] initWithFrame:CGRectZero];
		label.font = [UIFont boldSystemFontOfSize:14];
		label.backgroundColor = [UIColor clearColor];
		label.textColor = [UIColor whiteColor];
		label.shadowColor = [UIColor blackColor];
		label.shadowOffset = CGSizeMake(0.0, 1.0);
		label.textAlignment = UITextAlignmentCenter;
		label.lineBreakMode = UILineBreakModeTailTruncation;
		label.text = @"Loading";
		
		[self addSubview:label];
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
	CGRect backgroundRect = CGRectMake(round((self.frame.size.width - background.size.width) / 2.0), round((self.frame.size.height - background.size.height) / 2.0), background.size.width, background.size.height);
	[background drawInRect:backgroundRect];
}

- (void)layoutSubviews {
	[super layoutSubviews];
	
	static CGFloat indicatorSize = 40.0;
	
	//60, 130
	
	activityIndicator.frame = CGRectMake(round((self.frame.size.width - indicatorSize) / 2.0), round((self.frame.size.height - indicatorSize) / 2.0), indicatorSize, indicatorSize);
	label.frame = CGRectMake(round((self.frame.size.width - background.size.width) / 2.0), (round((self.frame.size.height - background.size.height) / 2.0)) + (background.size.height - 30.0), background.size.width, 20);
}

@end
