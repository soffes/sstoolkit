//
//  TWRemoteImageView.h
//  TWToolkit
//
//  Created by Sam Soffes on 10/9/09.
//  Copyright 2009 Tasteful Works, Inc. All rights reserved.
//

#import "TWURLConnection.h"

@protocol TWRemoteImageViewDelegate;

@interface TWRemoteImageView : UIView <TWURLConnectionDelegate> {

	id<TWRemoteImageViewDelegate> delegate;
	NSURL *URL;
	
	UIImageView *remoteImageView;
	UIImageView *placeholderImageView;
}

@property (nonatomic, assign) id<TWRemoteImageViewDelegate> delegate;
@property (nonatomic, copy) NSURL *URL;
@property (nonatomic, retain, readonly) UIImageView *remoteImageView;
@property (nonatomic, retain, readonly) UIImageView *placeholderImageView;

@end


@protocol TWRemoteImageViewDelegate <NSObject>

@optional

- (void)remoteImageViewDidStartLoading:(TWRemoteImageView*)aRemoteImageView;
- (void)remoteImageView:(TWRemoteImageView*)aRemoteImageView didLoadImage:(UIImage*)image;
- (void)remoteImageView:(TWRemoteImageView*)aRemoteImageView didFailWithError:(NSError*)error;

@end
