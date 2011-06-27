//
//  SSAnimatedImageView.h
//  SSToolkit
//
//  Created by Sam Soffes on 6/27/11.
//  Copyright 2011 Sam Soffes. All rights reserved.
//

@protocol SSAnimatedImageViewDelegate;

@interface SSAnimatedImageView : UIImageView

- (void)startImageAnimation:(NSString *)animationName images:(NSArray *)images duration:(NSTimeInterval)duration repeatCount:(NSUInteger)repeatCount delegate:(id<SSAnimatedImageViewDelegate>)delegate;
- (void)startTimedImageAnimation:(NSString *)animationName images:(NSArray *)images keyTimes:(NSArray *)keyTimes repeatCount:(NSUInteger)repeatCount delegate:(id<SSAnimatedImageViewDelegate>)delegate;

@end


@protocol SSAnimatedImageViewDelegate <NSObject>

@optional

- (void)imageView:(SSAnimatedImageView *)imageView didStartAnimation:(NSString *)animationName;
- (void)imageView:(SSAnimatedImageView *)imageView didFinishAnimation:(NSString *)animationName;

@end
