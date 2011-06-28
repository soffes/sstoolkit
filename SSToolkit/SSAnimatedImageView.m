//
//  SSAnimatedImageView.m
//  SSToolkit
//
//  Created by Sam Soffes on 6/27/11.
//  Copyright 2011 Sam Soffes. All rights reserved.
//

#import "SSAnimatedImageView.h"
#import <QuartzCore/QuartzCore.h>

@interface SSAnimatedImageView ()
- (CAKeyframeAnimation *)_animationWithName:(NSString *)animationName images:(NSArray *)images repeatCount:(NSUInteger)repeatCount delegate:(id<SSAnimatedImageViewDelegate>)delegate;
@end

@implementation SSAnimatedImageView

// Adapted from https://gist.github.com/415172
- (CAKeyframeAnimation *)_animationWithName:(NSString *)animationName images:(NSArray *)images repeatCount:(NSUInteger)repeatCount delegate:(id<SSAnimatedImageViewDelegate>)delegate {
	CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"contents"];
	NSMutableArray *values = [[NSMutableArray alloc] initWithCapacity:[images count]];
	
	for (UIImage *image in images) {
		[values addObject:(id)image.CGImage];
	}
	
	animation.values = values;
	[values release];
	
	if (delegate) {
		animation.delegate = self;
		[animation setValue:delegate forKey:@"SSAnimatedImageViewDelegate"];
	}
	
	animation.repeatCount = repeatCount;
	animation.fillMode = kCAFillModeForwards;
	animation.calculationMode = kCAAnimationDiscrete;
	
	[animation setValue:animationName forKey:@"name"];
	
	return animation;
}


- (void)startImageAnimation:(NSString *)animationName images:(NSArray *)images delegate:(id<SSAnimatedImageViewDelegate>)delegate {
	[self startImageAnimation:animationName images:images duration:([images count] / 30.0) repeatCount:1 delegate:delegate];
}


- (void)startImageAnimation:(NSString *)animationName images:(NSArray *)images duration:(NSTimeInterval)duration repeatCount:(NSUInteger)repeatCount delegate:(id<SSAnimatedImageViewDelegate>)delegate {
	CAKeyframeAnimation *animation = [self _animationWithName:animationName images:images repeatCount:repeatCount delegate:delegate];
	animation.duration = duration;
	
	[self.layer addAnimation:animation forKey:animationName];
	[self.layer setContents:[animation.values lastObject]];
}


- (void)startTimedImageAnimation:(NSString *)animationName images:(NSArray *)images keyTimes:(NSArray *)keyTimes repeatCount:(NSUInteger)repeatCount delegate:(id<SSAnimatedImageViewDelegate>)delegate {
	
	CAKeyframeAnimation *animation = [self _animationWithName:animationName images:images repeatCount:repeatCount delegate:delegate];
	
	if (keyTimes) {
		NSMutableArray *keyTimesAsPercent = [[NSMutableArray alloc] initWithCapacity:[keyTimes count]];
		NSTimeInterval totalDuration = 0.0;
		
		for (NSNumber *frameTime in keyTimes) {
			totalDuration += [frameTime floatValue];
		}
		
		CGFloat totalSoFar = 0.0;
		
		for (NSNumber *frameTime in keyTimes) {
			// For discrete timing, the first one is always 0.0
			if (totalSoFar == 0.0) {
				[keyTimesAsPercent addObject:[NSNumber numberWithFloat:0.0]];
				totalSoFar += [frameTime floatValue];
			} else {
				[keyTimesAsPercent addObject:[NSNumber numberWithFloat:(totalSoFar/totalDuration)]];
				totalSoFar += [frameTime floatValue];
			}
		}
		[keyTimesAsPercent addObject:[NSNumber numberWithFloat:1.0]];
		
		animation.keyTimes = keyTimesAsPercent;
		[keyTimesAsPercent release];
		
		animation.duration = totalDuration;
	}
	
	[self.layer addAnimation:animation forKey:animationName];
	[self.layer setContents:[animation.values lastObject]];
}


#pragma mark -
#pragma mark CAAnimation Delegate

- (void)animationDidStart:(CAAnimation *)animation {
	id<SSAnimatedImageViewDelegate> delegate = [animation valueForKey:@"SSAnimatedImageViewDelegate"];
	if (delegate && [delegate respondsToSelector:@selector(imageView:didStartAnimation:)]) {
		[delegate imageView:self didStartAnimation:[animation valueForKey:@"name"]];
	}
}


- (void)animationDidStop:(CAAnimation *)animation finished:(BOOL)finished {
	if (!finished) {
		return;
	}
	
	id<SSAnimatedImageViewDelegate> delegate = [animation valueForKey:@"SSAnimatedImageViewDelegate"];
	if (delegate && [delegate respondsToSelector:@selector(imageView:didFinishAnimation:)]) {
		[delegate imageView:self didFinishAnimation:[animation valueForKey:@"name"]];
	}
}

@end
