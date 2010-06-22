//
//  UIViewController+displayError.h
//  TWToolkit
//
//  Created by Sam Soffes on 6/21/10.
//  Copyright 2010 Tasteful Works, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (displayError)

- (void)displayError:(NSError *)error;
- (void)displayErrorString:(NSString *)string;

@end
