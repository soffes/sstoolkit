//
//  TWTwitterOAuthInternalViewController.m
//  TWToolkit
//
//  Created by Sam Soffes on 11/9/09.
//  Copyright 2009 Tasteful Works, Inc. All rights reserved.
//

#import "TWTwitterOAuthInternalViewController.h"
#import "TWTwitterOAuthViewController.h"
#import "TWLoadingView.h"
#import "OAConsumer.h"
#import "OAToken.h"
#import "TWURLRequest+OAuth.h"
#import "UIView+fading.h"

@interface TWTwitterOAuthInternalViewController (Private)

- (TWTwitterOAuthViewController *)_parent;
- (void)_requestRequestToken;
- (void)_requestAccessToken;
- (void)_verifyAccessTokenWithPin:(NSString *)pin;
- (void)_requestUser;

@end


@implementation TWTwitterOAuthInternalViewController

@synthesize consumer;
@synthesize requestToken;
@synthesize accessToken;

#pragma mark -
#pragma mark NSObject
#pragma mark -

- (void)dealloc {
	[connection cancel];
	[connection release];
	[loadingView release];
	[authorizationView release];
	[super dealloc];
}


#pragma mark -
#pragma mark UIViewController
#pragma mark -

- (void)viewDidLoad {
	[super viewDidLoad];
	
	self.title = @"Authorize";
	
	// Background image
	NSString *imagePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"TWToolkit.bundle/images/twitter_oauth_background.png"];
	UIImage *backgroundImage = [UIImage imageWithContentsOfFile:imagePath];
	UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 190.0)];
	backgroundImageView.image = backgroundImage;
	backgroundImageView.opaque = YES;
	[self.view addSubview:backgroundImageView];
	[backgroundImageView release];
	self.view.backgroundColor = [UIColor colorWithRed:0.753 green:0.875 blue:0.925 alpha:1.0];
	
	// Navigation Bar
	self.navigationItem.hidesBackButton = NO;
	UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self.navigationController action:@selector(cancel:)];
	self.navigationItem.rightBarButtonItem = cancelButton;
	[cancelButton release];
	
	// Loading
	loadingView = [[TWLoadingView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width, self.view.frame.size.height)];
	loadingView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	loadingView.backgroundColor = [UIColor clearColor];
	loadingView.opaque = NO;
	[self.view addSubview:loadingView];
	
	// Web view
	authorizationView = [[UIWebView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width, self.view.frame.size.height)];
	authorizationView.dataDetectorTypes = UIDataDetectorTypeNone;
	authorizationView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	authorizationView.delegate = self;
	authorizationView.alpha = 0.0;
	
	[self _requestRequestToken];
}


#pragma mark -
#pragma mark Private Methods
#pragma mark -

- (TWTwitterOAuthViewController *)_parent {
	return (TWTwitterOAuthViewController *)self.navigationController;
}


// Step 1
- (void)_requestRequestToken {

	// Update loading text
	loadingView.text = @"Requesting token...";
	
	// Perform request for request token
	NSURL *url = [[NSURL alloc] initWithString:@"http://twitter.com/oauth/request_token"];
	TWURLRequest *request = [[TWURLRequest alloc] initWithURL:url];
	[request setDataType:TWURLRequestDataTypeString];
	[request setHTTPMethod:@"POST"];
	[request setOAuthConsumer:[[self _parent] consumer]];
	[url release];
	connection = [[TWURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
	[request release];
}


// Step 2
- (void)_requestAccessToken {	
	loadingView.text = @"Authorizing...";
	
	NSString *urlString = [[NSString alloc] initWithFormat:@"http://twitter.com/oauth/authorize?oauth_token=%@&oauth_callback=oob", requestToken.key];
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


// Step 3
- (void)_verifyAccessTokenWithPin:(NSString *)pin {
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


// Step 4
- (void)_requestUser {
//	loadingView.text = @"Loading user...";
}


#pragma mark -
#pragma mark TWURLConnectionDelegate
#pragma mark -

- (void)connection:(TWURLConnection *)aConnection failedWithError:(NSError *)error {
	if ([[[self _parent] delegate] respondsToSelector:@selector(twitterOAuthViewController:didFailWithError:)]) {
		[[[self _parent] delegate] twitterOAuthViewController:[self _parent] didFailWithError:error];
	}
}


- (void)connection:(TWURLConnection *)aConnection didFinishLoadingWithResult:(id)result {
	
	NSString *path = [[aConnection.request URL] path];
	
	// Step 1 - Request token
	if ([path isEqualToString:@"/oauth/request_token"]) {
		
		NSString *httpBody = (NSString *)result;
		
		// Check for token error
		if ([httpBody isEqualToString:@"Failed to validate oauth signature and token"]) {
			if ([[[self _parent] delegate] respondsToSelector:@selector(twitterOAuthViewController:didFailWithError:)]) {
				NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:httpBody, NSLocalizedDescriptionKey, nil];
				NSError *error = [NSError errorWithDomain:@"com.tasetfulworks.twtwitteroauthviewcontroller" code:-1 userInfo:userInfo];
				[[[self _parent] delegate] twitterOAuthViewController:[self _parent] didFailWithError:error];
			}
			return;
		}
		
		// Store token
		requestToken = [[OAToken alloc] initWithHTTPResponseBody:httpBody];
		
		// Check for token error
		if (!requestToken.key || !requestToken.secret) {
			if ([[[self _parent] delegate] respondsToSelector:@selector(twitterOAuthViewController:didFailWithError:)]) {
				NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:@"The request token could not be generated", NSLocalizedDescriptionKey, nil];
				NSError *error = [NSError errorWithDomain:@"com.tasetfulworks.twtwitteroauthviewcontroller" code:-1 userInfo:userInfo];
				[[[self _parent] delegate] twitterOAuthViewController:[self _parent] didFailWithError:error];
			}
			return;
		}
		
		// Start authorizing
		[self _requestAccessToken];
	}
	
	// Step 2 - Access token
	else if ([path isEqualToString:@"/oauth/access_token"]) {
		
		// ---- Store token ----
		accessToken = [[OAToken alloc] initWithHTTPResponseBody:(NSString *)result];
		
		// ---- Lookup user ----
		[connection cancel];
		[connection release];
		
		// Build Request
		NSURL *url = [[NSURL alloc] initWithString:@"http://twitter.com/account/verify_credentials.json"];
		TWURLRequest *request = [[TWURLRequest alloc] initWithURL:url];
		request.dataType = TWURLRequestDataTypeJSONDictionary;
		[request setOAuthConsumer:consumer token:accessToken];
		[url release];
		
		// Request
		connection = [[TWURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
	}
	
	// Step 4 - User lookup
	if ([path isEqualToString:@"/account/verify_credentials.json"]) {
		
		// Notify delegate
		if ([[[self _parent] delegate] respondsToSelector:@selector(twitterViewController:didAuthorizeWithAccessToken:userDictionary:)]) {
			[[[self _parent] delegate] twitterOAuthViewController:[self _parent] didAuthorizeWithAccessToken:accessToken userDictionary:(NSDictionary *)result];
		}
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
	
	// Check for pin
	NSString *pin = [authorizationView stringByEvaluatingJavaScriptFromString:@"document.getElementById('oauth_pin').innerText"];
	if ([pin length] == 7) {
		[self _verifyAccessTokenWithPin:(NSString *)pin];
	} else {
		// TODO: Handle invalid pin
		NSLog(@"Invalid pin");
	}
}


- (void)webViewDidStartLoad:(UIWebView *)webView {
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

@end
