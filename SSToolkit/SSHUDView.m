//
//  SSHUDView.m
//  SSToolkit
//
//  Created by Sam Soffes on 9/29/09.
//  Copyright 2009-2011 Sam Soffes. All rights reserved.
//

#import "SSHUDView.h"
#import "SSHUDWindow.h"
#import "SSDrawingUtilities.h"
#import "UIView+SSToolkitAdditions.h"
#import "NSBundle+SSToolkitAdditions.h"
#import <QuartzCore/QuartzCore.h>
#import "UIImage+SSToolkitAdditions.h"

static CGFloat kIndicatorSize = 40.0;

@interface SSHUDView (PrivateMethods)
- (void)_setTransformForCurrentOrientation:(BOOL)animated;
- (void)_deviceOrientationChanged:(NSNotification *)notification;
- (void)_removeWindow;
@end

@implementation SSHUDView {
	SSHUDWindow *_hudWindow;
}


#pragma mark - Accessors

@synthesize textLabel = _textLabel;
@synthesize textLabelHidden = _textLabelHidden;
@synthesize activityIndicator = _activityIndicator;
@synthesize hudSize = _hudSize;
@synthesize loading = _loading;
@synthesize successful = _successful;
@synthesize completeImage = _completeImage;
@synthesize failImage = _failImage;

- (void)setTextLabelHidden:(BOOL)hidden {
	_textLabelHidden = hidden;
	_textLabel.hidden = hidden;
	[self setNeedsLayout];
}


- (void)setLoading:(BOOL)isLoading {
	_loading = isLoading;
	_activityIndicator.alpha = _loading ? 1.0 : 0.0;
	[self setNeedsDisplay];
}


- (BOOL)hidesVignette {
	return _hudWindow.hidesVignette;
}


- (void)setHidesVignette:(BOOL)hide {
	_hudWindow.hidesVignette = hide;
}


#pragma mark - NSObject

- (id)init {
	return (self = [self initWithTitle:nil loading:YES]);
}


- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
	[self _removeWindow];
}


#pragma mark - UIView

- (id)initWithFrame:(CGRect)frame {
	return (self = [self initWithTitle:nil loading:YES]);
}


- (void)drawRect:(CGRect)rect {
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	// Draw rounded rectangle
	CGContextSetRGBFillColor(context, 0.0f, 0.0f, 0.0f, 0.5f);
	CGRect rrect = CGRectMake(0.0f, 0.0f, _hudSize.width, _hudSize.height);
	SSDrawRoundedRect(context, rrect, 14.0f);
	
	// Image
	if (_loading == NO) {
		[[UIColor whiteColor] set];
		
		UIImage *image = _successful ? _completeImage : _failImage;
		
		if (image) {
			CGSize imageSize = image.size;
			CGRect imageRect = CGRectMake(roundf((_hudSize.width - imageSize.width) / 2.0f),
										  roundf((_hudSize.height - imageSize.height) / 2.0f),
										  imageSize.width, imageSize.height);
			[image drawInRect:imageRect];
			return;
		}
		
		NSString *dingbat = _successful ? @"✔" : @"✘";
		UIFont *dingbatFont = [UIFont systemFontOfSize:60.0f];
		CGSize dingbatSize = [dingbat sizeWithFont:dingbatFont];
		CGRect dingbatRect = CGRectMake(roundf((_hudSize.width - dingbatSize.width) / 2.0f),
										roundf((_hudSize.height - dingbatSize.height) / 2.0f),
										dingbatSize.width, dingbatSize.height);
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_6_0
		[dingbat drawInRect:dingbatRect withFont:dingbatFont lineBreakMode:NSLineBreakByClipping alignment:NSTextAlignmentCenter];
#else
		[dingbat drawInRect:dingbatRect withFont:dingbatFont lineBreakMode:UILineBreakModeClip alignment:UITextAlignmentCenter];
#endif
	}
}


- (void)layoutSubviews {
	_activityIndicator.frame = CGRectMake(roundf((_hudSize.width - kIndicatorSize) / 2.0f),
										  roundf((_hudSize.height - kIndicatorSize) / 2.0f),
										  kIndicatorSize, kIndicatorSize);
	
	if (_textLabelHidden) {
		_textLabel.frame = CGRectZero;
	} else {
		CGSize textSize = [_textLabel.text sizeWithFont:_textLabel.font constrainedToSize:CGSizeMake(self.bounds.size.width, CGFLOAT_MAX) lineBreakMode:_textLabel.lineBreakMode];
		_textLabel.frame = CGRectMake(0.0f, roundf(_hudSize.height - textSize.height - 10.0f), _hudSize.width, textSize.height);
	}
}


#pragma mark - HUD

- (id)initWithTitle:(NSString *)aTitle {
	return [self initWithTitle:aTitle loading:YES];
}


- (id)initWithTitle:(NSString *)aTitle loading:(BOOL)isLoading {
	if ((self = [super initWithFrame:CGRectZero])) {
		self.backgroundColor = [UIColor clearColor];
		
		_hudSize = CGSizeMake(172.0f, 172.0f);
		
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
		_textLabel.shadowColor = [UIColor colorWithWhite:0.0f alpha:0.7f];
		_textLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_6_0
		_textLabel.textAlignment = NSTextAlignmentCenter;
		_textLabel.lineBreakMode = NSLineBreakByTruncatingTail;
#else
		_textLabel.textAlignment = UITextAlignmentCenter;
		_textLabel.lineBreakMode = UILineBreakModeTailTruncation;
#endif
		_textLabel.text = aTitle ? aTitle : SSToolkitLocalizedString(@"Loading...");
		[self addSubview:_textLabel];
		
		// Loading
		self.loading = isLoading;
		
		// Images
		self.completeImage = [UIImage imageNamed:@"hud-check.png" bundleName:kSSToolkitBundleName];
		self.failImage = [UIImage imageNamed:@"hud-x.png" bundleName:kSSToolkitBundleName];
        
        // Orientation
        [self _setTransformForCurrentOrientation:NO];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_deviceOrientationChanged:) name:UIDeviceOrientationDidChangeNotification object:nil];
	}
	return self;
}


