//
//  UIApplication+SSToolkitAdditions.m
//  SSToolkit
//
//  Created by Sam Soffes on 10/20/10.
//  Copyright 2009-2010 Sam Soffes. All rights reserved.
//

#import "UIApplication+SSToolkitAdditions.h"

@implementation UIApplication (SSToolkitAdditions)

- (BOOL)isPirated {
	// Thanks @marcoarment http://twitter.com/#!/marcoarment/status/27965461020
	return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"SignerIdentity"] != nil;
}

@end
