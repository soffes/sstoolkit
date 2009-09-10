//
//  TWConnection.h
//  TWToolkit
//
//  Created by Sam Soffes on 3/19/09.
//  Copyright 2009 Tasteful Works, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kTimeout 60.0

typedef enum {
	TWConnectionHTTPMethodGET,
	TWConnectionHTTPMethodPOST
} TWConnectionHTTPMethod;

typedef enum {
	TWConnectionDataTypeData,
	TWConnectionDataTypeJSONArray,
	TWConnectionDataTypeJSONDictionary,
	TWConnectionDataTypeJSON = TWConnectionDataTypeJSONArray
} TWConnectionDataType;


@protocol TWConnectionDelegate;

@interface TWConnection : NSObject {

	id<TWConnectionDelegate> delegate;
	NSURLConnection *_urlConnection;
	NSURLRequest *_request;
	NSMutableData *_receivedData;
	NSInteger _totalReceivedBytes;
	NSInteger _totalExpectedBytes;
	TWConnectionDataType _dataType;
}

@property (nonatomic, assign) id<TWConnectionDelegate> delegate;
@property (nonatomic, assign) TWConnectionDataType dataType;

+ (BOOL)isConnectedToNetwork;

- (id)initWithDelegate:(id)aDelegate;
- (void)requestURL:(NSURL *)url;
- (void)requestURL:(NSURL *)url HTTPMethod:(TWConnectionHTTPMethod)HTTPMethod;
- (void)startRequest:(NSURLRequest *)aRequest;
- (void)cancel;

@end


@protocol TWConnectionDelegate <NSObject>

@optional

- (void)connection:(TWConnection *)aConnection startedLoadingRequest:(NSURLRequest *)aRequest;
- (void)connection:(TWConnection *)aConnection didReceiveBytes:(NSInteger)receivedBytes totalReceivedBytes:(NSInteger)totalReceivedBytes totalExpectedBytes:(NSInteger)totalExpectedBytes;
- (void)connection:(TWConnection *)aConnection didFinishLoadingRequest:(NSURLRequest *)aRequest withResult:(id)object;
- (void)connection:(TWConnection *)aConnection failedWithError:(NSError *)error;

@end
