//
//  TWConcurrentOperation.h
//  TWToolkit
//
//  Created by Sam Soffes on 8/5/10.
//  Copyright 2010 Sam Soffes. All rights reserved.
//

@interface TWConcurrentOperation : NSOperation {

    BOOL _isExecuting;
    BOOL _isFinished;
}

- (void)finish;

@end
