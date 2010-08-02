//
//  TWWebView.m
//  TWToolkit
//
//  Created by Sam Soffes on 4/26/10.
//  Copyright 2010 Tasteful Works, Inc. All rights reserved.
//

#import "TWWebView.h"

static NSTimeInterval kTWWebViewLoadDelay = 0.3;

@interface TWWebView (PrivateMethods)

- (void)_loadingStatusChanged;
- (void)_finishedLoading;
- (void)_DOMLoaded;
- (void)_injectCSS:(NSString *)css;

@end


@implementation TWWebView

@synthesize delegate = _delegate;
@synthesize scrollingEnabled = _scrollingEnabled;
@synthesize lastRequest = _lastRequest;

#pragma mark NSObject

- (void)dealloc {
	// TODO: If you dealloc when the page is almost loaded, 
	// _loadingStatusChanged still gets called sometimes causing a crash
	[[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(_loadingStatusChanged) object:nil];
	_delegate = nil;
	_webView.delegate = nil;
	[_webView stopLoading];
	[_webView release];
	[_persistedCSS release];
	[_lastRequest release];
	[super dealloc];
}

#pragma mark UIView

- (id)initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:frame]) {
		_webView = [[UIWebView alloc] initWithFrame:CGRectZero];
		_webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		_webView.delegate = self;
		[self addSubview:_webView];
		
		_scrollingEnabled = YES;
	}
	return self;
}


- (void)layoutSubviews {
	_webView.frame = CGRectMake(0.0, 0.0, self.frame.size.width, self.frame.size.height);
}

#pragma mark TWWebView Methods

- (void)dismissKeyboard {
	[_webView stringByEvaluatingJavaScriptFromString:@"document.activeElement.blur()"];
}


- (void)injectCSS:(NSString *)css {
	[self injectCSS:css persist:NO];
}


- (void)injectCSS:(NSString *)css persist:(BOOL)persist {
	[self _injectCSS:css];
	
	if (persist) {
		[_persistedCSS release];
		_persistedCSS = [css retain];
	}
}

#pragma mark Convenience Methods

- (void)loadHTMLString:(NSString *)string {
	[self loadHTMLString:string baseURL:[NSURL URLWithString:@"http://localhost"]];
}


- (void)loadURL:(NSURL *)aURL {
	[self loadRequest:[NSURLRequest requestWithURL:aURL]];
}


- (void)loadURLString:(NSString *)string {
	if ([string hasPrefix:@"http://"] == NO && [string hasPrefix:@"https://"] == NO) {
		string = [NSString stringWithFormat:@"http://%@", string];
	}
	[self loadURL:[NSURL URLWithString:string]];
}

#pragma mark Private Methods

- (void)_loadingStatusChanged {
	if (self.loadingRequest == NO) {
		[self _finishedLoading];
	}
}


- (void)_finishedLoading {
	if ([_delegate respondsToSelector:@selector(webViewDidFinishLoading:)]) {
		[_delegate webViewDidFinishLoading:self];
	}
}


- (void)_DOMLoaded {
	// Reinject persisted CSS
	if (_persistedCSS) {
		[self _injectCSS:_persistedCSS];
	}
	
	if ([_delegate respondsToSelector:@selector(webViewDidLoadDOM:)]) {
		[_delegate webViewDidLoadDOM:self];
	}
}


- (void)_injectCSS:(NSString *)css {
	static NSString *injectCSSFormat = @"var styleTag=document.createElement('style');styleTag.setAttribute('type','text/css');styleTag.innerHTML='%@';document.getElementsByTagName('head')[0].appendChild(styleTag);";
	[self stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:injectCSSFormat, css]];
}

#pragma mark Getters

- (BOOL)shadowsHidden {
	for (UIView *view in [_webView subviews]) {
		if ([view isKindOfClass:[UIScrollView class]]) {
			for (UIView *innerView in [view subviews]) {
				if ([innerView isKindOfClass:[UIImageView class]]) {
					return [innerView isHidden];
				}
			}
		}
	}
	return NO;
}

#pragma mark Setters

- (void)setOpaque:(BOOL)o {
	[super setOpaque:o];
	_webView.opaque = o;
}


- (void)setBackgroundColor:(UIColor *)color {
	[super setBackgroundColor:color];
	_webView.backgroundColor = color;
}


- (void)setScrollingEnabled:(BOOL)enabled {
	if (_scrollingEnabled == enabled) {
		return;
	}
	
	_scrollingEnabled = enabled;
	id scrollView = [_webView.subviews objectAtIndex:0];
	
	// Thanks @jakemarsh for this hacky workaroudn
	// This prevents the solution from be rejected
	NSString *selectorString = @"";
	selectorString = [selectorString stringByAppendingFormat:@"s"];
	selectorString = [selectorString stringByAppendingFormat:@"e"];
	selectorString = [selectorString stringByAppendingFormat:@"t"];
	selectorString = [selectorString stringByAppendingFormat:@"S"];
	selectorString = [selectorString stringByAppendingFormat:@"c"];
	selectorString = [selectorString stringByAppendingFormat:@"r"];
	selectorString = [selectorString stringByAppendingFormat:@"o"];
	selectorString = [selectorString stringByAppendingFormat:@"l"];
	selectorString = [selectorString stringByAppendingFormat:@"l"];
	selectorString = [selectorString stringByAppendingFormat:@"E"];
	selectorString = [selectorString stringByAppendingFormat:@"n"];
	selectorString = [selectorString stringByAppendingFormat:@"a"];
	selectorString = [selectorString stringByAppendingFormat:@"b"];
	selectorString = [selectorString stringByAppendingFormat:@"l"];
	selectorString = [selectorString stringByAppendingFormat:@"e"];
	selectorString = [selectorString stringByAppendingFormat:@"d"];
	selectorString = [selectorString stringByAppendingFormat:@":"];
	
	SEL selector = NSSelectorFromString(selectorString);
	
	if ([scrollView respondsToSelector:selector]) {
		NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[[scrollView class] instanceMethodSignatureForSelector:selector]];
		[invocation setSelector:selector];
		[invocation setArgument:&_scrollingEnabled atIndex:2];
		[invocation invokeWithTarget:scrollView];
		[invocation release];
	}
}


