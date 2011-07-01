//
//  UIDevice+SSToolkitAdditions.m
//  SSToolkit
//
//  Created by Sam Soffes on 7/13/09.
//  Copyright 2009-2011 Sam Soffes. All rights reserved.
//

#import "UIDevice+SSToolkitAdditions.h"

@implementation UIDevice (SSToolkitAdditions)

- (BOOL)isSimulator {
	static NSString *simulatorModel = @"iPhone Simulator";
	return [[self model] isEqualToString:simulatorModel];	
}


- (BOOL)isCrappy {
	static NSString *iPodTouchModel = @"iPod touch";
	static NSString *iPhoneModel = @"iPhone";
	static NSString *iPhone3GModel = @"iPhone 3G";
	static NSString *iPhone3GSModel = @"iPhone 3GS";
	
	NSString *model = [self model];
	
	return ([model isEqualToString:iPodTouchModel] || [model isEqualToString:iPhoneModel] ||
			[model isEqualToString:iPhone3GModel] || [model isEqualToString:iPhone3GSModel]);
}

@end
