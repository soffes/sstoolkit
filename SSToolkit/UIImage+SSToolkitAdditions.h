//
//  UIImage+SSToolkitAdditions.h
//  SSToolkit
//
//  Created by Sam Soffes on 11/17/09.
//  Copyright 2009-2011 Sam Soffes. All rights reserved.
//

@interface UIImage (SSToolkitAdditions)

+ (UIImage *)imageNamed:(NSString *)imageName bundle:(NSString *)bundleName;

- (UIImage *)initWithImage:(UIImage *)image croppedToRect:(CGRect)rect;
- (UIImage *)imageCroppedToRect:(CGRect)rect;

- (UIImage *)squareImage;

- (NSInteger)rightCapWidth;

@end
