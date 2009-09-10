//
//  TWEntityController.h
//  TWToolkit
//
//  Created by Sam Soffes on 9/9/09.
//  Copyright 2009 Tasteful Works, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TWEntityControllerDelegate;

@interface TWEntityController : NSObject {

	id<TWEntityControllerDelegate> delegate;
	
	NSMutableArray *_objectsCache;
}

@property (nonatomic, assign) id delegate;

// ---- Configuration ----

// Class of the entity to control
+ (Class)entityClass;

// Return the classes of all supported data sources
+ (NSArray *)dataSources;

// ---- Initialization ----

- (id)initWithDelegate:(id)aDelegate;

// ---- Request ----

// Performs a request with a selector on the first data source
// that responses to the selector. If no data sources can perform
// the request, NO is return.
- (BOOL)requestWithSelector:(SEL)selector;

@end


@protocol TWEntityControllerDelegate <NSObject>

//@optional

@end
