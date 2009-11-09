//
//  TWTwitterOAuthViewController.m
//  TWToolkit
//
//  Created by Sam Soffes on 11/3/09.
//  Copyright 2009 Tasteful Works, Inc. All rights reserved.
//

#import "TWTwitterOAuthViewController.h"
#import "TWLoadingView.h"
#import "UIView+fading.h"
#import "TWURLRequest+OAuth.h"
#import "OAConsumer.h"
#import "OAToken.h"

#define kTextKey @"text"
#define kUserKey @"user"
#define kNameKey @"name"
#define kScreenNameKey @"screen_name"

@interface TWTwitterOAuthViewController (Private)

- (void)_getRequestToken;
- (void)_authorize;
- (void)_getAccessTokenWithPin:(NSString *)pin;

@end


@implementation TWTwitterOAuthViewController

@synthesize delegate;
@synthesize consumer;

#pragma mark -
#pragma mark NSObject
#pragma mark -

- (void)dealloc {
	[consumer release];
	[loadingView release];
	[authorizationView release];
	[requestToken release];
	[accessToken release];
	[connection release];
	[super dealloc];
}


#pragma mark -
#pragma mark UIViewController
#pragma mark -

- (void)viewDidLoad {
	[super viewDidLoad];
	
	self.title = @"Add Account";
	
	loadingView = [[TWLoadingView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width, self.view.frame.size.height)];
	loadingView.text = @"Requesting token..."; 
	[self.view addSubview:loadingView];
	
	// Make sure we have a consumer
	if (consumer == nil) {
		if ([delegate respondsToSelector:@selector(twitterOAuthViewController:didFailWithError:)]) {
			NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:@"TWTwitterOAuthViewController requires a valid OAConsumer to authorize.", NSLocalizedDescriptionKey, nil];
			NSError *error = [NSError errorWithDomain:@"com.tasetfulworks.twtwitteroauthviewcontroller" code:-1 userInfo:userInfo];
			[delegate twitterOAuthViewController:self didFailWithError:error];
		}
		return;
	}
	
	[self _getRequestToken];
}


#pragma mark -
#pragma mark OAuth
#pragma mark -

- (id)initWithDelegate:(id<TWTwitterOAuthViewControllerDelegate>)aDelegate consumer:(OAConsumer *)aConsumer {
	if (self = [super initWithNibName:nil bundle:nil]) {
		self.delegate = aDelegate;
		self.consumer = aConsumer;
	}
	return self;
}


- (void)_getRequestToken {
//	NSURL *url = [[NSURL alloc] initWithString:@"http://twitter.com/oauth/request_token"];
//	connection = [[TWURLConnection alloc] initWithDelegate:self];
//	connection.dataType = TWURLConnectionDataTypeString;
//	[connection requestURL:url HTTPMethod:TWURLConnectionHTTPMethodPOST additionalHeaders:nil token:nil];
//	[url release];
}


- (void)_authorize {	
	loadingView.text = @"Authorizing...";
	
	NSString *urlString = [[NSString alloc] initWithFormat:@"http://twitter.com/oauth/authorize?oauth_token=%@&oauth_callback=oob", requestToken.key];
	NSLog(@"OAuth - Authorization URL: %@", urlString);
	NSURL *url = [[NSURL alloc] initWithString:urlString];
	NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
	
	// Setup webView
	CGRect frame = self.view.frame;
	authorizationView = [[UIWebView alloc] initWithFrame:CGRectMake(0.0, 0.0, frame.size.width, frame.size.height)];
	authorizationView.dataDetectorTypes = UIDataDetectorTypeNone;
	authorizationView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	authorizationView.delegate = self;
	authorizationView.alpha = 0.0;
	[authorizationView loadRequest:request];
	[self.view addSubview:authorizationView];
	
	[request release];
	[url release];
	[urlString release];
}


- (void)_getAccessTokenWithPin:(NSString *)pin {
	loadingView.text = @"Verifying...";
	
	[authorizationView fadeOut];
	[authorizationView release];
	authorizationView = nil;	
	
//	NSString *urlString = [[NSString alloc] initWithFormat:@"http://twitter.com/oauth/access_token?oauth_token=%@&oauth_verifier=%@", requestToken.key, pin];
//	NSURL *url = [[NSURL alloc] initWithString:urlString];
//	[connection cancel];
//	[connection requestURL:url HTTPMethod:TWURLConnectionHTTPMethodPOST additionalHeaders:nil token:nil];
//	[url release];
//	[urlString release];
}

