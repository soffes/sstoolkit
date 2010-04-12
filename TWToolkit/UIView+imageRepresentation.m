//
//  UIView+imageRepresentation.m
//  TWToolkit
//
//  Created by Sam Soffes on 2/15/10.
//  Copyright 2010 Tasteful Works. All rights reserved.
//

#import "UIView+imageRepresentation.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIView (imageRepresentation)

- (UIImage *)imageRepresentation {
	UIGraphicsBeginImageContext(self.bounds.size);
	[self.layer renderInContext:UIGraphicsGetCurrentContext()];
	UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return image;
}

@end
