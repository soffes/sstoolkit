//
//  SSNavigationController.h
//  SSToolkit
//
//  Created by Sam Soffes on 10/15/10.
//  Copyright 2009-2010 Sam Soffes. All rights reserved.
//

#import "SSModalViewController.h"

@class SSViewController;

// This subclass of UINavigationController is intended to be used with
// presentCustomModalViewController. It contains a hack to postion nav bar
// that assumes we are a modal view controller and mosty likely that will
// look wrong in any other scenario.
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
