//
//  SSWebView.h
//  SSToolkit
//
//  Created by Sam Soffes on 4/26/10.
//  Copyright 2009-2010 Sam Soffes. All rights reserved.
//

@protocol SSWebViewDelegate;

/**
 @brief This class pushes UIWebView to its limits and many common
 and usually difficult tasks very simple.
 
 Note that this class doesn't actually inherit from UIWebView, but instead
 forwards all of UIWebView's public methods to an internal instance. It has
 been designed to be a drop in replacement for UIWebView.
 
 Things of interest are the SSWebView properties and the extra delegate methods.
 */
@interface SSWebView : UIView <UIWebViewDelegate> {

	id<SSWebViewDelegate> _delegate;
	 
	UIWebView *_webView;
	NSURLRequest *_lastRequest;
	BOOL _loadingPage;
	BOOL _scrollEnabled;
	BOOL _bounces;
	BOOL _shadowsHidden;
	BOOL _consoleEnabled;
	NSString *_persistedCSS;
	
@protected
	
	BOOL _testedDOM;
	BOOL _DOMloaded;
}

/**
 @brief The receiver's delegate.
 
 @section Discussion
 
 The delegate is sent messages when content is loading.
 */
@property (nonatomic, assign) id<SSWebViewDelegate> delegate;
@property (nonatomic, readonly, getter=isLoadingPage) BOOL loadingPage;
@property (nonatomic, assign) BOOL scrollEnabled;
@property (nonatomic, assign) BOOL bounces;
@property (nonatomic, assign) BOOL shadowsHidden;
@property (nonatomic, assign) BOOL consoleEnabled;
@property (nonatomic, retain, readonly) NSURLRequest *lastRequest;

/**
 @brief A Boolean value indicating whether the receiver is done loading content. (read-only)
 
 @section Discussion
 
 If YES, the receiver is still loading content; otherwise, NO.
 */
@property (nonatomic, readonly, getter=isLoading) BOOL loading;

/**
 @brief A Boolean value indicating whether the receiver can move backward. (read-only)
 
 @section Discussion
 
 If YES, able to move backward; otherwise, NO.
 */
@property (nonatomic, readonly) BOOL canGoBack;

/**
 @brief A Boolean value indicating whether the receiver can move forward. (read-only)
 
 @section Discussion
 
 If YES, able to move forward; otherwise, NO.
 */
@property (nonatomic, readonly) BOOL canGoForward;

/**
 @brief The URL request identifying the location of the content to load. (read-only)
 */
@property (nonatomic, readonly, retain) NSURLRequest *request;

/**
 @brief A Boolean value determining whether the webpage scales to fit the view and the user
 can change the scale.
 
 @section Discussion
 
 If YES, the webpage is scaled to fit and the user can zoom in and zoom out. If NO, user zooming
 is disabled. The default value is NO.
 */
@property (nonatomic, assign) BOOL scalesPageToFit;

/**
 @brief The types of data converted to clickable URLs in the web view’s content.
 
 @section Discussion
 
 You can use this property to specify the types of data (phone numbers, http links, email
 address, and so on) that should be automatically converted to clickable URLs in the web view.
 When clicked, the web view opens the application responsible for handling the URL type and
 passes it the URL.
 */
@property (nonatomic, assign) UIDataDetectorTypes dataDetectorTypes;

#ifdef __IPHONE_4_0

/**
 @brief A Boolean value that determines whether HTML5 videos play inline or use the native
 full-screen controller.
 
 @section Discussion
 
 The default value on iPhone is NO.
 */
@property (nonatomic, assign) BOOL allowsInlineMediaPlayback;

/**
 @brief A Boolean value that determines whether HTML5 videos can play automatically or require
 the user to start playing them.
 
 @section Discussion
 
 The default value on both iPad and iPhone is YES.
 */
@property (nonatomic, assign) BOOL mediaPlaybackRequiresUserAction;

#endif

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
- (void)webViewDidStartLoadingPage:(SSWebView *)aWebView;
- (void)webViewDidLoadDOM:(SSWebView *)aWebView;
- (void)webViewDidFinishLoadingPage:(SSWebView *)aWebView;

// UIWebViewDelegate
- (void)webView:(SSWebView *)aWebView didFailLoadWithError:(NSError *)error;
- (BOOL)webView:(SSWebView *)aWebView shouldStartLoadWithRequest:(NSURLRequest *)aRequest navigationType:(UIWebViewNavigationType)navigationType;
- (void)webViewDidFinishLoad:(SSWebView *)aWebView;
- (void)webViewDidStartLoad:(SSWebView *)aWebView;

@end
