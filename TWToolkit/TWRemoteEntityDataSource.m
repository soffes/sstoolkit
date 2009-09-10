//
//  TWRemoteEntityDataSource.m
//  TWToolkit
//
//  Created by Sam Soffes on 9/9/09.
//  Copyright 2009 Tasteful Works, Inc. All rights reserved.
//

#import "TWRemoteEntityDataSource.h"

@implementation TWRemoteEntityDataSource

#pragma mark -
#pragma mark TWConnectionDelegate
#pragma mark -

- (void)connection:(TWConnection *)aConnection didFinishLoadingRequest:(NSURLRequest *)aRequest withResult:(id)object {
	
}

- (void)connection:(TWConnection *)aConnection failedWithError:(NSError *)error {
	
}

@end