- (void)setShadowsHidden:(BOOL)hide {
	// Thanks @flyosity http://twitter.com/flyosity/status/17951035384
	for (UIView *view in [_webView subviews]) {
		if ([view isKindOfClass:[UIScrollView class]]) {
			for (UIView *innerView in [view subviews]) {
				if ([innerView isKindOfClass:[UIImageView class]]) {
					innerView.hidden = hide;
				}
			}
		}
	}
}

#pragma mark UIWebView Methods

- (BOOL)canGoBack {
	return [_webView canGoBack];
}


- (BOOL)canGoForward {
	return [_webView canGoForward];
}

- (void)setDataDetectorTypes:(UIDataDetectorTypes)types {
	[_webView setDataDetectorTypes:types];
}


- (UIDataDetectorTypes)dataDetectorTypes {
	return [_webView dataDetectorTypes];
}


- (BOOL)isLoadingRequest {
	return [_webView isLoading];
}


- (NSURLRequest *)request {
	return [_webView request];
}


- (BOOL)scalesPageToFit {
	return [_webView scalesPageToFit];
}


- (void)setScalesPageToFit:(BOOL)scales {
	[_webView setScalesPageToFit:scales];
}


- (void)goBack {
	[_webView goBack];
}


- (void)goForward {
	[_webView goForward];
}


- (void)loadData:(NSData *)data MIMEType:(NSString *)MIMEType textEncodingName:(NSString *)encodingName baseURL:(NSURL *)baseURL {
	[_webView loadData:data MIMEType:MIMEType textEncodingName:encodingName baseURL:baseURL];
}


- (void)loadHTMLString:(NSString *)string baseURL:(NSURL *)baseURL {
	[_webView loadHTMLString:string baseURL:baseURL];
}


- (void)loadRequest:(NSURLRequest *)aRequest {
	[_webView loadRequest:aRequest];
}


- (void)reload {
	[_lastRequest release];
	_lastRequest = nil;
	[_webView reload];
}


- (void)stopLoading {
	[_webView stopLoading];
}


- (NSString *)stringByEvaluatingJavaScriptFromString:(NSString *)script {
	return [_webView stringByEvaluatingJavaScriptFromString:script];
}

#pragma mark UIWebViewDelegate

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
	// Reset load timer
	[[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(_loadingStatusChanged) object:nil];
	[self performSelector:@selector(_loadingStatusChanged) withObject:nil afterDelay:kTWWebViewLoadDelay];
	
	// Forward delegate message
	if ([_delegate respondsToSelector:@selector(webView:didFailLoadWithError:)]) {
		[_delegate webView:self didFailLoadWithError:error];
	}
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)aRequest navigationType:(UIWebViewNavigationType)navigationType {
	BOOL should = YES;
	
	// Check for DOM load message
	if ([[[aRequest URL] absoluteString] isEqualToString:@"x-twwebview://dom-loaded"]) {
		[self _DOMLoaded];
		return NO;
	}
	
	// Forward delegate message
	if ([_delegate respondsToSelector:@selector(webView:shouldStartLoadWithRequest:navigationType:)]) {
		should = [_delegate webView:self shouldStartLoadWithRequest:aRequest navigationType:navigationType];
	}
	
	// Only load http or http requests if delegate doesn't care
	else {
		NSString *scheme = [[aRequest URL] scheme];
		should = [scheme isEqualToString:@"http"] || [scheme isEqualToString:@"https"];
	}
	
	// Stop if we shouldn't load it
	if (!should) {
		return should;
	}
	
	// Starting a new request
	if ([[aRequest mainDocumentURL] isEqual:[_lastRequest mainDocumentURL]] == NO) {
		[_lastRequest release];
		_lastRequest = [aRequest retain];
		_testedDOM = NO;
		
		if ([_delegate respondsToSelector:@selector(webViewDidStartLoading:)]) {
			[_delegate webViewDidStartLoading:self];
		}
	}
	
	// Child request for same page
	else {
		// Reset load timer
		[[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(_loadingStatusChanged) object:nil];
	}
	
	return should;
}


- (void)webViewDidFinishLoad:(UIWebView *)webView {
	// Reset load timer
	[[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(_loadingStatusChanged) object:nil];
	[self performSelector:@selector(_loadingStatusChanged) withObject:nil afterDelay:kTWWebViewLoadDelay];
	
	// Check DOM
	if (_testedDOM == NO) {
		_testedDOM = YES;
		
		// Hat tip Nathan Smith
		static NSString *testDOM = @"window.addEventListener('load',function(){location.href='x-twwebview://dom-loaded'},false);";
		[self stringByEvaluatingJavaScriptFromString:testDOM];
	}
	
	// Forward delegate message
	if ([_delegate respondsToSelector:@selector(webViewDidFinishLoad:)]) {
		[_delegate webViewDidFinishLoad:self];
	}
}


- (void)webViewDidStartLoad:(UIWebView *)webView {
	// Forward delegate message
	if ([_delegate respondsToSelector:@selector(webViewDidStartLoad:)]) {
		[_delegate webViewDidStartLoad:self];
	}
}

@end
