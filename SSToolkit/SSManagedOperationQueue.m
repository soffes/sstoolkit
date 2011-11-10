//
//  SSManagedOperationQueue.m
//  SSDataKit
//
//  Created by Sam Soffes on 11/8/11.
//  Copyright (c) 2011 Sam Soffes. All rights reserved.
//

#import "SSManagedOperationQueue.h"
#import "NSString+SSToolkitAdditions.h"

@interface SSManagedOperationQueue ()
- (void)_addOperation:(NSOperation <SSManagedOperation>*)operation forUUID:(NSString *)uuid;
- (void)_resurrectOperations;
- (NSMutableDictionary *)_metaData;
@end

@implementation SSManagedOperationQueue {
	NSOperationQueue *_operationQueue;
	NSString *_plistPath;
	NSMutableDictionary *_operations;
	dispatch_queue_t _diskQueue;
}


#pragma mark - Accessors

- (NSString *)name {
	return _operationQueue.name;
}


#pragma mark - NSObject

- (id)init {
	NSLog(@"[SSManagedOperationQueue] You must initalize using `initWithName:` and provide a non-nil name.");
	[self autorelease];
	return nil;
}


- (void)dealloc {
	for (NSOperation *operation in _operations) {
		[operation removeObserver:self forKeyPath:@"isFinished" context:nil];
	}
	
	[_operations removeAllObjects];
	[_operations release];
	_operations = nil;
	
	dispatch_release(_diskQueue);
	
	[_operationQueue cancelAllOperations];
	[_operationQueue release];
	_operationQueue = nil;
	
	[_plistPath release];
	[super dealloc];
}


#pragma mark - Accessing the Default Queue

+ (SSManagedOperationQueue *)defaultQueue {
	static SSManagedOperationQueue *defaultQueue = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		defaultQueue = [[SSManagedOperationQueue alloc] initWithName:@"com.samsoffes.ssmanagedoperationqueue.default"];
	});
	return defaultQueue;
}


#pragma mark - Initializing

- (id)initWithName:(NSString *)name {
	if (!name || [name length] == 0) {
		NSLog(@"[SSManagedOperationQueue] You must initalize using `initWithName:` and provide a non-nil name.");
		[self autorelease];
		return nil;
	}
	
	if ((self = [super init])) {
		_diskQueue = dispatch_queue_create([name cStringUsingEncoding:NSUTF8StringEncoding], DISPATCH_QUEUE_SERIAL);
		
		_operationQueue = [[NSOperationQueue alloc] init];
		_operationQueue.name = name;
		
		_operations = [[NSMutableDictionary alloc] init];
		
		NSFileManager *fileManager = [[NSFileManager alloc] init];
		NSString *cachesDirectory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
		cachesDirectory = [cachesDirectory stringByAppendingPathComponent:@"com.samsoffes.ssmanagedoperationqueue"];
		if (![fileManager fileExistsAtPath:cachesDirectory]) {
			[fileManager createDirectoryAtPath:cachesDirectory withIntermediateDirectories:YES attributes:nil error:nil];
		}		
		
		_plistPath = [[cachesDirectory stringByAppendingFormat:@"/%@.plist", name] retain];
		if (![fileManager fileExistsAtPath:_plistPath]) {
			[fileManager createFileAtPath:_plistPath contents:nil attributes:nil];
		}
		[fileManager release];
		
		[self _resurrectOperations];
	}
	return self;
}


#pragma mark - Adding Operations

- (void)addOperation:(NSOperation <SSManagedOperation>*)operation {
	[self _addOperation:operation forUUID:nil];
}


#pragma mark - Private

- (void)_addOperation:(NSOperation <SSManagedOperation>*)operation forUUID:(NSString *)uuid {
	if (!operation) {
		return;
	}
		
	if (!uuid) {
		uuid = [NSString stringWithUUID];
	}
	
	// Use a single queue to ensure thread safety
	dispatch_async(_diskQueue, ^{
		// Save the operation in the queue on disk. In the future I'd like to only persist operations that are less
		// likely to actually get executed, but for now, do all of them for safety. I could definitely only persist in
		// `dealloc`, but that feels dangerous and doesn't work if someone kills the app.
		NSMutableDictionary *metaData = [self _metaData];
		NSMutableDictionary *dictionary = [metaData objectForKey:@"operations"];
		if (![dictionary objectForKey:uuid]) {
			NSData *data = [NSKeyedArchiver archivedDataWithRootObject:operation];
			[dictionary setObject:data forKey:uuid];
			[[metaData objectForKey:@"order"] addObject:uuid];
			[metaData writeToFile:_plistPath atomically:YES];
		}
		
		// Add completion observer
		[operation addObserver:self forKeyPath:@"isFinished" options:NSKeyValueObservingOptionNew context:nil];
		
		// Add operation to in memory cache
		[_operations setObject:uuid forKey:[NSValue valueWithNonretainedObject:operation]];
		
		// Add operation to queue
		[_operationQueue addOperation:operation];
	});
}


- (void)_resurrectOperations {
	dispatch_async(_diskQueue, ^{
		NSMutableDictionary *metaData = [self _metaData];
		NSMutableDictionary *dictionary = [metaData objectForKey:@"operations"];
		for (NSString *uuid in [metaData objectForKey:@"order"]) {
			NSOperation <SSManagedOperation>*operation = [NSKeyedUnarchiver unarchiveObjectWithData:[dictionary objectForKey:uuid]];
			[self _addOperation:operation forUUID:uuid];
		}
	});
}


- (NSMutableDictionary *)_metaData {
	NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] initWithContentsOfFile:_plistPath];
	if (!dictionary) {
		dictionary = [[NSMutableDictionary alloc] init];
		[dictionary setObject:[NSMutableDictionary dictionary] forKey:@"operations"];
		[dictionary setObject:[NSMutableArray array] forKey:@"order"];
	}
	return [dictionary autorelease];
}


#pragma mark - NSKeyValueObserving

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
	if ([keyPath isEqualToString:@"isFinished"]) {
		if ([[change objectForKey:NSKeyValueChangeNewKey] boolValue] == NO) {
			return;
		}
		
		[object removeObserver:self forKeyPath:@"isFinished" context:nil];
		
		NSValue *key = [NSValue valueWithNonretainedObject:object];
		NSString *uuid = [[_operations objectForKey:key] retain];
				
		// Remove operation from in memory cache
		[_operations removeObjectForKey:key];
		
		if (!uuid) {
			return;
		}
		
		dispatch_async(_diskQueue, ^{
			// Remove from on disk cache
			NSMutableDictionary *metaData = [self _metaData];
			[[metaData objectForKey:@"order"] removeObject:uuid];
			[(NSMutableDictionary *)[metaData objectForKey:@"operations"] removeObjectForKey:uuid];
			[metaData writeToFile:_plistPath atomically:YES];
			
			[uuid release];
		});
		return;
	}
	
	[super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
}

@end
