//
//  TWEntity.m
//  TWToolkit
//
//  Created by Sam Soffes on 9/9/09.
//  Copyright 2009 Tasteful Works, Inc. All rights reserved.
//

#import "TWEntity.h"

@implementation TWEntity

#pragma mark -
#pragma mark NSObject
#pragma mark -

- (id)init {
	if (self = [super init]) {
		_hydrated = NO;
	}
	return self;
}

#pragma mark -
#pragma mark Hydration
#pragma mark -

- (void)hydrate {
	_hydrated = YES;
}

- (void)dehydrate {
	_hydrated = NO;
}

@end
