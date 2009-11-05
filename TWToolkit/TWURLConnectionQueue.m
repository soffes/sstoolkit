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
		NSLog(@"INIT");
		// TODO: Check for init
		queue = [[NSMutableArray alloc] init];
		connections = [[NSMutableArray alloc] init];
		
		// Register for KVO on queue
		[self addObserver:self forKeyPath:@"queue" options:NSKeyValueChangeInsertion context:nil];
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
	// TODO: Insert pased on priority
	[queue addObject:queueRequest];
	
	// TODO: Check to see if we need to start the request
}


#pragma mark -
#pragma mark Queue Querying
#pragma mark -

- (NSArray *)queueRequestsWithPredicate:(NSPredicate *)predicate {
	return [queue filteredArrayUsingPredicate:predicate];
}


- (NSArray *)queueRequestsWithDelegate:(id<TWURLConnectionDelegate>)delegate {
	return [self queueRequestsWithPredicate:[NSPredicate predicateWithFormat:@"delegate = %@", delegate]];
}


- (NSArray *)queueRequestsWithRequest:(TWURLRequest *)request {
	return [self queueRequestsWithPredicate:[NSPredicate predicateWithFormat:@"request = %@", request]];
}


- (NSArray *)queueRequestsWithPriority:(NSUInteger)priority {
	return [self queueRequestsWithPredicate:[NSPredicate predicateWithFormat:@"priority = %u", priority]];
}


- (NSArray *)queueRequestsLoading {
	return [self queueRequestsWithPredicate:[NSPredicate predicateWithFormat:@"loading = %u", 1]];
}


- (NSArray *)queueRequestsNotLoading  {
	return [self queueRequestsWithPredicate:[NSPredicate predicateWithFormat:@"loading = %u", 0]];
}


#pragma mark -
#pragma mark Queue Manipulation
#pragma mark -

- (void)cancelQueueRequest:(TWURLConnectionQueueRequest *)queueRequest {
	// TODO: Implement
}


- (void)cancelQueueRequests:(NSArray *)queueRequests {
	for (TWURLConnectionQueueRequest *queueRequest in queueRequests) {
		[self cancelQueueRequest:queueRequest];
	}
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


#pragma mark -
#pragma mark Status Methods
#pragma mark -

- (NSUInteger)queueRequestsInQueue {
	return [queue count];
}


- (BOOL)isLoading {
	return [self connectionsLoading] > 0;
}


- (NSUInteger)connectionsLoading {
	return [connections valueForKeyPath:@"@sum.loading"];
}


#pragma mark -
#pragma mark Private Methods
#pragma mark -

- (TWURLConnectionQueueRequest *)_nextQueueRequest {
	return [queue objectAtIndex:0];
}


- (void)_removeQueueRequestFromQueue:(TWURLConnectionQueueRequest *)queueRequest {
	[queue removeObject:queueRequest];
}


#pragma mark -
#pragma mark KVO
#pragma mark -

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
	if ([self connectionsLoading] == kTWURLConnectionQueueConnections) {
		return;
	}
	
	// TODO: Implement
}

@end
