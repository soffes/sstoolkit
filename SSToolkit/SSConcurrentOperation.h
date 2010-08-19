//
//  SSConcurrentOperation.h
//  SSToolkit
//
//  Created by Sam Soffes on 8/5/10.
//  Copyright 2010 Sam Soffes. All rights reserved.
//

@interface SSConcurrentOperation : NSOperation {

    BOOL _isExecuting;
    BOOL _isFinished;
}

- (void)finish;

@end
