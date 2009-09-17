//
//  UIImage+crop.h
//  TWToolkit
//
//  Created by Sam Soffes on 8/19/09.
//  Copyright 2009 Sam Soffes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (cropToRect)

- (UIImage *)initWithImage:(UIImage *)image croppedToRect:(CGRect)rect;
- (UIImage *)cropToRect:(CGRect)rect;

@end
