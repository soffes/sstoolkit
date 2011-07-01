//
//  SSAnimatedImageView.h
//  SSToolkit
//
//  Created by Sam Soffes on 6/27/11.
//  Copyright 2011 Sam Soffes. All rights reserved.
//

@protocol SSAnimatedImageViewDelegate;

/** @brief Animated image view.
 
 <code>SSAnimatedImageView</code> is a simple subclass of <code>UIImageView</code> that provides more advanced control
 of image animations. The animation is backed by a <code>CAKeyframeAnimation</code>.
 
 This class is a work in progress.
 */
@interface SSAnimatedImageView : UIImageView

/** @brief Start an image animation.
 
 @param animationName The named of the animation.
 @param images An array of <code>UIImage</code>s that will be animated.
 @param delegate The delegate of the animation.
 
 The duration is set to the appropriate length for playing the images at 30fps.
 */
- (void)startImageAnimation:(NSString *)animationName images:(NSArray *)images delegate:(id<SSAnimatedImageViewDelegate>)delegate;


/** @brief Start an image animation with duration and repeat count.
 
 @param animationName The named of the animation.
 @param images An array of <code>UIImage</code> objects that will be animated.
 @param duration The duration of the animation.
 @param repeatCount The number of times the animation repeats. Specify <code>0</code> to repeat indefinitely.
 @param delegate The delegate of the animation.
 */
- (void)startImageAnimation:(NSString *)animationName images:(NSArray *)images duration:(NSTimeInterval)duration repeatCount:(NSUInteger)repeatCount delegate:(id<SSAnimatedImageViewDelegate>)delegate;

/** @brief Start a timed image animation with repeat count.
 
 @param animationName The named of the animation.
 @param images An array of <code>UIImage</code>s that will be animated.
 @param keyTimes An array of <code>NSNumber</code> objects that define the duration of each keyframe segment.
 @param repeatCount The number of times the animation repeats. Specify <code>0</code> to repeat indefinitely.
 @param delegate The delegate of the animation.
 
 See <code>CAKeyframeAnimation</code>'s documentation for more information on how to specify <code>keyTimes</code>.
 */
- (void)startTimedImageAnimation:(NSString *)animationName images:(NSArray *)images keyTimes:(NSArray *)keyTimes repeatCount:(NSUInteger)repeatCount delegate:(id<SSAnimatedImageViewDelegate>)delegate;

@end


@protocol SSAnimatedImageViewDelegate <NSObject>

@optional

- (void)imageView:(SSAnimatedImageView *)imageView didStartAnimation:(NSString *)animationName;
- (void)imageView:(SSAnimatedImageView *)imageView didFinishAnimation:(NSString *)animationName;

@end
