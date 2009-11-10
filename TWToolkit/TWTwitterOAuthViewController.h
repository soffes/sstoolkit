//
//  TWTwitterOAuthViewController.h
//  TWToolkit
//
//  Created by Sam Soffes on 11/3/09.
//  Copyright 2009 Tasteful Works, Inc. All rights reserved.
//

#import "TWURLConnection.h"

@class OAConsumer;
@class OAToken;
@protocol TWTwitterOAuthViewControllerDelegate;

@interface TWTwitterOAuthViewController : UINavigationController {
	
	id<TWTwitterOAuthViewControllerDelegate> delegate;
}

@property (nonatomic, assign) id<TWTwitterOAuthViewControllerDelegate> delegate;
@property (nonatomic, retain) OAConsumer *consumer;

- (id)initWithDelegate:(id<TWTwitterOAuthViewControllerDelegate>)aDelegate consumer:(OAConsumer *)aConsumer;
- (void)cancel:(id)sender;

@end


@protocol TWTwitterOAuthViewControllerDelegate <NSObject>

- (void)twitterOAuthViewControllerDidCancel:(TWTwitterOAuthViewController *)viewController;
- (void)twitterOAuthViewController:(TWTwitterOAuthViewController *)viewController didFailWithError:(NSError *)error;
- (void)twitterOAuthViewController:(TWTwitterOAuthViewController *)viewController didAuthorizeWithAccessToken:(OAToken *)accessToken userDictionary:(NSDictionary *)userDictionary;

@end
