//
//  SSWebView.m
//  SSToolkit
//
//  Created by Sam Soffes on 4/26/10.
//  Copyright 2010-2011 Sam Soffes. All rights reserved.
//

#import "SSWebView.h"
#import "NSString+SSToolkitAdditions.h"

@interface SSWebView (PrivateMethods)
- (void)_initialize;
- (void)_loadingStatusChanged;
- (void)_startLoading;
- (void)_finishedLoading;
- (void)_DOMLoaded;
@end

@implementation SSWebView {
	UIWebView *_webView;
	NSUInteger _requestCount;
	BOOL _testedDOM;
}


#pragma mark - Accessors

@synthesize delegate = _delegate;
@synthesize shadowsHidden = _shadowsHidden;
@synthesize consoleEnabled = _consoleEnabled;
@synthesize lastRequest = _lastRequest;
@synthesize loadingPage = _loadingPage;

#pragma mark - NSObject

- (void)dealloc {
	_delegate = nil;
	_webView.delegate = nil;
	[_webView stopLoading];
}


#pragma mark - UIView

- (id)initWithCoder:(NSCoder *)aDecoder {
	if ((self = [super initWithCoder:aDecoder])) {
		[self _initialize];
	}
	return self;
}


- (id)initWithFrame:(CGRect)frame {
	if ((self = [super initWithFrame:frame])) {
		[self _initialize];
	}
	return self;
}


- (void)layoutSubviews {
	_webView.frame = CGRectMake(0.0f, 0.0f, self.frame.size.width, self.frame.size.height);
}


#pragma mark - SSWebView Methods

- (void)dismissKeyboard {
	[_webView stringByEvaluatingJavaScriptFromString:@"document.activeElement.blur()"];
}


- (void)removeTextSelection {
	if (_webView.userInteractionEnabled == NO) {
		return;
	}

	_webView.userInteractionEnabled = NO;
	_webView.userInteractionEnabled = YES;
}


- (void)reset {
	BOOL loadPreviousSettings = NO;
	UIDataDetectorTypes tempDataDetectorTypes;
	BOOL tempScalesPageToFit;
	BOOL tempAllowsInlineMediaPlayback;
	BOOL tempMediaPlaybackRequiresUserAction;

	if (_webView) {
		_webView.delegate = nil;
		[_webView stopLoading];

		loadPreviousSettings = YES;
		tempDataDetectorTypes = _webView.dataDetectorTypes;
		tempScalesPageToFit = _webView.scalesPageToFit;
		tempAllowsInlineMediaPlayback = _webView.allowsInlineMediaPlayback;
		tempMediaPlaybackRequiresUserAction = _webView.mediaPlaybackRequiresUserAction;

		[_webView removeFromSuperview];
	}

	_webView = [[UIWebView alloc] initWithFrame:CGRectZero];
	_webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

	if (loadPreviousSettings) {
		_webView.dataDetectorTypes = tempDataDetectorTypes;
		_webView.scalesPageToFit = tempScalesPageToFit;
		_webView.allowsInlineMediaPlayback = tempAllowsInlineMediaPlayback;
		_webView.mediaPlaybackRequiresUserAction = tempMediaPlaybackRequiresUserAction;
	}

	_webView.delegate = self;
	[self addSubview:_webView];
    
	_lastRequest = nil;
}


#pragma mark - Convenience Methods

- (void)loadHTMLString:(NSString *)string {
	[self loadHTMLString:string baseURL:nil];
}


- (void)loadURL:(NSURL *)aURL {
	[self loadRequest:[NSURLRequest requestWithURL:aURL]];
}


- (void)loadURLString:(NSString *)string {
	if ([string length] < 5) {
		return;
	}

	if ([string hasPrefix:@"http://"] == NO && [string hasPrefix:@"https://"] == NO) {
		string = [NSString stringWithFormat:@"http://%@", string];
	}
	[self loadURL:[NSURL URLWithString:string]];
}


#pragma mark - Private Methods

- (void)_initialize {
	[self reset];
	
	_loadingPage = NO;
	_shadowsHidden = NO;
	_consoleEnabled = NO;
}


- (void)_loadingStatusChanged {
	if (self.loading == NO) {
		[self _finishedLoading];
	}
}


- (void)_startLoading {
	_loadingPage = YES;
	if ([_delegate respondsToSelector:@selector(webViewDidStartLoadingPage:)]) {
		[_delegate webViewDidStartLoadingPage:self];
	}
}


- (void)_finishedLoading {
	_loadingPage = NO;
	if ([_delegate respondsToSelector:@selector(webViewDidFinishLoadingPage:)]) {
		[_delegate webViewDidFinishLoadingPage:self];
	}
}


- (void)_DOMLoaded {
	if ([_delegate respondsToSelector:@selector(webViewDidLoadDOM:)]) {
		[_delegate webViewDidLoadDOM:self];
	}
}


#pragma mark - Getters

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


#pragma mark - Setters

- (void)setOpaque:(BOOL)o {
	[super setOpaque:o];
	_webView.opaque = o;
}


- (void)setBackgroundColor:(UIColor *)color {
	[super setBackgroundColor:color];
	_webView.backgroundColor = color;
}


- (void)setShadowsHidden:(BOOL)hide {
	if (_shadowsHidden == hide) {
		return;
	}

	_shadowsHidden = hide;

	// Thanks @flyosity http://twitter.com/flyosity/status/17951035384
	for (UIView *view in [_webView subviews]) {
		if ([view isKindOfClass:[UIScrollView class]]) {
			for (UIView *innerView in [view subviews]) {
				if ([innerView isKindOfClass:[UIImageView class]]) {
					innerView.hidden = _shadowsHidden;
				}
			}
		}
	}
}


