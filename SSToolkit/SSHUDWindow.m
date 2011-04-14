//
//  SSHUDWindow.m
//  SSToolkit
//
//  Created by Sam Soffes on 3/17/11.
//  Copyright 2011 Sam Soffes. All rights reserved.
//

#import "SSHUDWindow.h"
#import "UIImage+SSToolkitAdditions.h"

static SSHUDWindow *kHUDWindow = nil;

@implementation SSHUDWindow

@synthesize hidesVignette = _hidesVignette;

#pragma mark Class Methods

+ (SSHUDWindow *)defaultWindow {
	if (!kHUDWindow) {
		kHUDWindow = [[SSHUDWindow alloc] init];
	}
	return kHUDWindow;
}


#pragma mark NSObject

- (id)init {
	if ((self = [super initWithFrame:[[UIScreen mainScreen] bounds]])) {
		self.backgroundColor = [UIColor clearColor];
		self.windowLevel = UIWindowLevelStatusBar + 1.0f;
	}
	return self;
}


#pragma mark UIView

- (void)drawRect:(CGRect)rect {
	if (_hidesVignette) {
		return;
	}
	
	NSString *imageName = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ? @"SSVignetteiPad.png" : @"SSVignetteiPhone.png";
	UIImage *image = [UIImage imageNamed:imageName bundle:kSSToolkitBundleName];
	
	CGSize screenSize = [[UIScreen mainScreen] bounds].size;
	[image drawInRect:CGRectMake(roundf((screenSize.width - image.size.width) / 2.0f), 
								 roundf((screenSize.height - image.size.height) / 2.0f), 
								 image.size.width, image.size.height)];	
}


#pragma mark Setters

- (void)setHidesVignette:(BOOL)hide {
	_hidesVignette = hide;
	self.userInteractionEnabled = !hide;
	[self setNeedsDisplay];
}

@end
