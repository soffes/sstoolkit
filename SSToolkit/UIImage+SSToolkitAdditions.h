//
//  UIImage+SSToolkitAdditions.h
//  SSToolkit
//
//  Created by Sam Soffes on 11/17/09.
//  Copyright 2009-2011 Sam Soffes. All rights reserved.
//

@interface UIImage (SSToolkitAdditions)

+ (UIImage *)imageNamed:(NSString *)imageName bundle:(NSString *)bundleName;

// Given baseName = @"Foo", start = 1, end = 3, an array of images will be returned with the following names:
// @"Foo0001.png", @"Foo0002.png", @"Foo0003.png"
+ (NSArray *)animationImagesWithBaseName:(NSString *)baseName start:(NSUInteger)start end:(NSUInteger)end;

- (UIImage *)initWithImage:(UIImage *)image croppedToRect:(CGRect)rect;
- (UIImage *)imageCroppedToRect:(CGRect)rect;

- (UIImage *)squareImage;

- (NSInteger)rightCapWidth;

@end
