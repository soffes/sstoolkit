//
//  TWEntityDataSource.h
//  TWToolkit
//
//  Created by Sam Soffes on 9/9/09.
//  Copyright 2009 Tasteful Works, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TWEntityDataSource : NSObject {

	id delegate;
}

@property (nonatomic, assign) id delegate;

- (id)initWithDelegate:(id)aDelegate;

@end
