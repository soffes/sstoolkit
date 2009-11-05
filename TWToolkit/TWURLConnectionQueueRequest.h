//
//  TWURLConnectionQueueRequest.h
//  TWToolkit
//
//  Created by Sam Soffes on 11/4/09.
//  Copyright 2009 Tasteful Works, Inc. All rights reserved.
//

@class TWURLRequest;
@protocol TWURLConnectionDelegate;

@interface TWURLConnectionQueueRequest : NSObject {

	TWURLRequest *request;
	NSUInteger priority;
	id<TWURLConnectionDelegate> delegate;
}

@property (nonatomic, retain) TWURLRequest *request;
@property (nonatomic, assign) NSUInteger priority;
@property (nonatomic, assign) id<TWURLConnectionDelegate> delegate;

- (id)initWithRequest:(TWURLRequest *)aRequest delegate:(id<TWURLConnectionDelegate>)aDelegate priority:(NSUInteger)aPriority;

@end
