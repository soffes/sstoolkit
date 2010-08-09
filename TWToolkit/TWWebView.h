//
//  TWWebView.h
//  TWToolkit
//
//  Created by Sam Soffes on 4/26/10.
//  Copyright 2010 Tasteful Works, Inc. All rights reserved.
//
//  This class is a wrapper for UIWebView that makes many common
//  and usually difficult tasks very simple. Note that this class
//  doesn't actually inherit from UIWebView, but instead forwards
//  all of UIWebView's public methods to an internal instance.
//  It has been designed to be a drop in replacement for UIWebView.
//  
//  Things of interest are the TWWebView properties and the extra
//  delegate methods.
//

@protocol TWWebViewDelegate;

@interface TWWebView : UIView <UIWebViewDelegate> {

	id<TWWebViewDelegate> _delegate;
	 
	UIWebView *_webView;
	NSURLRequest *_lastRequest;
	BOOL _testedDOM;
	BOOL _DOMloaded;
	BOOL _scrollEnabled;
	BOOL _bounces;
	BOOL _shadowsHidden;
	BOOL _consoleEnabled;
	NSString *_persistedCSS;
}

// TWWebView Properties
@property (nonatomic, assign) id<TWWebViewDelegate> delegate;
@property (nonatomic, readonly, getter=isLoading) BOOL loading;
@property (nonatomic, assign) BOOL scrollEnabled;
@property (nonatomic, assign) BOOL bounces;
@property (nonatomic, assign) BOOL shadowsHidden;
@property (nonatomic, assign) BOOL consoleEnabled;
@property (nonatomic, retain, readonly) NSURLRequest *lastRequest;

// UIWebView Properties
@property (nonatomic, readonly) BOOL canGoBack;
@property (nonatomic, readonly) BOOL canGoForward;
@property (nonatomic) UIDataDetectorTypes dataDetectorTypes;
@property (nonatomic, readonly, getter=isLoadingRequest) BOOL loadingRequest;
@property (nonatomic, readonly, retain) NSURLRequest *request;
@property (nonatomic) BOOL scalesPageToFit;

// TWWebViewMethods
- (void)dismissKeyboard;
- (void)injectCSS:(NSString *)string;
- (void)injectCSS:(NSString *)string persist:(BOOL)persist;

// Convenience Methods
- (void)loadHTMLString:(NSString *)string;
- (void)loadURL:(NSURL *)aURL;
- (void)loadURLString:(NSString *)string;

// UIWebView Methods
- (void)goBack;
- (void)goForward;
- (void)loadData:(NSData *)data MIMEType:(NSString *)MIMEType textEncodingName:(NSString *)encodingName baseURL:(NSURL *)baseURL;
- (void)loadHTMLString:(NSString *)string baseURL:(NSURL *)baseURL;
- (void)loadRequest:(NSURLRequest *)aRequest;
- (void)reload;
- (void)stopLoading;
- (NSString *)stringByEvaluatingJavaScriptFromString:(NSString *)script;

@end


@protocol TWWebViewDelegate <NSObject>

@optional

// TWWebViewDelegate
- (void)webViewDidStartLoading:(TWWebView *)aWebView;
- (void)webViewDidLoadDOM:(TWWebView *)aWebView;
- (void)webViewDidFinishLoading:(TWWebView *)aWebView;

// UIWebViewDelegate
- (void)webView:(TWWebView *)aWebView didFailLoadWithError:(NSError *)error;
- (BOOL)webView:(TWWebView *)aWebView shouldStartLoadWithRequest:(NSURLRequest *)aRequest navigationType:(UIWebViewNavigationType)navigationType;
- (void)webViewDidFinishLoad:(TWWebView *)aWebView;
- (void)webViewDidStartLoad:(TWWebView *)aWebView;

@end
