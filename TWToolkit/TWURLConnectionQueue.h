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

// Requesting
- (TWURLConnectionQueueRequest *)addRequest:(TWURLRequest *)request delegate:(id<TWURLConnectionDelegate>)delegate;
- (TWURLConnectionQueueRequest *)addRequest:(TWURLRequest *)request delegate:(id<TWURLConnectionDelegate>)delegate priority:(NSUInteger)priority;
- (void)addQueueRequest:(TWURLConnectionQueueRequest *)queueRequest;

// Queue Querying
- (NSArray *)queueRequestsWithPredicate:(NSPredicate *)predicate;
- (NSArray *)queueRequestsWithDelegate:(id<TWURLConnectionDelegate>)delegate;
- (NSArray *)queueRequestsWithRequest:(TWURLRequest *)request;
- (NSArray *)queueRequestsWithPriority:(NSUInteger)priority;
- (NSArray *)queueRequestsLoading;
- (NSArray *)queueRequestsNotLoading;
- (NSUInteger)queueRequestsInQueue;

// Connection Status
- (NSUInteger)connectionsLoading;
- (BOOL)isLoading;

// Queue Manipulation
- (void)cancelQueueRequest:(TWURLConnectionQueueRequest *)queueRequest;
- (void)cancelQueueRequests:(NSArray *)queueRequests;
- (void)cancelQueueRequestsWithDelegate:(id<TWURLConnectionDelegate>)delegate;
- (void)removeDelegate:(id<TWURLConnectionDelegate>)delegate;

@end
