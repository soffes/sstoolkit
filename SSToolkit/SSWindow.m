//
//  SSWindow.m
//  SSToolkit
//
//  Created by Sam Soffes on 1/21/11.
//  Copyright 2011 Sam Soffes. All rights reserved.
//

#import "SSWindow.h"

@interface SSWindow (PrivateMethods)
- (void)_processEvent:(UIEvent *)event forView:(UIView *)view;
- (void)_forwardTap:(NSDictionary *)info;
- (NSMutableDictionary *)_storage;
@end


@implementation SSWindow

#pragma mark NSObject

- (id)init {
	self = [super initWithFrame:[[UIScreen mainScreen] bounds]];
	return self;
}


- (void)dealloc {
	[_storage release];
	[super dealloc];
}


#pragma mark UIWindow

- (void)sendEvent:(UIEvent *)event {
	[super sendEvent:event];
	
	if ([[self _storage] count] == 0) {
		return;
	}
	
	NSSet *touches = [event allTouches];
	if (touches.count != 1) {
		return;
	}
	
	UITouch *touch = touches.anyObject;
	if (touch.phase != UITouchPhaseEnded) {
		return;
	}
	
	for (NSValue *value in [self _storage]) {
		UIView *view = [value pointerValue];
		if ([touch.view isDescendantOfView:view]) {
			[self _processEvent:event forView:view];
		}
	}
}


#pragma mark Storage

- (void)setObserver:(id<SSWindowObserver>)observer forView:(UIView *)view {
	if ([[self _storage] objectForKey:[NSValue valueWithPointer:view]] == observer) {
		return;
	}
	
	[[self _storage] setObject:observer forKey:[NSValue valueWithPointer:view]];
}


- (void)removeObserver:(id<SSWindowObserver>)observer {
	for (NSValue *view in [self _storage]) {
		if ([[self _storage] objectForKey:view] == observer) {
			[[self _storage] removeObjectForKey:view];
		}
	}
}


- (void)removeObserverForView:(UIView *)view {
	[[self _storage] removeObjectForKey:[NSValue valueWithPointer:view]];
}


#pragma mark Private Methods

- (void)_processEvent:(UIEvent *)event forView:(UIView *)view {
	UITouch *touch = [[event allTouches] anyObject];
	CGPoint tapPoint = [touch locationInView:view];
	NSValue *pointValue = [NSValue valueWithCGPoint:tapPoint];
	NSDictionary *info = [NSDictionary dictionaryWithObjectsAndKeys:
						  pointValue, @"point",
						  view, @"view",
						  nil];
	
	if (touch.tapCount == 1) {
		[self performSelector:@selector(_forwardTap:) withObject:info afterDelay:0.1];
	} else if (touch.tapCount > 1) {
		[NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(_forwardTap:) object:info];
	}
}


- (void)_forwardTap:(NSDictionary *)info {
	UIView *view = [info objectForKey:@"view"];
	id observer = [[self _storage] objectForKey:[NSValue valueWithPointer:view]];
	
	if ([observer respondsToSelector:@selector(windowViewWasTouched:atPoint:)]) {
		CGPoint point = [[info objectForKey:@"point"] CGPointValue];
		[observer windowViewWasTouched:view atPoint:point];
	}
}


- (NSMutableDictionary *)_storage {
	if (!_storage) {
		_storage = [[NSMutableDictionary alloc] init];
	}
	return _storage;
}

@end
