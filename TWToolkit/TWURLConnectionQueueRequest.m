//
//  TWURLConnectionQueueRequest.m
//  TWToolkit
//
//  Created by Sam Soffes on 11/4/09.
//  Copyright 2009 Tasteful Works, Inc. All rights reserved.
//

#import "TWURLConnectionQueueRequest.h"
#import "TWURLRequest.h"
#import "TWURLConnection.h"

@implementation TWURLConnectionQueueRequest

@synthesize request;
@synthesize priority;
@synthesize delegate;
@synthesize loading;

#pragma mark -
#pragma mark NSObject
#pragma mark -

- (id)init {
	if (self = [super init]) {
		self.loading = NO;
		timestamp = [[NSDate alloc] initWithTimeIntervalSinceNow:0];
		
		self.priority = 1;
	}
	return self;
}


- (id)initWithRequest:(TWURLRequest *)aRequest delegate:(id<TWURLConnectionDelegate>)aDelegate priority:(NSUInteger)aPriority {
	if (self = [self init]) {
		self.request = aRequest;
		self.delegate = aDelegate;
		self.priority = aPriority;
	}
	return self;
}

- (void)dealloc {
	[request release];
	[timestamp release];
	[super dealloc];
}


#pragma mark -
#pragma mark Setters
#pragma mark -

- (void)setPriority:(NSUInteger)aPriority {
	if (aPriority < 1) {
		aPriority = 1;
	}
	
	if (aPriority > 3) {
		aPriority = 3;
	}
	
	priority = aPriority;
}

@end
