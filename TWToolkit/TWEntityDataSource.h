//
//  TWEntityDataSource.h
//  TWToolkit
//
//  Created by Sam Soffes on 9/9/09.
//  Copyright 2009 Tasteful Works, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TWEntityDataSourceDelegate;

@interface TWEntityDataSource : NSObject {

	id<TWEntityDataSourceDelegate> delegate;
}

@property (nonatomic, assign) id<TWEntityDataSourceDelegate> delegate;

- (id)initWithDelegate:(id)aDelegate;

@end


@protocol TWEntityDataSourceDelegate <NSObject>

@optional

- (void)entityDataSourceDidStart:(TWEntityDataSource *)dataSource
- (void)entityDataSource:(TWEntityDataSource *)dataSource didFinishWithData:(id)data;
- (void)entityDataSource:(TWEntityDataSource *)dataSource failedWithError:(NSError *)error;

@end
