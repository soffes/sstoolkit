//
//  EGOImageLoadConnection.h
//  EGOImageLoading
//
//  Created by Shaun Harrison on 12/1/09.
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

@protocol EGOImageLoadConnectionDelegate;

@interface EGOImageLoadConnection : NSObject {
@private
	NSURL* _imageURL;
	NSURLResponse* _response;
	NSMutableData* _responseData;
	NSURLConnection* _connection;
	NSTimeInterval _timeoutInterval;
	
	id<EGOImageLoadConnectionDelegate> _delegate;
}

- (id)initWithImageURL:(NSURL*)aURL delegate:(id)delegate;

- (void)start;
- (void)cancel;

@property(nonatomic,readonly) NSData* responseData;
@property(nonatomic,readonly,getter=imageURL) NSURL* imageURL;

@property(nonatomic,retain) NSURLResponse* response;
@property(nonatomic,assign) id<EGOImageLoadConnectionDelegate> delegate;

@property(nonatomic,assign) NSTimeInterval timeoutInterval; // Default is 30 seconds

@end

@protocol EGOImageLoadConnectionDelegate<NSObject>
- (void)imageLoadConnectionDidFinishLoading:(EGOImageLoadConnection *)connection;
- (void)imageLoadConnection:(EGOImageLoadConnection *)connection didFailWithError:(NSError *)error;	
@end