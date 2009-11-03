//
//  TWRemoteImageView.h
//  TWToolkit
//
//  Created by Sam Soffes on 10/9/09.
//  Copyright 2009 Tasteful Works, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TWConnection.h"

@protocol TWRemoteImageViewDelegate;

@interface TWRemoteImageView : UIView <TWConnectionDelegate> {

	id<TWRemoteImageViewDelegate> delegate;
	NSURL *URL;
	
	UIImageView *remoteImageView;
	UIImageView *placeholderImageView;
	
	@private
	
	TWConnection *connection;
}

@property (nonatomic, assign) id<TWRemoteImageViewDelegate> delegate;
@property (nonatomic, copy) NSURL *URL;
@property (nonatomic, retain, readonly) UIImageView *remoteImageView;
@property (nonatomic, retain, readonly) UIImageView *placeholderImageView;

@end


@protocol TWRemoteImageViewDelegate <NSObject>

@optional

- (void)imageView:(TWRemoteImageView *)anImageView startedLoadingRequest:(NSURLRequest *)aRequest;
- (void)imageView:(TWRemoteImageView *)anImageView didReceiveBytes:(NSInteger)receivedBytes totalReceivedBytes:(NSInteger)totalReceivedBytes totalExpectedBytes:(NSInteger)totalExpectedBytes;
- (void)imageView:(TWRemoteImageView *)anImageView didFinishLoadingRequest:(NSURLRequest *)aRequest;
- (void)imageView:(TWRemoteImageView *)anImageView failedWithError:(NSError *)error;

@end
