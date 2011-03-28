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
	
	return [[self model] isEqual:simulatorModel];	
}

@end
