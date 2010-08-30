//
//  SSWebView.h
//  SSToolkit
//
//  Created by Sam Soffes on 4/26/10.
//  Copyright 2010 Sam Soffes. All rights reserved.
//
//  This class is a wrapper for UIWebView that makes many common
//  and usually difficult tasks very simple. Note that this class
//  doesn't actually inherit from UIWebView, but instead forwards
//  all of UIWebView's public methods to an internal instance.
//  It has been designed to be a drop in replacement for UIWebView.
//  
//  Things of interest are the SSWebView properties and the extra
//  delegate methods.
//

@protocol SSWebViewDelegate;

@interface SSWebView : UIView <UIWebViewDelegate> {

	id<SSWebViewDelegate> _delegate;
	 
	UIWebView *_webView;
	NSURLRequest *_lastRequest;
	BOOL _testedDOM;
	BOOL _DOMloaded;
	BOOL _loading;
	BOOL _scrollEnabled;
	BOOL _bounces;
	BOOL _shadowsHidden;
	BOOL _consoleEnabled;
	NSString *_persistedCSS;
}

// SSWebView Properties
@property (nonatomic, assign) id<SSWebViewDelegate> delegate;
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

// SSWebViewMethods
- (void)dismissKeyboard;
- (void)injectCSS:(NSString *)string;
- (void)injectCSS:(NSString *)string persist:(BOOL)persist;
- (void)reset;

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


@protocol SSWebViewDelegate <NSObject>

@optional

// SSWebViewDelegate
- (void)webViewDidStartLoading:(SSWebView *)aWebView;
- (void)webViewDidLoadDOM:(SSWebView *)aWebView;
- (void)webViewDidFinishLoading:(SSWebView *)aWebView;

// UIWebViewDelegate
- (void)webView:(SSWebView *)aWebView didFailLoadWithError:(NSError *)error;
- (BOOL)webView:(SSWebView *)aWebView shouldStartLoadWithRequest:(NSURLRequest *)aRequest navigationType:(UIWebViewNavigationType)navigationType;
- (void)webViewDidFinishLoad:(SSWebView *)aWebView;
- (void)webViewDidStartLoad:(SSWebView *)aWebView;

@end
