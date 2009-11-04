//
//  TWTwitterOAuthViewController.h
//  TWToolkit
//
//  Created by Sam Soffes on 11/3/09.
//  Copyright 2009 Tasteful Works, Inc. All rights reserved.
//

#import "TWToolkit/TWURLConnection.h"
#import "TWTwitterOAuthViewControllerDelegate.h"

@class TWLoadingView;
@class OAToken;
@class OAConsumer;

@interface TWTwitterOAuthViewController : UIViewController <UIWebViewDelegate, TWURLConnectionDelegate> {
	
	id<TWTwitterOAuthViewControllerDelegate> delegate;
	
	UIWebView *authorizationView;
	TWLoadingView *loadingView;
	
	TWURLConnection *connection;
	OAToken *requestToken;
	OAToken *accessToken;
	OAConsumer *consumer;
}

@property (nonatomic, retain) OAConsumer *consumer;

@end
