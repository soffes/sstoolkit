//
//  UIApplication+SSToolkitAdditions.m
//  SSToolkit
//
//  Created by Sam Soffes on 10/20/10.
//  Copyright 2010 Sam Soffes. All rights reserved.
//

#import "UIApplication+SSToolkitAdditions.h"

@implementation UIApplication (SSToolkitAdditions)

- (BOOL)isPirated {
	return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"SignerIdentity"] != nil;
}

@end
