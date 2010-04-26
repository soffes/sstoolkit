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
	
@private
	
	UIWebView *_webView;
}

@property (nonatomic, assign) id<TWWebViewDelegate> delegate;
@property (nonatomic, readonly, getter=isLoading) BOOL loading;

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

- (void)webView:(TWWebView *)webView didFailLoadWithError:(NSError *)error;
- (BOOL)webView:(TWWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)aRequest navigationType:(UIWebViewNavigationType)navigationType;
- (void)webViewDidFinishLoad:(TWWebView *)webView;
- (void)webViewDidStartLoad:(TWWebView *)webView;
- (void)webViewDidLoadDOM:(TWWebView *)aWebView;

@end
