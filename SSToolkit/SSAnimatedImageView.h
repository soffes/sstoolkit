//
//  SSAnimatedImageView.h
//  SSToolkit
//
//  Created by Sam Soffes on 6/27/11.
//  Copyright 2011 Sam Soffes. All rights reserved.
//

@protocol SSAnimatedImageViewDelegate;

/**
 Animated image view.
 
 `SSAnimatedImageView` is a simple subclass of `UIImageView` that provides more advanced control of image animations.
 The animation is backed by a `CAKeyframeAnimation`.
 
 This class is a work in progress.
 */
@interface SSAnimatedImageView : UIImageView

///--------------------------
/// @name Starting Animations
///--------------------------

/**
 Start an image animation.
 
 The duration is set to the appropriate length for playing the images at 30fps.
 
 @param animationName The named of the animation.
 
 @param images An array of `UIImage` objects that will be animated.
 
 @param delegate The delegate of the animation.
 */
- (void)startImageAnimation:(NSString *)animationName images:(NSArray *)images delegate:(id<SSAnimatedImageViewDelegate>)delegate;


/**
 Start an image animation with duration and repeat count.
 
 @param animationName The named of the animation.
 
 @param images An array of `UIImage` objects that will be animated.
 
 @param duration The duration of the animation.
 
 @param repeatCount The number of times the animation repeats. Specify `0` to repeat indefinitely.
 
 @param delegate The delegate of the animation.
 */
- (void)startImageAnimation:(NSString *)animationName images:(NSArray *)images duration:(NSTimeInterval)duration repeatCount:(NSUInteger)repeatCount delegate:(id<SSAnimatedImageViewDelegate>)delegate;


///--------------------------------
/// @name Starting Timed Animations
///--------------------------------

/**
 Start a timed image animation with repeat count.
 
 See `CAKeyframeAnimation`'s documentation for more information on how to specify `keyTimes`.
 
 @param animationName The named of the animation.
 
 @param images An array of `UIImage` objects that will be animated.
 
 @param keyTimes An array of `NSNumber` objects that define the duration of each keyframe segment.
 
 @param repeatCount The number of times the animation repeats. Specify `0` to repeat indefinitely.
 
 @param delegate The delegate of the animation.
 */
- (void)startTimedImageAnimation:(NSString *)animationName images:(NSArray *)images keyTimes:(NSArray *)keyTimes repeatCount:(NSUInteger)repeatCount delegate:(id<SSAnimatedImageViewDelegate>)delegate;

@end


/**
 The `SSAnimatedImageViewDelegate` protocol defines methods that a delegate of a `SSAnimatedImageView` object can
 optionally implement to observe the animation status.
 
 @warning **Important:** Before releasing an instance of `SSAnimatedImageView` for which you have set a delegate, you
 must first set the `SSAnimatedImageView` delegate property to `nil` before disposing of the `SSAnimatedImageView`
 instance. This can be done, for example, in the `dealloc` method where you dispose of the `SSAnimatedImageView`.
 */
@protocol SSAnimatedImageViewDelegate <NSObject>

@optional

/**
 Sent when an image view begins playing its animation.
 
 @param anImageView The image view that started playng its animation.
 
 @param animationName The name of the animation that started.
 
 @see imageView:didFinishAnimation:
 */
- (void)imageView:(SSAnimatedImageView *)anImageView didStartAnimation:(NSString *)animationName;

/**
 Sent after an image view finished playing its animation.
 
 @param anImageView The image view that finished playng its animation.
 
 @param animationName The name of the animation that started.
 
 @see imageView:didStartAnimation:
 */
- (void)imageView:(SSAnimatedImageView *)anImageView didFinishAnimation:(NSString *)animationName;

@end
