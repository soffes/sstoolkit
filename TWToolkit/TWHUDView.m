//
//  TWHUDView.h
//  TWToolkit
//
//  Created by Sam Soffes on 9/29/09.
//  Copyright 2009 Tasteful Works, Inc. All rights reserved.
//

#import "TWHUDView.h"
#import "UIImage+BundleImage.h"

#define kHUDSize 180.0

@implementation TWHUDView

@synthesize textLabel;
@synthesize activityIndicator;
@synthesize loading;

#pragma mark -
#pragma mark NSObject
#pragma mark -

- (id)init {
	return [self initWithTitle:nil loading:YES];
}


- (void)dealloc {
	[activityIndicator release];
	[textLabel release];
    [super dealloc];
}


#pragma mark -
#pragma mark UIView
#pragma mark -

- (id)initWithFrame:(CGRect)frame {
    return [self initWithTitle:nil loading:YES];
}


- (void)drawRect:(CGRect)rect {

	CGContextRef context = UIGraphicsGetCurrentContext();
	
	// Draw rounded rectangle
	CGContextSetRGBFillColor(context, 0.0, 0.0, 0.0, 0.5);
	CGRect rrect = CGRectMake(0.0, 0.0, kHUDSize, kHUDSize);
	CGFloat radius = 14.0;
	CGFloat minx = CGRectGetMinX(rrect);
	CGFloat midx = CGRectGetMidX(rrect);
	CGFloat maxx = CGRectGetMaxX(rrect);
	CGFloat miny = CGRectGetMinY(rrect);
	CGFloat midy = CGRectGetMidY(rrect);
	CGFloat maxy = CGRectGetMaxY(rrect);	
	CGContextMoveToPoint(context, minx, midy);
	CGContextAddArcToPoint(context, minx, miny, midx, miny, radius);
	CGContextAddArcToPoint(context, maxx, miny, maxx, midy, radius);
	CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, radius);
	CGContextAddArcToPoint(context, minx, maxy, minx, midy, radius);
	CGContextClosePath(context);
	CGContextFillPath(context);
	
	// Checkmark
	if (loading == NO) {
		UIImage *checkmark = [UIImage imageNamed:@"images/hud-checkmark.png" bundle:@"TWToolkit.bundle"];
		[checkmark drawInRect:CGRectMake(round((kHUDSize - 36.0) / 2.0), round((kHUDSize - 40.0) / 2.0), 36.0, 40.0)];
	}
}


- (void)layoutSubviews {
	static CGFloat indicatorSize = 40.0;
	
	activityIndicator.frame = CGRectMake(round((kHUDSize - indicatorSize) / 2.0), round((kHUDSize - indicatorSize) / 2.0), indicatorSize, indicatorSize);
	textLabel.frame = CGRectMake(0.0, (kHUDSize - 30.0), kHUDSize, 20);
}


#pragma mark -
#pragma mark UIAlertView
#pragma mark -

- (void)show {
	[super show];
	
	// Set the frame to 20px larger than it should be because UIAlertView
	// will automatically resize it down after the animation
	CGFloat biggerSize = kHUDSize + 20.0;
	self.frame = CGRectMake(round((320.0 - biggerSize) / 2.0), round((480.0 - biggerSize) / 2.0) + 10.0, biggerSize, biggerSize);
}


// Deprecated. Overridding UIAlertView's setTitle.
- (void)setTitle:(NSString *)aTitle {
	textLabel.text = aTitle;
}

#pragma mark -
#pragma mark HUD
#pragma mark -

- (id)initWithTitle:(NSString *)aTitle {
	return [self initWithTitle:aTitle loading:YES];
}


- (id)initWithTitle:(NSString *)aTitle loading:(BOOL)isLoading {
	if (self = [super initWithFrame:CGRectZero]) {
		// Indicator
		activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
		activityIndicator.alpha = 0.0;
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
		textLabel.text = aTitle ? aTitle : @"Loading";
		[self addSubview:textLabel];
		
		// Loading
		self.loading = isLoading;
	}
	return self;
}


- (void)completeWithTitle:(NSString *)aTitle {
	self.loading = NO;
	textLabel.text = aTitle;
}


- (void)dismiss {
	[self dismissAnimated:YES];
}


- (void)dismissAnimated:(BOOL)animated {
	[super dismissWithClickedButtonIndex:0 animated:animated];
}


#pragma mark -
#pragma mark Setters
#pragma mark -

- (void)setLoading:(BOOL)isLoading {
	loading = isLoading;
	activityIndicator.alpha = loading ? 1.0 : 0.0;
	[self setNeedsDisplay];
	
}

@end
