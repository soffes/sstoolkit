//
//  EGOImageLoader.h
//  EGOImageLoading
//
//  Created by Shaun Harrison on 9/15/09.
//  Copyright (c) 2009-2010 enormego
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import <Foundation/Foundation.h>

@protocol EGOImageLoaderObserver;
@interface EGOImageLoader : NSObject/*<NSURLConnectionDelegate>*/ {
@private
	NSDictionary* _currentConnections;
	NSMutableDictionary* currentConnections;
	
	NSLock* connectionsLock;
}

+ (EGOImageLoader*)sharedImageLoader;

- (BOOL)isLoadingImageURL:(NSURL*)aURL;
- (void)loadImageForURL:(NSURL*)aURL observer:(id<EGOImageLoaderObserver>)observer;
- (UIImage*)imageForURL:(NSURL*)aURL shouldLoadWithObserver:(id<EGOImageLoaderObserver>)observer;
- (BOOL)hasLoadedImageURL:(NSURL*)aURL;

- (void)cancelLoadForURL:(NSURL*)aURL;

- (void)removeObserver:(id<EGOImageLoaderObserver>)observer;
- (void)removeObserver:(id<EGOImageLoaderObserver>)observer forURL:(NSURL*)aURL;

@property(nonatomic,retain) NSDictionary* currentConnections;
@end

@protocol EGOImageLoaderObserver<NSObject>
@optional
- (void)imageLoaderDidLoad:(NSNotification*)notification; // Object will be EGOImageLoader, userInfo will contain imageURL and image
- (void)imageLoaderDidFailToLoad:(NSNotification*)notification; // Object will be EGOImageLoader, userInfo will contain error
@end