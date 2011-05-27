//
//  JMCache.h
//  JMCache
//
//  Created by Jake Marsh on 2/7/11.
//  Copyright 2011 Rubber Duck Software. All rights reserved.
//

@class JMImageCache;

@protocol JMImageCacheDelegate <NSObject>

@optional
- (void) cache:(JMImageCache *)c didDownloadImage:(UIImage *)i forURL:(NSString *)url;

@end

@interface JMImageCache : NSCache {
	
@private
	
	NSOperationQueue *_diskOperationQueue;
}

+ (JMImageCache *) sharedCache;

- (UIImage *) imageForURL:(NSString *)url delegate:(id<JMImageCacheDelegate>)d;
- (UIImage *) imageFromDiskForURL:(NSString *)url;

- (void) setImage:(UIImage *)i forURL:(NSString *)url;
- (void) removeImageForURL:(NSString *)url;

- (void) writeData:(NSData*)data toPath:(NSString *)path;
- (void) performDiskWriteOperation:(NSInvocation *)invoction;

@end
