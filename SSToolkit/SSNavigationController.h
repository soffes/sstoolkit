//
//  SSNavigationController.h
//  SSToolkit
//
//  Created by Sam Soffes on 10/15/10.
//  Copyright 2010 Sam Soffes. All rights reserved.
//

#import "SSModalViewController.h"

@class SSViewController;

@interface SSNavigationController : UINavigationController <SSModalViewController> {

	SSViewController *_modalParentViewController;
	BOOL _dismissCustomModalOnVignetteTap;
	CGSize _contentSizeForViewInCustomModal;
	CGPoint _originOffsetForViewInCustomModal;
}

@property (nonatomic, assign) SSViewController *modalParentViewController;
@property (nonatomic, assign) BOOL dismissCustomModalOnVignetteTap;
@property (nonatomic, assign) CGSize contentSizeForViewInCustomModal;
@property (nonatomic, assign) CGPoint originOffsetForViewInCustomModal;

@end
