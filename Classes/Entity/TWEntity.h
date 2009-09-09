//
//  TWEntity.h
//  TWToolkit
//
//  Created by Sam Soffes on 9/9/09.
//  Copyright 2009 Tasteful Works, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TWEntity : NSObject {

	BOOL _hydrated;
}

@property (nonatomic, readonly, getter=isHydrated) BOOL hydrated;

- (void)hydrate;
- (void)dehydrate;

@end
