//
//  TWSQLiteEntityDataSource.h
//  TWToolkit
//
//  Created by Sam Soffes on 9/9/09.
//  Copyright 2009 Tasteful Works, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "TWSEntityDataSource.h"

@interface TWSQLiteEntityDataSource : TWSEntityDataSource {

	sqlite3 *_database;
}

+ (NSString *)databaseFilename;
+ (NSString *)bundleDatabasePath;
+ (NSString *)cachesDatabasePath;

@end
