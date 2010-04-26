//
//  TWWebView.m
//  TWToolkit
//
//  Created by Sam Soffes on 4/26/10.
//  Copyright 2010 Tasteful Works, Inc. All rights reserved.
//

#import "TWWebView.h"

static NSTimeInterval kTWWebViewLoadDelay = 1.1;

@interface TWWebView (PrivateMethods)

- (void)_loadingStatusChanged;
- (void)_finishedLoading;

@end


@implementation TWWebView

@synthesize delegate = _delegate;

#pragma mark -
#pragma mark NSObject
#pragma mark -

- (void)dealloc {
	[_lastRequest release];
	[_webView release];
	[super dealloc];
}


#pragma mark -
#pragma mark UIView
#pragma mark -

- (id)initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:frame]) {
		_webView = [[UIWebView alloc] initWithFrame:frame];
		_webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		_webView.delegate = self;
		[self addSubview:_webView];
	}
	return self;
}


#pragma mark -
#pragma mark Private Methods
#pragma mark -

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


#pragma mark -
#pragma mark UIWebView Methods
#pragma mark -

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
	[_webView reload];
}


- (void)stopLoading {
	[_webView stopLoading];
}


- (NSString *)stringByEvaluatingJavaScriptFromString:(NSString *)script {
	return [_webView stringByEvaluatingJavaScriptFromString:script];
}


#pragma mark -
#pragma mark UIWebViewDelegate
#pragma mark -

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
	
	// Forward delegate message
	if ([_delegate respondsToSelector:@selector(webView:shouldStartLoadWithRequest:navigationType:)]) {
		should = [_delegate webView:self shouldStartLoadWithRequest:aRequest navigationType:navigationType];
	}
	
	// Only load http or http requests
	if (should) {
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
		_domLoaded = NO;
		
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
	// !!!: This might not be that reliable
	if (_domLoaded == NO && [_webView stringByEvaluatingJavaScriptFromString:@"document.domain"]) {
		_domLoaded = YES;
		
		if ([_delegate respondsToSelector:@selector(webViewDidLoadDOM:)]) {
			[_delegate webViewDidLoadDOM:self];
		}
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
