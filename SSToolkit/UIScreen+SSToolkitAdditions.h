//
//  UIScreen+SSToolkitAdditions.h
//  SSToolkit
//
//  Created by Sam Soffes on 2/4/11.
//  Copyright 2011 Sam Soffes. All rights reserved.
//

@interface UIScreen (SSToolkitAdditions)

- (CGRect)currentBounds;
- (CGRect)boundsForOrientation:(UIInterfaceOrientation)orientation;

- (BOOL)isRetinaDisplay;

@end