#pragma mark - UIWebView Methods

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


- (BOOL)isLoading {
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
	_lastRequest = nil;
    
	[_webView loadData:data MIMEType:MIMEType textEncodingName:encodingName baseURL:baseURL];
}


- (void)loadHTMLString:(NSString *)string baseURL:(NSURL *)baseURL {
	_lastRequest = nil;
    
	if (!baseURL) {
		baseURL = [NSURL URLWithString:@"http://localhost/"];
	}
	[_webView loadHTMLString:string baseURL:baseURL];
}


- (void)loadRequest:(NSURLRequest *)aRequest {
	_lastRequest = nil;
    
	[_webView loadRequest:aRequest];
}


- (void)reload {
	_lastRequest = nil;
	[_webView reload];
}


- (void)stopLoading {
	[_webView stopLoading];
}


- (NSString *)stringByEvaluatingJavaScriptFromString:(NSString *)script {
	return [_webView stringByEvaluatingJavaScriptFromString:script];
}


- (UIScrollView *)scrollView {
	if (([[[UIDevice currentDevice] systemVersion] compare:@"5.0"] == NSOrderedAscending)) {
		for (UIView *view in [_webView subviews]) {
			if ([view isKindOfClass:[UIScrollView class]]) {
				return (UIScrollView *)view;
			}
		}
		return nil;
	}
	else {
		return _webView.scrollView;
	}
}


- (BOOL)allowsInlineMediaPlayback {
	return _webView.allowsInlineMediaPlayback;
}


- (void)setAllowsInlineMediaPlayback:(BOOL)allow {
	_webView.allowsInlineMediaPlayback = allow;
}


- (BOOL)mediaPlaybackRequiresUserAction {
	return _webView.mediaPlaybackRequiresUserAction;
}


- (void)setMediaPlaybackRequiresUserAction:(BOOL)requires {
	_webView.mediaPlaybackRequiresUserAction = requires;
}


#pragma mark - UIWebViewDelegate

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
	// Forward delegate message
	if ([_delegate respondsToSelector:@selector(webView:didFailLoadWithError:)]) {
		[_delegate webView:self didFailLoadWithError:error];
	}

	_requestCount--;
	if (_requestCount == 0) {
		[self _loadingStatusChanged];
	}
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)aRequest navigationType:(UIWebViewNavigationType)navigationType {
	BOOL should = YES;
	NSURL *url = [aRequest URL];
	NSString *scheme = [url scheme];

	// Check for DOM load message
	if ([scheme isEqualToString:@"x-sswebview"]) {
		NSString *host = [url host];
		if ([host isEqualToString:@"dom-loaded"]) {
			[self _DOMLoaded];
		} else if ([host isEqualToString:@"log"] && _consoleEnabled) {
			NSLog(@"[SSWebView Console] %@", [[url query] URLDecodedString]);
		}
		return NO;
	}

	// Forward delegate message
	if ([_delegate respondsToSelector:@selector(webView:shouldStartLoadWithRequest:navigationType:)]) {
		should = [_delegate webView:self shouldStartLoadWithRequest:aRequest navigationType:navigationType];
	}

	// Only load http or http requests if delegate doesn't care
	else {
		should = [scheme isEqualToString:@"http"] || [scheme isEqualToString:@"https"] || [scheme isEqualToString:@"file"];
	}

	// Stop if we shouldn't load it
	if (should == NO) {
		return NO;
	}

	// Starting a new request
	if ([[aRequest mainDocumentURL] isEqual:[_lastRequest mainDocumentURL]] == NO) {
		_lastRequest = aRequest;
		_testedDOM = NO;

		[self _startLoading];
	}

	// Child request for same page
	else {
		// Reset load timer
		[[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(_loadingStatusChanged) object:nil];
	}

	return should;
}


- (void)webViewDidFinishLoad:(UIWebView *)webView {
	// Check DOM
	if (_testedDOM == NO) {
		_testedDOM = YES;

        // The internal delegate will intercept this load and forward the event to the real delegate
        // Crazy javascript from http://dean.edwards.name/weblog/2006/06/again
		static NSString *testDOM = @"var _SSWebViewDOMLoadTimer=setInterval(function(){if(/loaded|complete/.test(document.readyState)){clearInterval(_SSWebViewDOMLoadTimer);location.href='x-sswebview://dom-loaded'}},10);";
		[self stringByEvaluatingJavaScriptFromString:testDOM];

		// Override console to pass messages to NSLog
		if (_consoleEnabled) {
			[self stringByEvaluatingJavaScriptFromString:@"console.log=function(msg){location.href='x-sswebview://log/?'+escape(msg.toString())}"];
		}
	}

	// Forward delegate message
	if ([_delegate respondsToSelector:@selector(webViewDidFinishLoad:)]) {
		[_delegate webViewDidFinishLoad:self];
	}

	_requestCount--;
	if (_requestCount == 0) {
		[self _loadingStatusChanged];
	}
}


- (void)webViewDidStartLoad:(UIWebView *)webView {
	// Forward delegate message
	if ([_delegate respondsToSelector:@selector(webViewDidStartLoad:)]) {
		[_delegate webViewDidStartLoad:self];
	}
	_requestCount++;
}

@end
