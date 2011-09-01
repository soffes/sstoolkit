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
	GHAssertEquals(color.alpha, 1.0f, nil);
	
	color = [UIColor colorWithRed:0.3f green:0.4f blue:0.5f alpha:0.6f];
	GHAssertEquals(color.alpha, 0.6f, nil);
}


- (void)testRed {
	UIColor *color = [UIColor redColor];
	GHAssertEquals(color.red, 1.0f, nil);
	
	color = [UIColor colorWithRed:0.3f green:0.4f blue:0.5f alpha:0.6f];
	GHAssertEquals(color.red, 0.3f, nil);
}


- (void)testGreen {
	UIColor *color = [UIColor greenColor];
	GHAssertEquals(color.green, 1.0f, nil);
	
	color = [UIColor colorWithRed:0.3f green:0.4f blue:0.5f alpha:0.6f];
	GHAssertEquals(color.green, 0.4f, nil);
}


- (void)testBlue {
	UIColor *color = [UIColor blueColor];
	GHAssertEquals(color.blue, 1.0f, nil);
	
	color = [UIColor colorWithRed:0.3f green:0.4f blue:0.5f alpha:0.6f];
	GHAssertEquals(color.blue, 0.5f, nil);
}


- (void)testColorWithHexString {
	UIColor *red = [UIColor redColor];
	GHAssertEqualObjects(red, [UIColor colorWithHexString:@"ff0000"], nil);
	GHAssertEqualObjects(red, [UIColor colorWithHexString:@"f00"], nil);
	
	UIColor *green = [UIColor greenColor];
	GHAssertEqualObjects(green, [UIColor colorWithHexString:@"00ff00"], nil);
	GHAssertEqualObjects(green, [UIColor colorWithHexString:@"0f0"], nil);
	
	UIColor *blue = [UIColor blueColor];
	GHAssertEqualObjects(blue, [UIColor colorWithHexString:@"0000ff"], nil);
	GHAssertEqualObjects(blue, [UIColor colorWithHexString:@"00f"], nil);
}


- (void)testHexString {
	UIColor *red = [UIColor redColor];
	GHAssertEqualObjects([red hexStringValue], @"ff0000", nil);
	
	UIColor *green = [UIColor greenColor];
	GHAssertEqualObjects([green hexStringValue], @"00ff00", nil);
	
	UIColor *blue = [UIColor blueColor];
	GHAssertEqualObjects([blue hexStringValue], @"0000ff", nil);
	
	UIColor *white = [UIColor whiteColor];
	GHAssertEqualObjects([white hexStringValue], @"ffffff", nil);
}

@end
