//
//  UITableView+SSToolkitAdditions.h
//  SSToolkit
//
//  Created by Eliezer Talón on 20/04/13.
//  Copyright (c) 2013 Sam Soffes. All rights reserved.
//

/**
 Provides extensions to `UITableView` for various common tasks.
 */
@interface UITableView (SSToolkitAdditions)

#pragma mark - Handling subviews
///------------------------
/// @name Handling subviews
///------------------------

/**
 Returns the index path of a UIView object added as subview of a row within the table

 @param view UIView object added as subview of a row within a UITableView
 @return Index path of a subview in a row
 */
- (NSIndexPath *)indexPathForRowContainingView:(UIView *)view;

@end
