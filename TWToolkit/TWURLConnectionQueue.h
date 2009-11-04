//
//  TWURLConnectionQueue.h
//  TWToolkit
//
//  Created by Sam Soffes on 11/4/09.
//  Copyright 2009 Tasteful Works, Inc. All rights reserved.
//

#import "TWURLConnection.h"

@class TWURLRequest;

@interface TWURLConnectionQueue : NSObject <TWURLConnectionDelegate> {

	NSMutableArray *queue;
	NSMutableArray *connections;
}

+ (TWURLConnectionQueue *)defaultQueue;

- (void)startRequest:(TWURLRequest *)request delegate:(id<TWURLConnectionDelegate>)delegate;
- (void)startRequest:(TWURLRequest *)request delegate:(id<TWURLConnectionDelegate>)delegate priority:(NSUInteger)priority;

- (void)cancelRequest:(TWURLRequest *)request;
- (void)cancelRequests:(NSArray *)requests;
- (NSArray *)requestsBelongingTo:(id<TWURLConnectionDelegate>)delegate;
- (void)cancelRequestsBelongingTo:(id<TWURLConnectionDelegate>)delegate;
- (void)removeDelegate:(id<TWURLConnectionDelegate>)delegate;

- (NSUInteger)requestsInQueue;
- (BOOL)isLoading;
- (BOOL)isLoadingRequest:(TWURLRequest *)request;

@end