#pragma mark -
#pragma mark TWURLConnectionDelegate
#pragma mark -

- (void)connection:(TWURLConnection *)aConnection didFinishLoadingRequest:(NSURLRequest *)aRequest withResult:(id)object {
	
	NSString *path = [[aRequest URL] path];
	
	// Request Token
	if ([path isEqualToString:@"/oauth/request_token"]) {
		
		// Store token
		requestToken = [[OAToken alloc] initWithHTTPResponseBody:(NSString *)object];
		
		// Start authorizing
		[self _authorize];
	}
	
	// Access Token
	else if ([path isEqualToString:@"/oauth/access_token"]) {
		
		// Store token
		accessToken = [[OAToken alloc] initWithHTTPResponseBody:(NSString *)object];
		
		// TODO: Lookup user
//		[connection cancel];
//		[connection release];
//		connection = [[TWURLConnection alloc] initWithDelegate:self];		
//		connection.dataType = TWURLConnectionDataTypeJSONDictionary;
//		NSURL *url = [[NSURL alloc] initWithString:@"http://twitter.com/account/verify_credentials.json"];
//		[connection requestURL:url HTTPMethod:TWURLConnectionHTTPMethodGET additionalHeaders:nil token:accessToken];
//		[url release];
	}
	
	// User lookup
	if ([path isEqualToString:@"/account/verify_credentials.json"]) {
		
		//NSDictionary *user = (NSDictionary *)object;
		
		// TODO: Notify delegate of user object and tokens
	}
}


#pragma mark -
#pragma mark UIWebViewDelegate
#pragma mark -

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
	NSURL *url = [request URL];
	// TODO: allow signup too
	return ([[url host] isEqual:@"twitter.com"] && [[url path] isEqual:@"/oauth/authorize"]);
}


- (void)webViewDidFinishLoad:(UIWebView *)webView {
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
	
	// Pretty up form
	[authorizationView stringByEvaluatingJavaScriptFromString:@"$(function() {\
	 $('html, body').css({'width': '320px'});\
	 $('#header').css('width', '320px');\
	 $('#twitainer').css({'width': '300px', 'padding': '10px 0', 'overflow': 'hidden'});\
	 $('#content').css('width', '300px');\
	 $('.signin-content').css({'width': '280px', 'padding': '10px', '-webkit-border-radius': '5px'});\
	 $('h2').css({'font-size': '1.3em', 'font-family': '\\'Lucida Grande\\',sans-serif', 'margin-bottom': '12px'});\
	 $('h4').css({'font-size': '0.65em', 'font-family': '\\'Lucida Grande\\',sans-serif'});\
	 $('input[type=text], input[type=password]').css('width', '140px');\
	 \
	 var tos = $('.tos')[0].innerHTML;\
	 $('.tos').remove();\
	 $('.signin-content').append('<div style=\"font-size:0.9em;color:#888;line-height:1.3em;\">'+tos+'</div>');\
	 \
	 var deny = $('#deny');\
	 deny.remove();\
	 var buttons = $('.buttons');\
	 buttons.append(deny);\
	 deny.css({'float': 'left', 'margin-left': '43px'});\
	 $('#allow').css({'margin-right': '35px', 'margin-left': '10px', 'float': 'right'});\
	 buttons.append('<div style=\"clear:both\"></div>');\
	 \
	 $(document.body).outerWidth(320);\
	 });"];
	
	if (authorizationView.alpha != 1.0) {		
		[authorizationView fadeIn];
	} else {
		NSString *pin = [authorizationView stringByEvaluatingJavaScriptFromString:@"document.getElementById('oauth_pin').innerText"];
		NSLog(@"pin: %@", pin);
		if ([pin length] == 7) {
			[self _getAccessTokenWithPin:pin];
		}
	}
}


- (void)webViewDidStartLoad:(UIWebView *)webView {
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

@end
