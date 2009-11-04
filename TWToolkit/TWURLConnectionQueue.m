//
//  TWURLConnectionQueue.m
//  TWToolkit
//
//  Created by Sam Soffes on 11/4/09.
//  Copyright 2009 Tasteful Works, Inc. All rights reserved.
//

#import "TWURLConnectionQueue.h"

@interface TWURLConnectionQueue (Private)

- (TWURLRequest *)_nextRequest;
- (void)removeDelegate:(id<TWURLConnectionQueueDelegate>)delegate;

@end


@implementation TWURLConnectionQueue

#pragma mark -
#pragma mark Singleton Methods
#pragma mark -

+ (TWURLConnectionQueue *)defaultQueue {
	return nil;
}

#pragma mark -
#pragma mark NSObject
#pragma mark -

- (void)dealloc {
	[queue release];
	[connections release];
	[super dealloc];
}


#pragma mark -
#pragma mark Request Methods
#pragma mark -

- (void)startRequest:(TWURLRequest *)request delegate:(id<TWURLConnectionQueueDelegate>)delegate {
	[self startRequest:request delegate:delegate priority:1];
}


- (void)startRequest:(TWURLRequest *)request delegate:(id<TWURLConnectionQueueDelegate>)delegate priority:(NSUInteger)priority {

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
	
}


- (void)removeDelegate:(id<TWURLConnectionQueueDelegate>)delegate {
	
}


#pragma mark -
#pragma mark Status Methods
#pragma mark -

- (NSUInteger)requestsInQueue {
	return [queue count];
}


- (BOOL)isRequesting {
	return [self requestsInQueue] > 0;
}


#pragma mark -
#pragma mark Private Methods
#pragma mark -

- (TWURLRequest *)_nextRequest {
	return nil;
}

@end
