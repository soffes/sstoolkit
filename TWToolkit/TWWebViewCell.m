//
//  TWWebViewCell.m
//  TWToolkit
//
//  Created by Sam Soffes on 9/19/09.
//  Copyright 2009 Tasteful Works, Inc. All rights reserved.
//

#import "TWWebViewCell.h"
#import "UIWebView+scrolling.h"

static CGFloat margin = 10.0;

@implementation TWWebViewCell

@synthesize webView = _webView;

#pragma mark -
#pragma mark NSObject
#pragma mark -

- (void)dealloc {
	[_webView release];
	[super dealloc];
}

#pragma mark -
#pragma mark UITableViewCell
#pragma mark -

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // Cell defaults
		self.selectionStyle = UITableViewCellSelectionStyleNone;
		
		// Web view
		_webView = [[UIWebView alloc] init];
		[self.contentView addSubview:_webView];
    }
    return self;
}


#pragma mark -
#pragma mark UIView
#pragma mark -

- (void)layoutSubview {
	[super layoutSubviews];
	_webView.frame = CGRectMake(margin, margin, 
								self.contentView.frame.size.width - (margin * 2.0), 
								self.contentView.frame.size.height - (margin * 2.0));
}

@end
