//
//  SSWebViewController.h
//  SSToolKit
//
//  Created by Sam Soffes on 7/28/12.
//  Copyright 2012 Sam Soffes. All rights reserved.
//

#import "SSWebView.h"

#import <MessageUI/MessageUI.h>

@interface SSWebViewController : UIViewController <SSWebViewDelegate, UIActionSheetDelegate, MFMailComposeViewControllerDelegate>

@property (nonatomic, assign) BOOL useToolbar;
@property (nonatomic, readonly, copy) NSURL *currentURL;

- (void)loadURL:(NSURL *)url;

@end
