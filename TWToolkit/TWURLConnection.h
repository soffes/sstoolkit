//
//  TWURLConnection.h
//  TWToolkit
//
//  Created by Sam Soffes on 3/19/09.
//  Copyright 2009 Tasteful Works, Inc. All rights reserved.
//

#import "TWURLRequest.h"

@protocol TWURLConnectionDelegate;

@interface TWURLConnection : NSObject {

	id<TWURLConnectionDelegate> delegate;
	TWURLRequest *request;
	NSURLConnection *_urlConnection;
	NSMutableData *_receivedData;
	NSInteger _totalReceivedBytes;
	NSInteger _totalExpectedBytes;
	BOOL _loading;
	
}

@property (nonatomic, assign) id<TWURLConnectionDelegate> delegate;
@property (nonatomic, retain) TWURLRequest *request;

+ (BOOL)isConnectedToNetwork;

- (id)initWithDelegate:(id<TWURLConnectionDelegate>)aDelegate;
- (id)initWithRequest:(TWURLRequest *)aRequest delegate:(id<TWURLConnectionDelegate>)aDelegate;
- (id)initWithRequest:(TWURLRequest *)aRequest delegate:(id<TWURLConnectionDelegate>)aDelegate startImmediately:(BOOL)startImmediately;
- (id)initWithURL:(NSURL *)aURL delegate:(id<TWURLConnectionDelegate>)aDelegate;
- (id)initWithURL:(NSURL *)aURL delegate:(id<TWURLConnectionDelegate>)aDelegate startImmediately:(BOOL)startImmediately;
- (void)start;
- (void)cancel;
- (BOOL)isLoading;

- (void)setURL:(NSURL *)aURL;
- (NSURL *)URL;

@end


@protocol TWURLConnectionDelegate <NSObject>

@optional

- (void)connectionStartedLoading:(TWURLConnection *)aConnection;
- (void)connection:(TWURLConnection *)aConnection didReceiveBytes:(NSInteger)receivedBytes totalReceivedBytes:(NSInteger)totalReceivedBytes totalExpectedBytes:(NSInteger)totalExpectedBytes;
- (void)connection:(TWURLConnection *)aConnection didReceiveChunk:(id)chunk;
- (void)connection:(TWURLConnection *)aConnection failedToParseChunkWithError:(NSError *)error;
- (void)connection:(TWURLConnection *)aConnection didFinishLoadingWithResult:(id)result;
- (void)connection:(TWURLConnection *)aConnection failedToParseResultWithError:(NSError *)error;
- (void)connection:(TWURLConnection *)aConnection didFailLoadWithError:(NSError *)error;

@end
