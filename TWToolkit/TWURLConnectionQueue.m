//
//  TWURLConnectionQueue.m
//  TWToolkit
//
//  Created by Sam Soffes on 11/4/09.
//  Copyright 2009 Tasteful Works, Inc. All rights reserved.
//

#import "TWURLConnectionQueue.h"
#import "TWURLConnection.h"
#import "TWURLConnectionQueueRequest.h"

#define kTWURLConnectionQueueConnections 3

@interface TWURLConnectionQueue (Private)

- (TWURLRequest *)_nextRequest;
- (void)_removeRequestFromQueue:(TWURLRequest *)request;

@end


@implementation TWURLConnectionQueue

#pragma mark -
#pragma mark Singleton Methods
#pragma mark -

static TWURLConnectionQueue *defaultQueue = nil;

+ (TWURLConnectionQueue*)defaultQueue {
    if (defaultQueue == nil) {
        defaultQueue = [[super allocWithZone:NULL] init];
    }
    return defaultQueue;
}

+ (id)allocWithZone:(NSZone *)zone {
    return [[self defaultQueue] retain];
}

- (id)copyWithZone:(NSZone *)zone {
    return self;
}

- (id)retain {
    return self;
}

- (NSUInteger)retainCount {
    return NSUIntegerMax;  // Denotes an object that cannot be released
}

- (void)release {
    // Do nothing
}

- (id)autorelease {
    return self;
}

#pragma mark -
#pragma mark NSObject
#pragma mark -

- (id)init {
	if (self = [super init]) {
		NSLog(@"INIT");
		// TODO: Check for init
		queue = [[NSMutableArray alloc] init];
		connections = [[NSMutableArray alloc] init];
	}
	return self;
}


- (void)dealloc {
	[queue release];
	[connections release];
	[super dealloc];
}


#pragma mark -
#pragma mark Request Methods
#pragma mark -

- (void)addRequest:(TWURLRequest *)request delegate:(id<TWURLConnectionDelegate>)delegate {
	[self addRequest:request delegate:delegate priority:1];
}


- (void)addRequest:(TWURLRequest *)request delegate:(id<TWURLConnectionDelegate>)delegate priority:(NSUInteger)priority {
	TWURLConnectionQueueRequest *queueRequest = [[TWURLConnectionQueueRequest alloc] initWithRequest:request delegate:delegate priority:priority];
	[self addQueueRequest:queueRequest];
	[queueRequest release];	
}


- (void)addQueueRequest:(TWURLConnectionQueueRequest *)queueRequest {
	// TODO: Post notification
	// TODO: Insert pased on priority
	[queue addObject:queueRequest];
	
	// TODO: Check to see if we need to start the request
}


- (void)cancelRequest:(TWURLRequest *)request {
	// TODO: Implement
}


- (void)cancelRequests:(NSArray *)requests {
	for (TWURLRequest *request in requests) {
		[self cancelRequest:request];
	}
}


- (NSArray *)requestsBelongingTo:(id<TWURLConnectionDelegate>)delegate {
	// TODO: Implement
	return nil;
}


- (void)cancelRequestsBelongingTo:(id<TWURLConnectionDelegate>)delegate {
	// TODO: Implement
}


- (void)removeDelegate:(id<TWURLConnectionDelegate>)delegate {
	for (TWURLConnection *connection in connections) {
		if (connection.delegate == delegate) {
			connection.delegate = nil;
		}
	}
}


#pragma mark -
#pragma mark Status Methods
#pragma mark -

- (NSUInteger)requestsInQueue {
	return [queue count];
}


- (BOOL)isLoading {
	for (TWURLConnection *connection in connections) {
		if ([connection isLoading]) {
			return YES;
		}
	}
	return NO;
}


- (BOOL)isLoadingRequest:(TWURLRequest *)request {
	// TODO: Implement
	return NO;
}


#pragma mark -
#pragma mark Private Methods
#pragma mark -

- (TWURLRequest *)_nextRequest {
	// TODO: Implement
	return nil;
}


- (void)_removeRequestFromQueue:(TWURLRequest *)request {
	// TODO: Implement	
}

@end
