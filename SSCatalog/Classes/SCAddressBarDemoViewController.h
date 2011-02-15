//
//  SCAddressBarDemoViewController.h
//  SSCatalog
//
//  Created by Sam Soffes on 2/8/11.
//  Copyright 2011 Sam Soffes. All rights reserved.
//

#import <SSToolkit/SSToolkit.h>

@interface SCAddressBarDemoViewController : UIViewController <UITextFieldDelegate, SSWebViewDelegate> {
    
	SSGradientView *_headerView;
	UILabel *_titleLabel;
	SSAddressBarTextField *_addressBar;
	SSWebView *_webView;
}

+ (NSString *)title;

@end
