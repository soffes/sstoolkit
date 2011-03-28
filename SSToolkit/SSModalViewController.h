//
//  SSModalViewController.h
//  SSToolkit
//
//  Created by Sam Soffes on 7/14/10.
//  Copyright 2010-2011 Sam Soffes. All rights reserved.
//

@class SSViewController;

@protocol SSModalViewController <NSObject>

@required

@property (nonatomic, assign) SSViewController *modalParentViewController;

@optional

- (BOOL)dismissCustomModalOnVignetteTap;
- (CGSize)contentSizeForViewInCustomModal;
- (CGPoint)originOffsetForViewInCustomModal;

@end
