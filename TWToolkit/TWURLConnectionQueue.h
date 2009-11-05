//
//  TWURLConnectionQueue.h
//  TWToolkit
//
//  Created by Sam Soffes on 11/4/09.
//  Copyright 2009 Tasteful Works, Inc. All rights reserved.
//

#import "TWURLConnection.h"

@class TWURLRequest;
@class TWURLConnectionQueueRequest;

@interface TWURLConnectionQueue : NSObject <TWURLConnectionDelegate> {

	NSMutableArray *queue;
	NSMutableArray *connections;
}

// Singleton
+ (TWURLConnectionQueue *)defaultQueue;

// Request
- (TWURLConnectionQueueRequest *)addRequest:(TWURLRequest *)request delegate:(id<TWURLConnectionDelegate>)delegate;
- (TWURLConnectionQueueRequest *)addRequest:(TWURLRequest *)request delegate:(id<TWURLConnectionDelegate>)delegate priority:(NSUInteger)priority;
- (void)addQueueRequest:(TWURLConnectionQueueRequest *)queueRequest;

// Queue Manipulation
- (void)cancelQueueRequest:(TWURLConnectionQueueRequest *)queueRequest;
- (void)cancelQueueRequests:(NSArray *)queueRequests;
- (NSArray *)queueRequestsBelongingTo:(id<TWURLConnectionDelegate>)delegate;
- (void)cancelQueueRequestsBelongingTo:(id<TWURLConnectionDelegate>)delegate;
- (void)removeDelegate:(id<TWURLConnectionDelegate>)delegate;

// Queue Status
- (NSUInteger)queueRequestsInQueue;
- (BOOL)isLoading;
- (BOOL)isLoadingRequest:(TWURLRequest *)request;
- (BOOL)isLoadingQueueRequest:(TWURLConnectionQueueRequest *)queueRequest;

@end
