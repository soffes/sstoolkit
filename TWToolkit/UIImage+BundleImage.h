//
//  UIImage+BundleImage.h
//  TWToolkit
//
//  Created by Sam Soffes on 11/17/09.
//  Copyright 2009 Tasteful Works, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (BundleImage)

+ (UIImage *)imageNamed:(NSString *)imageName bundle:(NSString *)bundleName;

@end
