//
//  TWImageView.h
//  TWToolkit
//
//  Created by Sam Soffes on 10/9/09.
//  Copyright 2009 Tasteful Works, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TWConnection.h"

@protocol TWImageViewDelegate;

@interface TWImageView : UIView <TWConnectionDelegate> {

	id<TWImageViewDelegate> delegate;
	NSURL *URL;
	
	UIImageView *remoteImageView;
	UIImageView *placeholderImageView;
	
	@private
	
	TWConnection *connection;
}

@property (nonatomic, assign) id<TWImageViewDelegate> delegate;
@property (nonatomic, copy) NSURL *URL;
@property (nonatomic, retain, readonly) UIImageView *remoteImageView;
@property (nonatomic, retain, readonly) UIImageView *placeholderImageView;

@end


@protocol TWImageViewDelegate <NSObject>

@optional

- (void)imageView:(TWImageView *)anImageView startedLoadingRequest:(NSURLRequest *)aRequest;
- (void)imageView:(TWImageView *)anImageView didReceiveBytes:(NSInteger)receivedBytes totalReceivedBytes:(NSInteger)totalReceivedBytes totalExpectedBytes:(NSInteger)totalExpectedBytes;
- (void)imageView:(TWImageView *)anImageView didFinishLoadingRequest:(NSURLRequest *)aRequest;
- (void)imageView:(TWImageView *)anImageView failedWithError:(NSError *)error;

@end
