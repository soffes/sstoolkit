//
//  TWTwitterOAuthInternalViewController.h
//  TWToolkit
//
//  Created by Sam Soffes on 11/9/09.
//  Copyright 2009 Tasteful Works, Inc. All rights reserved.
//

#import "TWURLConnection.h"

@class TWLoadingView;
@class OAConsumer;
@class OAToken;

@interface TWTwitterOAuthInternalViewController : UIViewController <UIWebViewDelegate, TWURLConnectionDelegate> {

	TWLoadingView *loadingView;
	UIWebView *authorizationView;
	
	TWURLConnection *connection;
	OAConsumer *consumer;
	OAToken *requestToken;
	OAToken *accessToken;
}

@property (nonatomic, retain) OAConsumer *consumer;
@property (nonatomic, retain) OAToken *requestToken;
@property (nonatomic, retain) OAToken *accessToken;

@end
