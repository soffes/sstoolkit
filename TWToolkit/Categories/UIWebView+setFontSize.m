//
//  UIWebView+setFontSize.m
//  Four80
//
//  Created by Sam Soffes on 6/22/09.
//  Copyright 2009 Sam Soffes. All rights reserved.
//

#import "UIWebView+setFontSize.h"

@implementation UIWebView (setFontSize)

- (void)setFontSize:(NSInteger)fontSize {
	NSString *javascript = [[NSString alloc] initWithFormat:@"document.body.style.fontSize = '%ipx'", fontSize];
	[self stringByEvaluatingJavaScriptFromString:javascript];
	[javascript release];
}

@end
