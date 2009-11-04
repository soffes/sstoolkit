//
//  TWURLConnectionQueue.h
//  TWToolkit
//
//  Created by Sam Soffes on 11/4/09.
//  Copyright 2009 Tasteful Works, Inc. All rights reserved.
//

#import "TWURLConnectionQueueDelegate.h"

@class TWURLRequest;

@interface TWURLConnectionQueue : NSObject {

	NSMutableArray *queue;
	NSMutableArray *connections;
	NSMutableDictionary *delegates;
}

+ (TWURLConnectionQueue *)defaultQueue;

- (void)startRequest:(TWURLRequest *)request delegate:(id<TWURLConnectionQueueDelegate>)delegate;
- (void)startRequest:(TWURLRequest *)request delegate:(id<TWURLConnectionQueueDelegate>)delegate priority:(NSUInteger)priority;

- (void)cancelRequest:(TWURLRequest *)request;
- (void)removeDelegate:(id<TWURLConnectionQueueDelegate>)delegate;

- (NSUInteger)requestsInQueue;
- (BOOL)isRequesting;

@end
