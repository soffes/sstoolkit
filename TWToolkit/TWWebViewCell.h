//
//  TWWebViewCell.h
//  TWToolkit
//
//  Created by Sam Soffes on 9/19/09.
//  Copyright 2009 Tasteful Works, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TWWebViewCell : UITableViewCell {

	UIWebView *_webView;
}

@property (nonatomic, retain, readonly) UIWebView *webView;

@end
