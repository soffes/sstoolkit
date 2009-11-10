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
- (NSArray *)_connectionsWithDelegate:(id<TWURLConnectionDelegate>)delegate;

@end


@implementation TWURLConnectionQueue

#pragma mark -
#pragma mark Singleton Methods
#pragma mark -

static TWURLConnectionQueue *defaultQueue = nil;

+ (TWURLConnectionQueue*)defaultQueue {
	@synchronized(self) {
		if (defaultQueue == nil) {
			defaultQueue = [[super allocWithZone:NULL] init];
		}
	}
    return defaultQueue;
}

+ (id)allocWithZone:(NSZone *)zone {
	@synchronized(self) {
		if (defaultQueue == nil) {
			defaultQueue = [super allocWithZone:zone];
			return defaultQueue;
		}
	}
	return nil;
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
		queue = [[NSMutableArray alloc] init];
		connections = [[NSMutableArray alloc] init];
		
		// Register KVO observer
		[self addObserver:self forKeyPath:@"@sum.queue" options:NSKeyValueObservingOptionNew context:nil];
	}
	return self;
}


- (void)dealloc {
	[queue release];
	[connections release];
	[super dealloc];
}


#pragma mark -
#pragma mark Requesting
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
	// TODO: Insert pased on priority
	// KVO is used to start requests
	[queue addObject:queueRequest];
	
	// Check to see if we need to spawn a request
	NSUInteger connectionsLoading = [self connectionsLoading];
	if (connectionsLoading == kTWURLConnectionQueueConnections) {
		return;
	}
	
	// Spawn a new connection if under limit
	if (connectionsLoading < kTWURLConnectionQueueConnections) {
		TWURLConnection *connection = [[TWURLConnection alloc] initWithRequest:queueRequest.request delegate:queueRequest.delegate];
		queueRequest.connection = connection;
		[connection start];
	}
	
	// There are already the maximum number of connections loading.
	// The request will wait until it gets to the top of the queue.
}


#pragma mark -
#pragma mark Queue Manipulation
#pragma mark -

- (void)cancelQueueRequest:(TWURLConnectionQueueRequest *)queueRequest {
	
	// Cancel request
	[queueRequest.connection cancel];
	
	// Remove references to delegate
	queueRequest.connection.delegate = nil;
	queueRequest.delegate = nil;
	
	// Stop request
	[queueRequest.connection release];
	queueRequest.connection = nil;
	
	// Remove request from queue
	[queue removeObject:queueRequest];
}


- (void)cancelQueueRequests:(NSArray *)queueRequests {
	if (!queueRequests || [queueRequests count] == 0) {
		return;
	}
	
	for (TWURLConnectionQueueRequest *queueRequest in queueRequests) {
		[self cancelQueueRequest:queueRequest];
	}
}


- (void)cancelQueueRequestsWithDelegate:(id<TWURLConnectionDelegate>)delegate {
	[self cancelQueueRequests:[self queueRequestsWithDelegate:delegate]];
}


- (void)removeDelegate:(id<TWURLConnectionDelegate>)delegate {
	NSArray *someConnections = [self _connectionsWithDelegate:delegate];
	if ([someConnections count] > 0) {
		[someConnections makeObjectsPerformSelector:@selector(setDelegate:) withObject:nil];
	}
}


#pragma mark -
#pragma mark Queue Querying
#pragma mark -

- (NSArray *)queueRequestsWithPredicate:(NSPredicate *)predicate {
	return [queue filteredArrayUsingPredicate:predicate];
}


- (NSArray *)queueRequestsWithDelegate:(id<TWURLConnectionDelegate>)delegate {
	NSMutableArray *results = [[NSMutableArray alloc] init];
    for (TWURLConnectionQueueRequest *queueRequest in queue) {
        if (queueRequest.delegate == delegate) {
			[results addObject:queueRequest];
        }
    }
    return [results autorelease];
}


- (NSArray *)queueRequestsWithRequest:(TWURLRequest *)request {
	NSMutableArray *results = [[NSMutableArray alloc] init];
    for (TWURLConnectionQueueRequest *queueRequest in queue) {
        if (queueRequest.request == request) {
			[results addObject:queueRequest];
        }
    }
    return [results autorelease];
}


- (NSArray *)queueRequestsWithPriority:(NSUInteger)priority {
	return [self queueRequestsWithPredicate:[NSPredicate predicateWithFormat:@"priority = %u", priority]];
}


- (NSArray *)queueRequestsWithConnection:(TWURLConnection *)connection {
	NSMutableArray *results = [[NSMutableArray alloc] init];
    for (TWURLConnectionQueueRequest *queueRequest in queue) {
        if (queueRequest.connection == connection) {
			[results addObject:queueRequest];
        }
    }
    return [results autorelease];
}


- (NSArray *)queueRequestsLoading {
	return [self queueRequestsWithPredicate:[NSPredicate predicateWithFormat:@"loading = %u", 1]];
}


- (NSArray *)queueRequestsNotLoading {
	return [self queueRequestsWithPredicate:[NSPredicate predicateWithFormat:@"loading = %u", 0]];
}


- (NSUInteger)queueRequestsInQueue {
	return [queue count];
}


#pragma mark -
#pragma mark Connection Status
#pragma mark -

- (BOOL)isLoading {
	return [self connectionsLoading] > 0;
}


- (NSUInteger)connectionsLoading {
	return [[connections valueForKeyPath:@"@sum.loading"] unsignedIntegerValue];
}


#pragma mark -
#pragma mark Private Methods
#pragma mark -

- (TWURLConnectionQueueRequest *)_nextQueueRequest {
	return [queue objectAtIndex:0];
}


- (NSArray *)_connectionsWithDelegate:(id<TWURLConnectionDelegate>)delegate {
	NSMutableArray *results = [[NSMutableArray alloc] init];
    for (TWURLConnection *connection in connections) {
        if (connection.delegate == delegate) {
			[results addObject:connection];
        }
    }
    return [results autorelease];
}

@end
