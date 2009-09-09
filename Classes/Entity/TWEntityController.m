//
//  TWEntityController.m
//  TWToolkit
//
//  Created by Sam Soffes on 9/9/09.
//  Copyright 2009 Tasteful Works, Inc. All rights reserved.
//

#import "TWEntityController.h"

static TWEntityController *sharedController;

@implementation TWEntityController

#pragma mark -
#pragma mark Singleton Methods
#pragma mark -

+ (TWEntityController *)sharedController {
    @synchronized(self) {
        if (sharedController == nil) {
            [[self alloc] init]; // assignment not done here
        }
    }
    return sharedController;
}

+ (id)allocWithZone:(NSZone *)zone {
    @synchronized(self) {
        if (sharedController == nil) {
            sharedController = [super allocWithZone:zone];
            return sharedController;  // assignment and return on first allocation
        }
    }
    return nil; // on subsequent allocation attempts return nil
}

- (id)copyWithZone:(NSZone *)zone {
    return self;
}

- (id)retain {
    return self;
}

- (unsigned)retainCount {
    return UINT_MAX;  // denotes an object that cannot be released
}

- (void)release {
    // do nothing
}

- (id)autorelease {
    return self;
}

#pragma mark -
#pragma mark Class Methods
#pragma mark -

+ (Class)entityClass {
	return nil;
}

@end
