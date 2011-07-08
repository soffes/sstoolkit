//
//  UIViewController+SSToolkitAdditions.h
//  SSToolkit
//
//  Created by Sam Soffes on 6/21/10.
//  Copyright 2010-2011 Sam Soffes. All rights reserved.
//

/**
 Provides extensions to `UIViewController` for various common tasks.
 */
@interface UIViewController (SSToolkitAdditions)

///------------------------
/// @name Presenting Errors
///------------------------

/**
 Present a `UIAlertView` with an error messagae.
 
 @param error Error to present.
 */
- (void)displayError:(NSError *)error;

/**
 Present a `UIAlertView` with an error messagae.
 
 @param string Error string to present.
 */
- (void)displayErrorString:(NSString *)string;

@end
