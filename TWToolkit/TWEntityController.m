//
//  TWEntityController.m
//  TWToolkit
//
//  Created by Sam Soffes on 9/9/09.
//  Copyright 2009 Tasteful Works, Inc. All rights reserved.
//

#import "TWEntityController.h"
#import "TWEntityDataSource.h"
#import "TWRemoteEntityDataSource.h"
#import "TWSQLiteEntityDataSource.h"
#import "TWEntity.h"

@implementation TWEntityController

@synthesize delegate;

#pragma mark -
#pragma mark Configuration
#pragma mark -

+ (Class)entityClass {
	return [TWEntity class];
}

+ (NSArray *)dataSources {
	return [NSArray arrayWithObjects:[TWRemoteEntityDataSource class], [TWSQLiteEntityDataSource class], nil];
}

#pragma mark -
#pragma mark Initialization
#pragma mark -

- (id)initWithDelegate:(id)aDelegate {
	if (self = [super init]) {
		self.delegate = aDelegate;
	}
	return self;
}

#pragma mark -
#pragma mark Request
#pragma mark -

- (BOOL)requestWithSelector:(SEL)selector {
	for (Class dataSourceClass in [[self class] dataSources]) {
		if ([dataSourceClass instancesRespondToSelector:selector]) {
			TWEntityDataSource *dataSource = [[dataSourceClass alloc] initWithDelegate:self];
			[dataSource performSelector:selector];			
		}
	}
	return NO;
}

@end
