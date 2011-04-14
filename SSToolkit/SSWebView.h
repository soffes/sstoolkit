//
//  SSWebView.h
//  SSToolkit
//
//  Created by Sam Soffes on 4/26/10.
//  Copyright 2010-2011 Sam Soffes. All rights reserved.
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

@private
	NSUInteger _requestCount;

@private

	id<SSWebViewDelegate> _delegate;

	UIWebView *_webView;
	NSURLRequest *_lastRequest;
	BOOL _loadingPage;
	BOOL _bounces;
	BOOL _shadowsHidden;
	BOOL _consoleEnabled;

	BOOL _testedDOM;
}

/**
 @brief Returns whether the web view is loading a page. (read-only)

 This will return <code>YES</code> when the first NSURLRequest starts and <code>NO</code> when there
 are no more requests loading.

 Note: Setting this isn't 100% reliable since it is very hacky underneath.
 */
@property (nonatomic, readonly, getter=isLoadingPage) BOOL loadingPage;

/**
 @brief A Boolean value that determines whether scrolling is enabled.

 If the value of this property is <code>YES</code>, scrolling is enabled, and if it is <code>NO</code>,
 scrolling is disabled. The default is <code>YES</code>.

 Note: Setting this isn't 100% reliable since it is very hacky underneath.
 */
@property (nonatomic, assign) BOOL scrollEnabled;

/**
 @brief A Boolean value that controls whether the web view bounces past the edge of
 content and back again.

 If the value of this property is <code>YES</code>, the web view bounces when it encounters a boundary
 of the content. Bouncing visually indicates that scrolling has reached an edge of the content. If the
 value is <code>NO</code>, scrolling stops immediately at the content boundary without bouncing. The
 default value is <code>YES</code>.
 */
@property (nonatomic, assign) BOOL bounces;

/**
 @brief A Boolean value that controls whether the web view draws shadows around the outside
 of its content.

 If the value of this property is <code>YES</code>, the web view will the shadows around the outside of
 its content. If the value is <code>NO</code>, shadows will be displayed like normal. The default value
 is <code>NO</code>.

 Note: This isn't 100% reliable since it is very hacky underneath.
 */
@property (nonatomic, assign) BOOL shadowsHidden;

/**
 @brief A Boolean value that controls whether <code>console.log</code> messages are intercepted.

 If the value of this property is <code>YES</code>, the web view will inject some JavaScript after the
 DOM has loaded that replaces <code>console.log</code> with a custom implementation that will NSLog
 the <code>console.log</code> messages.

 Note: This isn't 100% reliable since it is very hacky underneath.
 */
@property (nonatomic, assign) BOOL consoleEnabled;

/**
 @brief The last NSURLRequest that the web view loaded
 */
@property (nonatomic, retain, readonly) NSURLRequest *lastRequest;

/**
 @brief The receiver's delegate.

 The delegate is sent messages when content is loading.
 */
@property (nonatomic, assign) id<SSWebViewDelegate> delegate;

/**
 @brief A Boolean value indicating whether the receiver is done loading content. (read-only)

 If <code>YES</code>, the receiver is still loading content; otherwise, <code>NO</code>.
 */
@property (nonatomic, readonly, getter=isLoading) BOOL loading;

/**
 @brief A Boolean value indicating whether the receiver can move backward. (read-only)

 If <code>YES</code>, able to move backward; otherwise, <code>NO</code>.
 */
@property (nonatomic, readonly) BOOL canGoBack;

/**
 @brief A Boolean value indicating whether the receiver can move forward. (read-only)

 If <code>YES</code>, able to move forward; otherwise, <code>NO</code>.
 */
@property (nonatomic, readonly) BOOL canGoForward;

/**
 @brief The URL request identifying the location of the content to load. (read-only)
 */
@property (nonatomic, readonly, retain) NSURLRequest *request;

/**
 @brief A Boolean value determining whether the webpage scales to fit the view and the user
 can change the scale.

 If <code>YES</code>, the webpage is scaled to fit and the user can zoom in and zoom out. If
 <code>NO</code>, user zooming is disabled. The default value is <code>NO</code>.
 */
@property (nonatomic, assign) BOOL scalesPageToFit;

/**
 @brief The types of data converted to clickable URLs in the web view’s content.

 You can use this property to specify the types of data (phone numbers, http links, email
 address, and so on) that should be automatically converted to clickable URLs in the web view.
 When clicked, the web view opens the application responsible for handling the URL type and
 passes it the URL.
 */
@property (nonatomic, assign) UIDataDetectorTypes dataDetectorTypes;

