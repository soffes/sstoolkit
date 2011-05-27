//
//  JMCache.m
//  JMCache
//
//  Created by Jake Marsh on 2/7/11.
//  Copyright 2011 Rubber Duck Software. All rights reserved.
//

#import "JMImageCache.h"

static NSString* _JMImageCacheDirectory;

static inline NSString* JMImageCacheDirectory() {
	if(!_JMImageCacheDirectory) {
		_JMImageCacheDirectory = [[NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches/JMCache"] copy];
	}

	return _JMImageCacheDirectory;
}


inline static NSString* keyForURL(NSString *url) {
	return [NSString stringWithFormat:@"JMImageCache-%u", [url hash]];
}


static inline NSString* cachePathForURL(NSString* key) {
	return [JMImageCacheDirectory() stringByAppendingPathComponent:keyForURL(key)];
}


JMImageCache *_sharedCache = nil;

@implementation JMImageCache

+ (JMImageCache *) sharedCache {
	if(!_sharedCache) {
		_sharedCache = [[JMImageCache alloc] init];
	}

	return _sharedCache;
}


- (id) init {
	if((self = [super init])) {
		_diskOperationQueue = [[NSOperationQueue alloc] init];

		[[NSFileManager defaultManager] createDirectoryAtPath:JMImageCacheDirectory() 
							 withIntermediateDirectories:YES 
										   attributes:nil 
											   error:NULL];
	}
	
	return self;
}


#pragma mark -
#pragma mark Getter Methods

- (UIImage *) imageForURL:(NSString *)url delegate:(id<JMImageCacheDelegate>)d {
	if (!url) {
		return nil;
	}
	
	id returner = [super objectForKey:url];

	if(returner) {
		return returner;
	} else {
		UIImage *i = [self imageFromDiskForURL:url];
		if(i) {
			[self setImage:i forURL:url];

			return i;
		}

		dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
			NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
			UIImage *i = [[[UIImage alloc] initWithData:data] autorelease];

			NSString* cachePath = cachePathForURL(url);
			NSInvocation* writeInvocation = [NSInvocation invocationWithMethodSignature:[self methodSignatureForSelector:@selector(writeData:toPath:)]];
			[writeInvocation setTarget:self];
			[writeInvocation setSelector:@selector(writeData:toPath:)];
			[writeInvocation setArgument:&data atIndex:2];
			[writeInvocation setArgument:&cachePath atIndex:3];

			[self performDiskWriteOperation:writeInvocation];
			[self setImage:i forURL:url];

			dispatch_async(dispatch_get_main_queue(), ^{
				if(d) {
					if([d respondsToSelector:@selector(cache:didDownloadImage:forURL:)]) {
						[d cache:self didDownloadImage:i forURL:url];
					}
				}
			});
		});

		return nil;
	}
}


- (UIImage *) imageFromDiskForURL:(NSString *)url {
	UIImage *i = [[[UIImage alloc] initWithData:[NSData dataWithContentsOfFile:cachePathForURL(url) options:0 error:NULL]] autorelease];

	return i;
}


#pragma mark -
#pragma mark Setter Methods

- (void) setImage:(UIImage *)i forURL:(NSString *)url {
	[super setObject:i forKey:url];
}


- (void) removeImageForURL:(NSString *)url {
	[super removeObjectForKey:keyForURL(url)];
}


#pragma mark -
#pragma mark Disk Writing Operations

- (void) writeData:(NSData*)data toPath:(NSString *)path {
	[data writeToFile:path atomically:YES];
}


- (void) performDiskWriteOperation:(NSInvocation *)invoction {
	NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithInvocation:invoction];
	[_diskOperationQueue addOperation:operation];
	[operation release];
}


- (void) dealloc {
	[_diskOperationQueue release];
	[super dealloc];
}

@end
