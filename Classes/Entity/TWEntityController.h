//
//  TWEntityController.h
//  TWToolkit
//
//  Created by Sam Soffes on 9/9/09.
//  Copyright 2009 Tasteful Works, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TWEntityController : NSObject {

	NSMutableArray *_objectsCache;
}

+ (TWEntityController *)sharedController;
+ (Class)entityClass;

@end
