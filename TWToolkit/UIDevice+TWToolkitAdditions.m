//
//  UIDevice+TWToolkitAdditions.m
//  TWToolkit
//
//  Created by Sam Soffes on 7/13/09.
//  Copyright 2009 Tasteful Works, Inc. All rights reserved.
//

#import "UIDevice+TWToolkitAdditions.h"

@implementation UIDevice (TWToolkitAdditions)

- (BOOL)isSimulator {
	
	static NSString *simulatorModel = @"iPhone Simulator";
	
	return [[self model] isEqual:simulatorModel];	
}

@end
