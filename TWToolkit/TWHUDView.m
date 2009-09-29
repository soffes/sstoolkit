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
		
		self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
		activityIndicator.frame = CGRectMake(60, 60, 40, 40);
		
		[activityIndicator startAnimating];
		
		[self addSubview:self.activityIndicator];
		
		self.label = [[UILabel alloc] initWithFrame:CGRectMake(10, 130, 140, 20)];
		label.font = [UIFont boldSystemFontOfSize:14];
		label.backgroundColor = [UIColor clearColor];
		label.textColor = [UIColor whiteColor];
		label.shadowColor = [UIColor darkGrayColor];
		label.shadowOffset = CGSizeMake(1, 1);
		label.textAlignment = UITextAlignmentCenter;
		label.lineBreakMode = UILineBreakModeTailTruncation;
		label.text = @"Loading...";
		
		[self addSubview:self.label];
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
	CGRect theRect = CGRectMake(0, 0, 160, 160);
	[self.background drawInRect:theRect];
}

@end