- (void)show {
//	[self retain];
	if (!_hudWindow) {
		_hudWindow = [SSHUDWindow defaultWindow];
	}
	
	_hudWindow.alpha = 0.0f;
	self.alpha = 0.0f;
	[_hudWindow addSubview:self];
	[_hudWindow makeKeyAndVisible];
	
	[UIView beginAnimations:@"SSHUDViewFadeInWindow" context:nil];
	_hudWindow.alpha = 1.0f;
	[UIView commitAnimations];
	
	CGSize windowSize = _hudWindow.frame.size;
	CGRect contentFrame = CGRectMake(roundf((windowSize.width - _hudSize.width) / 2.0f), 
									 roundf((windowSize.height - _hudSize.height) / 2.0f) + 10.0f,
									 _hudSize.width, _hudSize.height);
	
    
    CGFloat offset = 20.0f;
    if (UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation)) {
        self.frame = CGRectSetY(contentFrame, contentFrame.origin.y + offset);
    } else {
        self.frame = CGRectSetX(contentFrame, contentFrame.origin.x + offset);
    }
	
	[UIView beginAnimations:@"SSHUDViewFadeInContentAlpha" context:nil];
	[UIView setAnimationDelay:0.1];
	[UIView setAnimationDuration:0.2];
	self.alpha = 1.0f;
	[UIView commitAnimations];
	
	[UIView beginAnimations:@"SSHUDViewFadeInContentFrame" context:nil];
	[UIView setAnimationDelay:0.1];
	[UIView setAnimationDuration:0.3];
	self.frame = contentFrame;
	[UIView commitAnimations];
}


- (void)completeWithTitle:(NSString *)aTitle {
	self.successful = YES;
	self.loading = NO;
	_textLabel.text = aTitle;
}


- (void)completeAndDismissWithTitle:(NSString *)aTitle {
	[self completeWithTitle:aTitle];
	[self performSelector:@selector(dismiss) withObject:nil afterDelay:1.0];
}


- (void)completeQuicklyWithTitle:(NSString *)aTitle {
	[self completeWithTitle:aTitle];
	[self show];
	[self performSelector:@selector(dismiss) withObject:nil afterDelay:1.05];
}


- (void)failWithTitle:(NSString *)aTitle {
	self.successful = NO;
	self.loading = NO;
	_textLabel.text = aTitle;
}


- (void)failAndDismissWithTitle:(NSString *)aTitle {
	[self failWithTitle:aTitle];
	[self performSelector:@selector(dismiss) withObject:nil afterDelay:1.0];
}


- (void)failQuicklyWithTitle:(NSString *)aTitle {
	[self failWithTitle:aTitle];
	[self show];
	[self performSelector:@selector(dismiss) withObject:nil afterDelay:1.05];
}


- (void)dismiss {
//	[self autorelease];
	[self dismissAnimated:YES];
}


- (void)dismissAnimated:(BOOL)animated {
	[UIView beginAnimations:@"SSHUDViewFadeOutContentFrame" context:nil];
	[UIView setAnimationDuration:0.2];
	CGRect contentFrame = self.frame;
    CGFloat offset = 20.0f;
    if (UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation)) {
        self.frame = CGRectSetY(contentFrame, contentFrame.origin.y + offset);
    } else {
        self.frame = CGRectSetX(contentFrame, contentFrame.origin.x + offset);
    }
	[UIView commitAnimations];
	
	[UIView beginAnimations:@"SSHUDViewFadeOutContentAlpha" context:nil];
	[UIView setAnimationDelay:0.1];
	[UIView setAnimationDuration:0.2];
	self.alpha = 0.0f;
	[UIView commitAnimations];

	[UIView beginAnimations:@"SSHUDViewFadeOutWindow" context:nil];
	_hudWindow.alpha = 0.0f;
	[UIView commitAnimations];

	if (animated) {
		[self performSelector:@selector(_removeWindow) withObject:nil afterDelay:0.3];
	} else {
		[self _removeWindow];
	}
}


#pragma mark - Private Methods

- (void)_setTransformForCurrentOrientation:(BOOL)animated {
	UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
	NSInteger degrees = 0;
    
    // Landscape left
	if (orientation == UIInterfaceOrientationLandscapeLeft) {
		degrees = -90;
	}
	
	// Landscape right
	if (orientation == UIInterfaceOrientationLandscapeRight) {
		degrees = 90;
	}
	
	// Portrait upside down
	else if (orientation == UIInterfaceOrientationPortraitUpsideDown) {
		degrees = 180;
	}
    
    CGAffineTransform rotationTransform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(degrees));
    
	if (animated) {
		[UIView beginAnimations:@"SSHUDViewRotationTransform" context:nil];
		[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
		[UIView setAnimationDuration:0.3];
	}
    
	[self setTransform:rotationTransform];
    
    if (animated) {
		[UIView commitAnimations];
	}
}


- (void)_deviceOrientationChanged:(NSNotification *)notification {
    [self _setTransformForCurrentOrientation:YES];
	[self setNeedsDisplay];
}


- (void)_removeWindow {	
	[_hudWindow resignKeyWindow];
	_hudWindow = nil;
	
	// Return focus to the first window
	[[[[UIApplication sharedApplication] windows] objectAtIndex:0] makeKeyWindow];
}

@end
