//
//  ColorCategoryTest.m
//  SSToolkit
//
//  Created by Sam Soffes on 4/15/11.
//  Copyright 2011 Sam Soffes. All rights reserved.
//

#import <SSToolkit/UIColor+SSToolkitAdditions.h>

@interface ColorCategoryTest : GHTestCase
@end

@implementation ColorCategoryTest

- (void)testAlpha {
	UIColor *color = [UIColor blackColor];
	GHAssertEquals([color alpha], 1.0f, nil);
	
	color = [UIColor colorWithRed:0.3f green:0.4f blue:0.5f alpha:0.6f];
	GHAssertEquals([color alpha], 0.6f, nil);
}

@end
