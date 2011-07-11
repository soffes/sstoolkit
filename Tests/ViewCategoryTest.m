//
//  ViewTest.m
//  SSToolkit
//
//  Created by Sam Soffes on 7/10/11.
//  Copyright 2011 Sam Soffes. All rights reserved.
//

#import <SSToolkit/UIView+SSToolkitAdditions.h>
#import <SSToolkit/SSLineView.h>

@interface ViewCategoryTest : GHTestCase
@end

@implementation ViewCategoryTest

- (void)testHide {
	UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
	[view hide];
	GHAssertEquals(view.alpha, 0.0f, nil);
	[view release];
}


- (void)testShow {
	UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
	view.alpha = 0.0f;
	[view show];
	GHAssertEquals(view.alpha, 1.0f, nil);
	[view release];
}


- (void)testSuperviews {
	UIView *one = [[UIView alloc] initWithFrame:CGRectZero];
	UIView *two = [[UIView alloc] initWithFrame:CGRectZero];
	UIView *three = [[UIView alloc] initWithFrame:CGRectZero];
	UIView *four = [[UIView alloc] initWithFrame:CGRectZero];
	UIView *five = [[UIView alloc] initWithFrame:CGRectZero];
	
	[four addSubview:five];
	[three addSubview:four];
	[two addSubview:three];
	[one addSubview:two];
	
	NSArray *superviews = [[NSArray alloc] initWithObjects:four, three, two, one, nil];
	
	GHAssertEqualObjects([five superviews], superviews, nil);
	
	[superviews release];
	[one release];
	[two release];
	[three release];
	[four release];
	[five release];
}


- (void)testFirstSuperviewOfClass {
	UIView *one = [[SSLineView alloc] initWithFrame:CGRectZero];
	UIView *two = [[SSLineView alloc] initWithFrame:CGRectZero];
	UIView *three = [[UIView alloc] initWithFrame:CGRectZero];
	UIView *four = [[UIView alloc] initWithFrame:CGRectZero];
	UIView *five = [[UIView alloc] initWithFrame:CGRectZero];
	
	[four addSubview:five];
	[three addSubview:four];
	[two addSubview:three];
	[one addSubview:two];
	
	GHAssertEqualObjects([five firstSuperviewOfClass:[SSLineView class]], two, nil);
	
	[one release];
	[two release];
	[three release];
	[four release];
	[five release];
}

@end
