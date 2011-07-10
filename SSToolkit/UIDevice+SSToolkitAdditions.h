//
//  UIDevice+SSToolkitAdditions.h
//  SSToolkit
//
//  Created by Sam Soffes on 7/13/09.
//  Copyright 2009-2011 Sam Soffes. All rights reserved.
//

/**
 Provides extensions to `UIDevice` for various common tasks.
 */
@interface UIDevice (SSToolkitAdditions)

/**
 Returns `YES` if the device is a simulator.
 
 @return `YES` if the device is a simulator and `NO` if it is not.
 */
- (BOOL)isSimulator;

/**
 Returns `YES` if the device is an iPod touch, iPhone, iPhone 3G, or an iPhone 3GS.
 
 @return `YES` if the device is crappy and `NO` if it is not.
 */
- (BOOL)isCrappy;

@end
