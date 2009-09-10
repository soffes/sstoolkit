//
//  TWEntityDataSource.m
//  TWToolkit
//
//  Created by Sam Soffes on 9/9/09.
//  Copyright 2009 Tasteful Works, Inc. All rights reserved.
//

#import "TWEntityDataSource.h"

@implementation TWEntityDataSource

@synthesize delegate;

- (id)initWithDelegate:(id)aDelegate {
	if (self = [super init]) {
		self.delegate = aDelegate;
	}
	return self;
}

@end
