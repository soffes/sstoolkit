//
//  SSHUDWindow.m
//  SSToolkit
//
//  Created by Sam Soffes on 3/17/11.
//  Copyright 2011 Sam Soffes. All rights reserved.
//

#import "SSHUDWindow.h"
#import "UIImage+SSToolkitAdditions.h"

@implementation SSHUDWindow

@synthesize showsVignette = _showsVignette;

#pragma mark NSObject

- (id)init {
	if ((self = [super initWithFrame:[[UIScreen mainScreen] bounds]])) {
		self.backgroundColor = [UIColor clearColor];
		self.windowLevel = UIWindowLevelStatusBar + 1.0f;
		_showsVignette = YES;
	}
	return self;
}


#pragma mark UIView

- (void)drawRect:(CGRect)rect {
	if (!_showsVignette) {
		return;
	}
	
	NSString *imageName = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ? @"SSVignetteiPad.png" : @"SSVignetteiPhone.png";
	UIImage *image = [UIImage imageNamed:imageName bundle:kSSToolkitBundleName];
	
	CGSize screenSize = [[UIScreen mainScreen] bounds].size;
	if (UIDeviceOrientationIsLandscape([[UIDevice currentDevice] orientation])) {
		screenSize = CGSizeMake(screenSize.height, screenSize.width);
	}
	
	[image drawInRect:CGRectMake(roundf((screenSize.width - image.size.width) / 2.0f), 
								 roundf((screenSize.height - image.size.height) / 2.0f), 
								 image.size.width, image.size.height)];	
}


#pragma mark Setters

- (void)setShowsVignette:(BOOL)show {
	_showsVignette = show;
	[self setNeedsDisplay];
}

@end