#ifdef __IPHONE_4_0

/**
 @brief The last UIScrollView backing the UIWebView.

 The caller <strong>must</strong> check for a nil return value and handle appropriately.
 */
@property (nonatomic, retain, readonly) UIScrollView *scrollView;

/**
 @brief A Boolean value that determines whether HTML5 videos play inline or use the native
 full-screen controller.

 The default value on iPhone is <code>NO</code>.
 */
@property (nonatomic, assign) BOOL allowsInlineMediaPlayback;

/**
 @brief A Boolean value that determines whether HTML5 videos can play automatically or require
 the user to start playing them.

 The default value on both iPad and iPhone is <code>YES</code>.
 */
@property (nonatomic, assign) BOOL mediaPlaybackRequiresUserAction;

#endif

/**
 @brief Uses JavaScript to remove focus from the active element.

 If the receiver is in a modal UIViewController with the modalPresentationStyle
 UIModalPresentationFormSheet, it will not dismiss the keyboard due to how
 UIModalPresentationFormSheet works.
 */
- (void)dismissKeyboard;

/**
 @brief Removes the text selection in the web view.

 Using Javascript to this doesn't always work as expected. This method will correctly
 remove the text selection.
 */
- (void)removeTextSelection;

/**
 @brief Destroys the internal UIWebView and recreates.

 All of the properties are maintained across the reset.
 */
- (void)reset;

/**
 @brief Sets the main page content.

 @param string The content for the main page.

 The baseURL is set to <code>http://localhost</code>

 @see loadHTMLString:baseURL:
 */
- (void)loadHTMLString:(NSString *)string;

/**
 @brief Connects to a given URL by initiating an asynchronous client request.

 @param aURL A URL identifying the location of the content to load.

 To stop this load, use the stopLoading method. To see whether the receiver is done loading the
 content, use the loading property.

 @see loadURLString:
 @see loadRequest:
 @see request
 @see stopLoading
 @see loading
 @see reload
 */
- (void)loadURL:(NSURL *)aURL;

/**
 @brief Connects to a given URL by initiating an asynchronous client request.

 @param string A string containing a URL identifying the location of the content to load.

 To stop this load, use the stopLoading method. To see whether the receiver is done loading the
 content, use the loading property.

 @see loadURL:
 @see loadRequest:
 @see request
 @see stopLoading
 @see loading
 @see reload
 */
- (void)loadURLString:(NSString *)string;


/**
 @brief Loads the previous location in the back-forward list.
 */
- (void)goBack;

/**
 @brief Loads the next location in the back-forward list.
 */
- (void)goForward;

/**
 @brief Sets the main page contents, MIME type, content encoding, and base URL.

 @param data The content for the main page.

 @param MIMEType The MIME type of the content.

 @param encodingName The IANA encoding name as in utf-8 or utf-16.

 @param baseURL The base URL for the content.
 */
- (void)loadData:(NSData *)data MIMEType:(NSString *)MIMEType textEncodingName:(NSString *)encodingName baseURL:(NSURL *)baseURL;

/**
 @brief Sets the main page content and base URL.

 @param string The content for the main page.

 @param baseURL The base URL for the content.
 */
- (void)loadHTMLString:(NSString *)string baseURL:(NSURL *)baseURL;

/**
 @brief Connects to a given URL by initiating an asynchronous client request.

 @param request A URL request identifying the location of the content to load.

 To stop this load, use the stopLoading method. To see whether the receiver is done loading the
 content, use the loading property.

 @see request
 @see stopLoading
 @see loading
 @see reload
 */
- (void)loadRequest:(NSURLRequest *)aRequest;

/**
 @brief Reloads the current page.

 @see request
 @see loading
 @see loadRequest:
 @see stopLoading
 */
- (void)reload;

/**
 @brief Stops the loading of any web content managed by the receiver.

 Stops any content in the process of being loaded by the main frame or any of its children frames.
 Does nothing if no content is being loaded.
 */
- (void)stopLoading;

/**
 @brief Returns the result of running a script.

 @param script The script to run.

 @return The result of running script or nil if it fails.

 JavaScript execution time is limited to 10 seconds for each top-level entry point. If your script
 executes for more than 10 seconds, the web view stops executing the script. This is likely to occur
 at a random place in your code, so unintended consequences may result. This limit is imposed because
 JavaScript execution may cause the main thread to block, so when scripts are running, the user is not
 able to interact with the webpage.

 JavaScript allocations are also limited to 10 MB. The web view raises an exception if you exceed this
 limit on the total memory allocation for JavaScript.
 */
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
