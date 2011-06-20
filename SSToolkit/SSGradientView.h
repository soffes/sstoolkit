//
//  SSGradientView.h
//  SSToolkit
//
//  Created by Sam Soffes on 10/27/09.
//  Copyright 2009-2011 Sam Soffes. All rights reserved.
//
//	Greatly inspired by BWGradientBox. http://brandonwalkin.com/bwtoolkit
//

#import "SSBordererView.h"

/**
 @brief Simple UIView wrapper for CGGradient.
 */
@interface SSGradientView : SSBordererView {
	
@private
	
	NSArray *_colors;
	NSArray *_locations;

	CGGradientRef _gradient;
}

/**
 @brief An array of <code>UIColor</code> objects used to draw the gradient. If the value is <code>nil</code>, the
 <code>backgroundColor</code> will be drawn instead of a gradient. The default is <code>nil</code>.
 */
@property (nonatomic, copy) NSArray *colors;

/**
 @brief An optional array of NSNumber objects defining the location of each gradient stop.
 
 The gradient stops are specified as values between <code>0</code> and <code>1</code>. The values must be monotonically
 increasing. If <code>nil</code>, the stops are spread uniformly across the range. Defaults to <code>nil</code>.
 */
@property (nonatomic, copy) NSArray *locations;


#pragma mark -
#pragma mark Deprecated

/**
 @brief The top gradient color. The default is <code>nil</code>. DEPRECATED.
 */
@property (nonatomic, retain) UIColor *topColor;

/**
 @brief The bottom gradient color. The default is <code>nil</code>. DEPRECATED.
 */
@property (nonatomic, retain) UIColor *bottomColor;

/**
 @brief The scale of the gradient. DEPRECATED.
 
 The default is <code>1.0</code>.
 */
@property (nonatomic, assign) CGFloat gradientScale;

@end
