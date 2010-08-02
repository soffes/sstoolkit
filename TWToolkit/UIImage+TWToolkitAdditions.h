//
//  UIImage+TWToolkitAdditions.h
//  TWToolkit
//
//  Created by Sam Soffes on 11/17/09.
//  Copyright 2009 Tasteful Works, Inc. All rights reserved.
//

@interface UIImage (TWToolkitAdditions)

+ (UIImage *)imageNamed:(NSString *)imageName bundle:(NSString *)bundleName;

- (UIImage *)initWithImage:(UIImage *)image croppedToRect:(CGRect)rect;
- (UIImage *)imageCroppedToRect:(CGRect)rect;

- (UIImage *)squareImage;

@end
