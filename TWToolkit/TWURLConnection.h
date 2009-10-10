//
//  TWURLConnection.h
//  TWToolkit
//
//  Created by Sam Soffes on 3/19/09.
//  Copyright 2009 Tasteful Works, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TWURLRequest.h"

@protocol TWURLConnectionDelegate;

@interface TWURLConnection : NSObject {

	id<TWURLConnectionDelegate> delegate;
	NSURLConnection *_urlConnection;
	TWURLRequest *_request;
	NSMutableData *_receivedData;
	NSInteger _totalReceivedBytes;
	NSInteger _totalExpectedBytes;
	BOOL _loading;
	
}

@property (nonatomic, assign) id<TWURLConnectionDelegate> delegate;
@property (nonatomic, copy) TWURLRequest *request;

+ (BOOL)isConnectedToNetwork;
+ (id)parseData:(NSData *)data dataType:(TWURLRequestDataType)dataType error:(NSError **)outError;

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

- (void)connection:(TWURLConnection *)aConnection startedLoadingRequest:(TWURLRequest *)aRequest;
- (void)connection:(TWURLConnection *)aConnection didReceiveBytes:(NSInteger)receivedBytes totalReceivedBytes:(NSInteger)totalReceivedBytes totalExpectedBytes:(NSInteger)totalExpectedBytes;
- (void)connection:(TWURLConnection *)aConnection didReceiveChunk:(id)chunk;
- (void)connection:(TWURLConnection *)aConnection failedToParseChunkWithError:(NSError *)error;
- (void)connection:(TWURLConnection *)aConnection didFinishLoadingRequest:(TWURLRequest *)aRequest withResult:(id)result;
- (void)connection:(TWURLConnection *)aConnection didFinishLoadingRequest:(TWURLRequest *)aRequest failedToParseResultWithError:(NSError *)error;
- (void)connection:(TWURLConnection *)aConnection failedWithError:(NSError *)error;

@end
