//
//  TWURLRequest+OAuth.h
//  TWToolkit
//
//  Created by Sam Soffes on 11/3/09.
//  Copyright 2009 Tasteful Works, Inc. All rights reserved.
//

#import "TWURLRequest.h"

@class OAToken;
@class OAConsumer;
@protocol OASignatureProviding;

@interface TWURLRequest (OAuth)

- (void)setOAuthConsumer:(OAConsumer *)consumer;
- (void)setOAuthConsumer:(OAConsumer *)consumer token:(OAToken *)token;
- (void)setOAuthConsumer:(OAConsumer *)consumer token:(OAToken *)token realm:(NSString *)realm signatureProvider:(id<OASignatureProviding>)signatureProvider nonce:(NSString *)nonce timestamp:(NSString *)timestamp;

@end
