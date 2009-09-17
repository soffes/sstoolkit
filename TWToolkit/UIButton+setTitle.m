//
//  UIButton+setTitle.m
//  TWToolkit
//
//  Created by Sam Soffes on 7/31/08.
//  Copyright 2009 Tasteful Works, Inc. All rights reserved.
//

#import "UIButton+setTitle.h"

@implementation UIButton (setTitle)

- (void)setTitle:(NSString *)aTitle {
	[self setTitle:aTitle forState:UIControlStateNormal];
}

@end
