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

// Adapted from https://gist.github.com/415172 Thanks Matt!
- (CAKeyframeAnimation *)_animationWithName:(NSString *)animationName images:(NSArray *)images repeatCount:(NSUInteger)repeatCount delegate:(id<SSAnimatedImageViewDelegate>)delegate {
	CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"contents"];
	NSMutableArray *values = [[NSMutableArray alloc] initWithCapacity:[images count]];
	
	[images enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop) {
		[values addObject:(id)[(UIImage *)object CGImage]];
	}];
	
	animation.values = values;
	
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
		__block NSTimeInterval totalDuration = 0.0;
		__block CGFloat totalSoFar = 0.0f;
		
		[keyTimes enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop) {
			CGFloat keyTime = [object floatValue];
			totalDuration += keyTime;
			
			// For discrete timing, the first one is always 0.0
			if (totalSoFar == 0.0f) {
				[keyTimesAsPercent addObject:[NSNumber numberWithFloat:0.0f]];
				totalSoFar += keyTime;
			} else {
				[keyTimesAsPercent addObject:[NSNumber numberWithFloat:(totalSoFar / totalDuration)]];
				totalSoFar += keyTime;
			}
		}];
		
		[keyTimesAsPercent addObject:[NSNumber numberWithFloat:1.0f]];
		
		animation.keyTimes = keyTimesAsPercent;		
		animation.duration = totalDuration;
	}
	
	[self.layer addAnimation:animation forKey:animationName];
	[self.layer setContents:[animation.values lastObject]];
}


#pragma mark - CAAnimation Delegate

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
