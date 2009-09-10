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

@implementation TWEntityController

#pragma mark -
#pragma mark Configuration
#pragma mark -

- (NSArray *)dataSources {
	return [NSArray arrayWithObjects:[TWRemoteEntityDataSource class], [TWSQLiteEntityDataSource class], nil];
}

#pragma mark -
#pragma mark Request
#pragma mark -

- (BOOL)requestWithSelector:(SEL)selector {
	for (Class dataSourceClass in [self dataSources]) {
		if ([dataSourceClass instancesRespondToSelector:selector]) {
			dataSourceClass *dataSource = [dataSourceClass initWithDelegate:self];
			[dataSource performSelector:selector];			
		}
	}
	return NO;
}

@end
