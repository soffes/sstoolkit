//
//  TWWebView.h
//  TWToolkit
//
//  Created by Sam Soffes on 4/26/10.
//  Copyright 2010 Tasteful Works, Inc. All rights reserved.
//

@protocol TWWebViewDelegate;

@interface TWWebView : UIView <UIWebViewDelegate> {

	id<TWWebViewDelegate> _delegate;
	 
	UIWebView *_webView;
	NSURLRequest *_lastRequest;
	BOOL _testedDOM;
	BOOL _DOMloaded;
	BOOL _scrollingEnabled;
}

@property (nonatomic, assign) id<TWWebViewDelegate> delegate;
@property (nonatomic, readonly, getter=isLoading) BOOL loading;
@property (nonatomic, assign) BOOL scrollingEnabled;

@property (nonatomic, readonly, getter=canGoBack) BOOL canGoBack;
@property (nonatomic, readonly, getter=canGoForward) BOOL canGoForward;
@property (nonatomic) UIDataDetectorTypes dataDetectorTypes;
@property (nonatomic, readonly, getter=isLoadingRequest) BOOL loadingRequest;
@property (nonatomic, readonly, retain) NSURLRequest *request;
@property (nonatomic) BOOL scalesPageToFit;

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

- (void)webViewDidStartLoading:(TWWebView *)aWebView;
- (void)webViewDidLoadDOM:(TWWebView *)aWebView;
- (void)webViewDidFinishLoading:(TWWebView *)aWebView;

- (void)webView:(TWWebView *)aWebView didFailLoadWithError:(NSError *)error;
- (BOOL)webView:(TWWebView *)aWebView shouldStartLoadWithRequest:(NSURLRequest *)aRequest navigationType:(UIWebViewNavigationType)navigationType;
- (void)webViewDidFinishLoad:(TWWebView *)aWebView;
- (void)webViewDidStartLoad:(TWWebView *)aWebView;

@end
