//
//  SSWindow.h
//  SSToolkit
//
//  Created by Sam Soffes on 1/21/11.
//  Copyright 2011 Sam Soffes. All rights reserved.
//

@protocol SSWindowObserver;

@interface SSWindow : UIWindow {

	NSMutableDictionary *_storage;
}

- (void)setObserver:(id<SSWindowObserver>)observer forView:(UIView *)view;
- (void)removeObserver:(id<SSWindowObserver>)observer;
- (void)removeObserverForView:(UIView *)view;

@end


@protocol SSWindowObserver <NSObject>

- (void)windowViewWasTouched:(UIView *)aView atPoint:(CGPoint)point;

@end
