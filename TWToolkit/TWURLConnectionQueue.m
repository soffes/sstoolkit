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

- (TWURLConnectionQueueRequest *)_nextQueueRequest;
- (void)_removeRequestFromQueue:(TWURLConnectionQueueRequest *)queueRequest;

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

- (TWURLConnectionQueueRequest *)addRequest:(TWURLRequest *)request delegate:(id<TWURLConnectionDelegate>)delegate {
	return [self addRequest:request delegate:delegate priority:1];
}


- (TWURLConnectionQueueRequest *)addRequest:(TWURLRequest *)request delegate:(id<TWURLConnectionDelegate>)delegate priority:(NSUInteger)priority {
	TWURLConnectionQueueRequest *queueRequest = [[[TWURLConnectionQueueRequest alloc] initWithRequest:request delegate:delegate priority:priority] autorelease];
	[self addQueueRequest:queueRequest];
	return queueRequest;
}


- (void)addQueueRequest:(TWURLConnectionQueueRequest *)queueRequest {
	// TODO: Post notification
	// TODO: Insert pased on priority
	[queue addObject:queueRequest];
	
	// TODO: Check to see if we need to start the request
}


- (void)cancelQueueRequest:(TWURLConnectionQueueRequest *)queueRequest {
	// TODO: Implement
}


- (void)cancelQueueRequests:(NSArray *)queueRequests {
	for (TWURLConnectionQueueRequest *queueRequest in queueRequests) {
		[self cancelQueueRequest:queueRequest];
	}
}


- (NSArray *)queueRequestsBelongingTo:(id<TWURLConnectionDelegate>)delegate {
	// TODO: Implement
	return nil;
}


- (void)cancelQueueRequestsBelongingTo:(id<TWURLConnectionDelegate>)delegate {
	[self cancelQueueRequests:[self queueRequestsBelongingTo:delegate]];
}


- (void)removeDelegate:(id<TWURLConnectionDelegate>)delegate {
	for (TWURLConnection *connection in connections) {
		if (connection.delegate == delegate) {
			connection.delegate = nil;
		}
	}
}


- (NSArray *)queueRequestsWithRequest:(TWURLRequest *)request {
	// TODO: Implement
	return nil;
}


#pragma mark -
#pragma mark Status Methods
#pragma mark -

- (NSUInteger)queueRequestsInQueue {
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


- (BOOL)isLoadingQueueRequest:(TWURLConnectionQueueRequest *)queueRequest {
	// TODO: Implement
	return NO;
}


#pragma mark -
#pragma mark Private Methods
#pragma mark -

- (TWURLConnectionQueueRequest *)_nextQueueRequest {
	// TODO: Implement
	return nil;
}


- (void)_removeQueueRequestFromQueue:(TWURLConnectionQueueRequest *)queueRequest {
	// TODO: Implement	
}

@end
