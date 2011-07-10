//
//  UIColor+SSToolkitAdditions.h
//  SSToolkit
//
//  Created by Sam Soffes on 4/19/10.
//  Copyright 2010-2011 Sam Soffes. All rights reserved.
//

/**
 Provides extensions to `UIColor` for various common tasks.
 */
@interface UIColor (SSToolkitAdditions)

/**
 The receiver's alpha value. (read-only)
 
 The value of this property is a floating-point number in the range `0.0` to `1.0`, where `0.0` represents totally
 transparent and `1.0` represents totally opaque.
 */
@property (nonatomic, assign, readonly) CGFloat alpha;

@end
