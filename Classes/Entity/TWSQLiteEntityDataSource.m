//
//  TWSQLiteEntityDataSource.m
//  TWToolkit
//
//  Created by Sam Soffes on 9/9/09.
//  Copyright 2009 Tasteful Works, Inc. All rights reserved.
//

#import "TWSQLiteEntityDataSource.h"

@interface TWSQLiteEntityDataSource (Private)
- (void)createEditableCopyOfDatabaseIfNeeded;
- (void)initializeDatabase;
- (void)releaseDatabaseAndFinalizeStatements;
@end

@implementation TWSQLiteEntityDataSource

#pragma mark -
#pragma mark Class Methods
#pragma mark -

+ (NSString *)databaseFilename {
	return @"database.sqlite3";
}

+ (NSString *)bundleDatabasePath {
	return [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:[[self class] databaseFilename]]
}

+ (NSString *)cachesDatabasePath {
	static NSString *cachesDirectory;
	
	if (cachesDirectory == nil) {
		NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
		cachesDirectory = [paths objectAtIndex:0];
	}
	
	return [cachesDirectory stringByAppendingString:[[self class] databaseFilename]];
}

#pragma mark -
#pragma mark NSObject
#pragma mark -

- (void)dealloc {
	[self releaseDatabaseAndFinalizeStatements];
	[super dealloc];
}

#pragma mark -
#pragma mark Database Interactions
#pragma mark -

- (void)createEditableCopyOfDatabaseIfNeeded {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *writableDBPath = [[self class] cachesDatabasePath];
	
	// If the database doesn't exist, create a copy in the Caches directory
    if (![fileManager fileExistsAtPath:writableDBPath]) {
		// The writable database does not exist, so copy the default to the appropriate location.
		NSString *defaultDBPath = [[self class] bundleDatabasePath];
		
		// TODO: Catch any errors
		[fileManager copyItemAtPath:defaultDBPath toPath:writableDBPath error:nil];
	}
}

- (void)initializeDatabase {
	
	// Don't do anything if we have a database already
	if (_database) {
		return;
	}
	
	// Make sure we have a copy to work on
	[self createEditableCopyOfDatabaseIfNeeded];
	
    if (sqlite3_open([[[self class] cachesDatabasePath] UTF8String], &_database) != SQLITE_OK) {
        sqlite3_close(_database);
		// TODO: Handle error
        NSLog(@"Error: Failed to open database with message '%s'.", sqlite3_errmsg(_database));
    }
}

- (void)releaseDatabaseAndFinalizeStatements {
	if (sqlite3_close(_database) != SQLITE_OK) {
		NSLog(@"Error: Failed to close database with message '%s'.", sqlite3_errmsg(_database));
	}
	_database = nil;
}

@end
