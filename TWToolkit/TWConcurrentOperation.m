//
//  TWConcurrentOperation.m
//  TWToolkit
//
//  Created by Sam Soffes on 8/5/10.
//  Copyright 2010 Sam Soffes. All rights reserved.
//

#import "TWConcurrentOperation.h"

@implementation TWConcurrentOperation

#pragma mark NSObject

- (id)init {
    if ((self = [super init])) {
        _isExecuting = NO;
        _isFinished = NO;
    }
    return self;
}


#pragma mark NSOperation

- (BOOL)isConcurrent {
    return YES;
}


- (BOOL)isExecuting {
    return _isExecuting;
}


- (BOOL)isFinished {
    return _isFinished;
}


- (void)start {
    [self willChangeValueForKey:@"isExecuting"];
    _isExecuting = YES;
    [self didChangeValueForKey:@"isExecuting"];
}


#pragma mark TWConcurrentOperation

- (void)finish {
    [self willChangeValueForKey:@"isExecuting"];
    [self willChangeValueForKey:@"isFinished"];
    
    _isExecuting = NO;
    _isFinished = YES;
    
    [self didChangeValueForKey:@"isExecuting"];
    [self didChangeValueForKey:@"isFinished"];
}


@end
