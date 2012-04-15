//
//  SSButton.m
//  SSToolkit
//
//  Created by Sam Soffes on 4/14/12.
//  Copyright (c) 2012 Sam Soffes. All rights reserved.
//

#import "SSButton.h"

@implementation SSButton

@synthesize imagePosition = _imagePosition;

- (void)layoutSubviews {
	[super layoutSubviews];
	if (_imagePosition == SSButtonImagePositionLeft) {
		return;
	}

	CGRect imageFrame = self.imageView.frame;
	CGRect labelFrame = self.titleLabel.frame;

	labelFrame.origin.x = imageFrame.origin.x - self.imageEdgeInsets.left + self.imageEdgeInsets.right;
	imageFrame.origin.x += labelFrame.size.width;

	self.imageView.frame = imageFrame;
	self.titleLabel.frame = labelFrame;
}

@end
