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


- (void)testColorWithHex {
	UIColor *red = [UIColor redColor];
	GHAssertEqualObjects(red, [UIColor colorWithHex:@"f00"], nil);
	GHAssertEqualObjects(red, [UIColor colorWithHex:@"ff0000"], nil);
	GHAssertEqualObjects(red, [UIColor colorWithHex:@"ff0000ff"], nil);
	
	UIColor *green = [UIColor greenColor];
	GHAssertEqualObjects(green, [UIColor colorWithHex:@"0f0"], nil);
	GHAssertEqualObjects(green, [UIColor colorWithHex:@"00ff00"], nil);
	GHAssertEqualObjects(green, [UIColor colorWithHex:@"00ff00ff"], nil);
	
	UIColor *blue = [UIColor blueColor];
	GHAssertEqualObjects(blue, [UIColor colorWithHex:@"00f"], nil);
	GHAssertEqualObjects(blue, [UIColor colorWithHex:@"0000ff"], nil);
	GHAssertEqualObjects(blue, [UIColor colorWithHex:@"0000ffff"], nil);
	
	UIColor *bleh = [UIColor colorWithRed:1.0f green:0.2f blue:0.0f alpha:0.2f];
	GHAssertEqualObjects(bleh, [UIColor colorWithHex:@"ff330033"], nil);
}


- (void)testHexValue {
	UIColor *red = [UIColor redColor];
	GHAssertEqualObjects([red hexValue], @"ff0000", nil);
	GHAssertEqualObjects([red hexValueWithAlpha:YES], @"ff0000ff", nil);
	
	UIColor *green = [UIColor greenColor];
	GHAssertEqualObjects([green hexValue], @"00ff00", nil);
	GHAssertEqualObjects([green hexValueWithAlpha:YES], @"00ff00ff", nil);
	
	UIColor *blue = [UIColor blueColor];
	GHAssertEqualObjects([blue hexValue], @"0000ff", nil);
	GHAssertEqualObjects([blue hexValueWithAlpha:YES], @"0000ffff", nil);
	
	UIColor *white = [UIColor whiteColor];
	GHAssertEqualObjects([white hexValue], @"ffffff", nil);
	GHAssertEqualObjects([white hexValueWithAlpha:YES], @"ffffffff", nil);
	GHAssertEqualObjects([[white colorWithAlphaComponent:0.2f] hexValueWithAlpha:YES], @"ffffff33", nil);
}

@end
