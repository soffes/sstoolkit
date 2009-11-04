//
//  TWURLRequest.h
//  TWToolkit
//
//  Created by Sam Soffes on 10/9/09.
//  Copyright 2009 Tasteful Works, Inc. All rights reserved.
//

#define kTWURLRequestTimeout 60

typedef enum {
	TWURLRequestDataTypeData = 0,
	TWURLRequestDataTypeString = 1,
	TWURLRequestDataTypeImage = 2,
	TWURLRequestDataTypeJSON = 3,
	TWURLRequestDataTypeJSONArray = TWURLRequestDataTypeJSON, // Deprecated
	TWURLRequestDataTypeJSONDictionary = TWURLRequestDataTypeJSON, // Deprecated
	
} TWURLRequestDataType;


@interface TWURLRequest : NSMutableURLRequest {

	TWURLRequestDataType dataType;
	NSString *hash;
	NSTimeInterval cacheLifetime;
	
	@private
	
	BOOL _hasRequested;
}

@property (nonatomic, assign) TWURLRequestDataType dataType;
@property (nonatomic, copy) NSString *hash;
@property (nonatomic, assign) NSTimeInterval cacheLifetime;

+ (id)parseData:(NSData *)data dataType:(TWURLRequestDataType)dataType error:(NSError **)outError;

@end
