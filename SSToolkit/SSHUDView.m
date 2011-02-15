//
//  SSHUDView.h
//  SSToolkit
//
//  Created by Sam Soffes on 9/29/09.
//  Copyright 2009-2010 Sam Soffes. All rights reserved.
//

#import "SSHUDView.h"
#import "UIImage+SSToolkitAdditions.h"
#import <QuartzCore/QuartzCore.h>

static CGFloat kHUDSize = 172.0;
static CGFloat kIndicatorSize = 40.0;

@implementation SSHUDView

@synthesize textLabel = _textLabel;
@synthesize activityIndicator = _activityIndicator;
@synthesize loading = _loading;
@synthesize successful = _successful;

#pragma mark NSObject

- (id)init {
	return [self initWithTitle:nil loading:YES];
}


- (void)dealloc {
	[_activityIndicator release];
	[_textLabel release];
	[super dealloc];
}


#pragma mark UIView

- (id)initWithFrame:(CGRect)frame {
	return [self initWithTitle:nil loading:YES];
}


- (void)drawRect:(CGRect)rect {
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	// Draw rounded rectangle
	CGContextSetRGBFillColor(context, 0.0f, 0.0f, 0.0f, 0.5);
	CGRect rrect = CGRectMake(0.0f, 0.0f, kHUDSize, kHUDSize);
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
	
	// Image
	if (_loading == NO) {
		[[UIColor whiteColor] set];
		NSString *dingbat = _successful ? @"✔" : @"✘";
		CGFloat margin = roundf((kHUDSize - 40.0f) / 2.0f);
		CGRect dingbatRect = CGRectMake(margin, margin - 20.0f, 40.0f, 40.0f);
		[dingbat drawInRect:dingbatRect withFont:[UIFont systemFontOfSize:60.0f] lineBreakMode:UILineBreakModeClip alignment:UITextAlignmentCenter];
	}
}


- (void)layoutSubviews {
	_activityIndicator.frame = CGRectMake(roundf((kHUDSize - kIndicatorSize) / 2.0f), roundf((kHUDSize - kIndicatorSize) / 2.0f), kIndicatorSize, kIndicatorSize);
	_textLabel.frame = CGRectMake(0.0f, roundf(kHUDSize - 30.0f), kHUDSize, 20.0f);
}


#pragma mark UIAlertView

- (void)show {
	[super show];

	// Set the frame to 20px larger than it should be because UIAlertView
	// will automatically resize it down after the animation
	CGFloat biggerSize = kHUDSize + 20.0f;
	CGSize screenSize = [[UIScreen mainScreen] bounds].size;
	self.frame = CGRectMake(roundf((screenSize.width - biggerSize) / 2.0f), 
							roundf((screenSize.height - biggerSize) / 2.0f) + 10.0f, 
							biggerSize, biggerSize);
}


// Deprecated. Overridding UIAlertView's setTitle.
- (void)setTitle:(NSString *)aTitle {
	_textLabel.text = aTitle;
}


#pragma mark HUD

- (id)initWithTitle:(NSString *)aTitle {
	return [self initWithTitle:aTitle loading:YES];
}


- (id)initWithTitle:(NSString *)aTitle loading:(BOOL)isLoading {
	if ((self = [super initWithFrame:CGRectZero])) {

		// Indicator
		_activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
		_activityIndicator.alpha = 0.0;
		[_activityIndicator startAnimating];
		[self addSubview:_activityIndicator];
		
		// Text Label
		_textLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		_textLabel.font = [UIFont boldSystemFontOfSize:14];
		_textLabel.backgroundColor = [UIColor clearColor];
		_textLabel.textColor = [UIColor whiteColor];
		_textLabel.shadowColor = [UIColor blackColor];
		_textLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
		_textLabel.textAlignment = UITextAlignmentCenter;
		_textLabel.lineBreakMode = UILineBreakModeTailTruncation;
		_textLabel.text = aTitle ? aTitle : @"Loading";
		[self addSubview:_textLabel];
		
		// Loading
		self.loading = isLoading;
	}
	return self;
}


- (void)completeWithTitle:(NSString *)aTitle {
	self.successful = YES;
	self.loading = NO;
	_textLabel.text = aTitle;
}


- (void)completeAndDismissWithTitle:(NSString *)aTitle {
	[self completeWithTitle:aTitle];
	[self retain];
	[self performSelector:@selector(releaseAndDismiss) withObject:nil afterDelay:1.0];
}


- (void)failWithTitle:(NSString *)aTitle {
	self.successful = NO;
	self.loading = NO;
	_textLabel.text = aTitle;
}


- (void)failAndDismissWithTitle:(NSString *)aTitle {
	[self failWithTitle:aTitle];
	[self retain];
	[self performSelector:@selector(releaseAndDismiss) withObject:nil afterDelay:1.0];
}


- (void)releaseAndDismiss {
	[self autorelease];
	[self dismissAnimated:YES];
}


- (void)dismiss {
	[self dismissAnimated:YES];
}


- (void)dismissAnimated:(BOOL)animated {
	[super dismissWithClickedButtonIndex:0 animated:animated];
}


#pragma mark Setters

- (void)setLoading:(BOOL)isLoading {
	_loading = isLoading;
	_activityIndicator.alpha = _loading ? 1.0 : 0.0;
	[self setNeedsDisplay];
}

@end
