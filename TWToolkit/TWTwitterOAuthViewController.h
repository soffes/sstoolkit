//
//  TWTwitterOAuthViewController.h
//  TWToolkit
//
//  Created by Sam Soffes on 11/3/09.
//  Copyright 2009 Tasteful Works, Inc. All rights reserved.
//

#import "TWURLConnection.h"

@class TWLoadingView;
@class OAConsumer;
@class OAToken;
@protocol TWTwitterOAuthViewControllerDelegate;

@interface TWTwitterOAuthViewController : UIViewController <UIWebViewDelegate, TWURLConnectionDelegate> {
	
	id<TWTwitterOAuthViewControllerDelegate> delegate;
	
	UIWebView *authorizationView;
	TWLoadingView *loadingView;
	
	TWURLConnection *connection;
	OAToken *requestToken;
	OAToken *accessToken;
	OAConsumer *consumer;
}

@property (nonatomic, assign) id<TWTwitterOAuthViewControllerDelegate> delegate;
@property (nonatomic, retain) OAConsumer *consumer;

- (id)initWithDelegate:(id<TWTwitterOAuthViewControllerDelegate>)aDelegate consumer:(OAConsumer *)aConsumer;

@end



@protocol TWTwitterOAuthViewControllerDelegate <NSObject>

- (void)twitterOAuthViewController:(TWTwitterOAuthViewController *)viewController didFailWithError:(NSError *)error;
- (void)twitterOAuthViewController:(TWTwitterOAuthViewController *)viewController didAuthorizeWithAccessToken:(OAToken *)accessToken userDictionary:(NSDictionary *)userDictionary;

@end
