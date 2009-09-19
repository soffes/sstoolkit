//
//  TWWebViewCell.m
//  TWToolkit
//
//  Created by Sam Soffes on 9/19/09.
//  Copyright 2009 Tasteful Works, Inc. All rights reserved.
//

#import "TWWebViewCell.h"
#import "UIWebView+scrolling.h"

static CGFloat kWebViewMargin = 5.0;
static NSString *kDocumentTemplate = @"<!DOCTYPE html><html lang=\"en\"><head><meta charset=\"utf-8\" /><meta name=\"viewport\" content=\"width=258, user-scalable=no\" /><title>365 Days of</title><style type=\"text/css\">html,body,div,a{margin:0;padding:0;border:0;outline:0;font-weight:inherit;font-style:inherit;font-size:100%%;font-family:inherit;vertical-align:baseline;}body{-webkit-user-select:none;line-height:1;color:#000;font-family:\"Helvetica Neue\",Helvetica;font-size:14px;}a{color:#2765a5;}</style></head><body>%@</body></html>";

@implementation TWWebViewCell

@synthesize webView = _webView;
@synthesize html = _html;

#pragma mark -
#pragma mark NSObject
#pragma mark -

- (void)dealloc {
	[_html release];
	[_webView release];
	[super dealloc];
}

#pragma mark -
#pragma mark UITableViewCell
#pragma mark -

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier]) {
        // Cell defaults
		self.selectionStyle = UITableViewCellSelectionStyleNone;
		
		// Web view
		_webView = [[UIWebView alloc] initWithFrame:CGRectZero];
		_webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		_webView.dataDetectorTypes = UIDataDetectorTypeLink;
		[_webView setScrollingEnabled:NO];
		[self.contentView addSubview:_webView];
    }
    return self;
}


#pragma mark -
#pragma mark UIView
#pragma mark -

- (void)layoutSubviews {
	[super layoutSubviews];
	_webView.frame = CGRectMake(kWebViewMargin, kWebViewMargin, 
								self.contentView.frame.size.width - (kWebViewMargin * 2.0), 
								self.contentView.frame.size.height - (kWebViewMargin * 2.0));
}


#pragma mark -
#pragma mark Setters
#pragma mark -

- (void)setHtml:(NSString *)html {
	[_html release];
	
	if (!html) {
		html = @"";
	}
	
	_html = [html copy];
	
	NSString *document = [[NSString alloc] initWithFormat:kDocumentTemplate, _html];
	[_webView loadHTMLString:document baseURL:[NSURL URLWithString:@"about:blank"]];
	[document release];
}

@end
