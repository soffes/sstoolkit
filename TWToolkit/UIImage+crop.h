//
//  UIImage+crop.h
//  TWToolkit
//
//  Created by Sam Soffes on 8/19/09.
//  Copyright 2009 Tasteful Works, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (cropToRect)

- (UIImage *)initWithImage:(UIImage *)image croppedToRect:(CGRect)rect;
- (UIImage *)imageCroppedToRect:(CGRect)rect;

- (UIImage *)squareImage;

@end
