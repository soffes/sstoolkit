//
//  SCRatingPickerDemoViewController.m
//  SSCatalog
//
//  Created by Sam Soffes on 2/2/11.
//  Copyright 2011 Sam Soffes. All rights reserved.
//

#import "SCRatingPickerDemoViewController.h"
#import <SSToolkit/SSGradientView.h>
#import <SSToolkit/SSRatingPicker.h>

@implementation SCRatingPickerDemoViewController

#pragma mark Class Methods

+ (NSString *)title {
	return @"Rating Picker";
}


#pragma mark UIViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	self.title = [[self class] title];
	self.view.backgroundColor = [UIColor whiteColor];
	
	SSGradientView *gradientView = [[SSGradientView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 48.0f)];
	gradientView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
	gradientView.topColor = [UIColor colorWithRed:0.878f green:0.890f blue:0.906f alpha:1.0f];
	gradientView.bottomColor = [UIColor colorWithRed:0.961f green:0.965f blue:0.973f alpha:1.0f];
	gradientView.bottomBorderColor = [UIColor colorWithRed:0.839f green:0.839f blue:0.839f alpha:1.0f];
	gradientView.hasTopBorder = NO;
	gradientView.hasBottomBorder = YES;
	gradientView.showsInsets = NO;
	[self.view addSubview:gradientView];
	[gradientView release];
	
	SSRatingPicker *picker = [[SSRatingPicker alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 48.0f)];
	picker.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
	picker.backgroundColor = [UIColor clearColor];
	[picker addTarget:self action:@selector(ratingChanged:) forControlEvents:UIControlEventValueChanged];
	[self.view addSubview:picker];
	[picker release];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
		return toInterfaceOrientation != UIInterfaceOrientationPortraitUpsideDown;
	}
	return YES;
}


#pragma mark Actions

- (void)ratingChanged:(id)sender {
	NSLog(@"Rating: %0.1f", [sender numberOfStars]);
}

@end
