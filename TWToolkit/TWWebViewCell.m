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
static NSString *kDocumentTemplate = @"<!DOCTYPE html><html lang=\"en\"><head><meta charset=\"utf-8\" /><meta name=\"viewport\" content=\"width=258, user-scalable=no\" /><title>365 Days of</title><style type=\"text/css\">html,body,div,span,applet,object,iframe,h1,h2,h3,h4,h5,h6,p,blockquote,pre,a,abbr,acronym,address,big,cite,code,del,dfn,em,font,img,ins,kbd,q,s,samp,small,strike,strong,sub,sup,tt,var,dl,dt,dd,ol,ul,li,fieldset,form,label,legend,table,caption,tbody,tfoot,thead,tr,th,td{margin:0;padding:0;border:0;outline:0;font-weight:inherit;font-style:inherit;font-size:100%;font-family:inherit;vertical-align:baseline}body{line-height:1;color:black;background:white}ol,ul{list-style:none}table{border-collapse:separate;border-spacing:0}caption,th,td{text-align:left;font-weight:normal}blockquote:before,blockquote:after,q:before,q:after{content:""}blockquote,q{quotes:"" ""}.clear:after{clear:both;content:" ";display:block;height:0;zoom:1}body{-webkit-user-select:none;font-family:\"Helvetica Neue\",Helvetica;font-size:14px;}*{line-height:1.4em}a{color:#2765a5;}</style></head><body>%@</body></html>";

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
	
	NSString *document = [[NSString alloc] initWithString:@""];
	
	if ([_html length] > 1) {
		document = [[NSString alloc] initWithFormat:kDocumentTemplate, _html];
	}

	NSURL *baseURL = [[NSURL alloc] initWithString:@"about:blank"];
	[_webView loadHTMLString:document baseURL:baseURL];
	[baseURL release];
	[document release];
}

@end
