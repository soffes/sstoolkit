//
//  TWTwitterOAuthViewControllerDelegate.h
//  TWToolkit
//
//  Created by Sam Soffes on 11/3/09.
//  Copyright 2009 Tasteful Works, Inc. All rights reserved.
//

@class TWTwitterOAuthViewController;

@protocol TWTwitterOAuthViewControllerDelegate <NSObject>

- (void)twitterOAuthViewController:(TWTwitterOAuthViewController *)viewController didAuthorizeWithAccessToken:(OAToken *)accessToken userDictionary:(NSDictionary *)userDictionary;

@end
