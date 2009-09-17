//
//  UIDevice+isSimulator.m
//  TWToolkit
//
//  Created by Sam Soffes on 7/13/09.
//  Copyright 2009 Sam Soffes. All rights reserved.
//

#import "UIDevice+isSimulator.h"

@implementation UIDevice (isSimulator)

- (BOOL)isSimulator {
	
	static NSString *simulatorModel = @"iPhone Simulator";
	
	return [[self model] isEqual:simulatorModel];	
}

@end
