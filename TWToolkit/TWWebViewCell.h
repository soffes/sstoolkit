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
	NSString *_html;
	
	CGFloat _webViewWidth;
}

@property (nonatomic, retain, readonly) UIWebView *webView;
@property (nonatomic, copy) NSString *html;

+ (CGFloat)heightForHTML:(NSString *)html;
+ (NSString *)documentHTMLForBodyHTML:(NSString *)html;

@end
