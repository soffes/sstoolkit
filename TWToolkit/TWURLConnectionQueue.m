//
//  TWURLConnectionQueue.m
//  TWToolkit
//
//  Created by Sam Soffes on 11/4/09.
//  Copyright 2009 Tasteful Works, Inc. All rights reserved.
//

#import "TWURLConnectionQueue.h"
#import "TWURLConnection.h"

@interface TWURLConnectionQueue (Private)

- (TWURLRequest *)_removeNextRequestFromQueue:(BOOL)remove;

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

- (void)startRequest:(TWURLRequest *)request delegate:(id<TWURLConnectionDelegate>)delegate {
	[self startRequest:request delegate:delegate priority:1];
}


- (void)startRequest:(TWURLRequest *)request delegate:(id<TWURLConnectionDelegate>)delegate priority:(NSUInteger)priority {

	// Fix priority
	if (priority < 1) {
		priority = 1;
	}
	
	if (priority > 3) {
		priority = 3;
	}
	
	// TODO: Request
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

- (TWURLRequest *)_removeNextRequestFromQueue:(BOOL)remove; {
	// TODO: Implement
	return nil;
}

@end
