//
//  SSManagedOperationQueue.h
//  SSDataKit
//
//  Created by Sam Soffes on 11/8/11.
//  Copyright (c) 2011 Sam Soffes. All rights reserved.
//

@protocol SSManagedOperation;

@interface SSManagedOperationQueue : NSObject

@property (nonatomic, copy, readonly) NSString *name;

// Accessing the Default Queue
+ (SSManagedOperationQueue *)defaultQueue;

// Initializing
- (id)initWithName:(NSString *)name;

// Adding Operations
- (void)addOperation:(NSOperation <SSManagedOperation>*)operation;

@end
