//
//  UITableView+SSToolkitAdditions.m
//  SSToolkit
//
//  Created by Eliezer Talón on 20/04/13.
//  Copyright (c) 2013 Sam Soffes. All rights reserved.
//

#import "UITableView+SSToolkitAdditions.h"

@implementation UITableView (SSToolkitAdditions)

#pragma mark - Handling subviews

- (NSIndexPath *)indexPathForRowContainingView:(UIView *)view {
	CGPoint correctedPoint = [view convertPoint:view.bounds.origin toView:self];
	return [self indexPathForRowAtPoint:correctedPoint];
}

@end
