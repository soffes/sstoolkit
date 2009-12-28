//
//  TWURLRequest.h
//  TWToolkit
//
//  Created by Sam Soffes on 10/9/09.
//  Copyright 2009 Tasteful Works, Inc. All rights reserved.
//

#define kTWURLRequestTimeout 60
#define kTWURLRequestHTTPMethodGET @"GET"
#define kTWURLRequestHTTPMethodPOST @"POST"
#define kTWURLRequestHTTPMethodPUT @"PUT"
#define kTWURLRequestHTTPMethodDELETE @"DELETE"

typedef enum {
	TWURLRequestDataTypeData = 0,
	TWURLRequestDataTypeString = 1,
	TWURLRequestDataTypeImage = 2,
	TWURLRequestDataTypeJSON = 3,
	TWURLRequestDataTypeJSONArray = TWURLRequestDataTypeJSON, // Deprecated
	TWURLRequestDataTypeJSONDictionary = TWURLRequestDataTypeJSON // Deprecated
	
} TWURLRequestDataType;


@interface TWURLRequest : NSMutableURLRequest {

	TWURLRequestDataType dataType;
	NSString *hash;
	NSTimeInterval cacheLifetime;
}

@property (nonatomic, assign) TWURLRequestDataType dataType;
@property (nonatomic, copy) NSString *hash;
@property (nonatomic, assign) NSTimeInterval cacheLifetime;

+ (id)parseData:(NSData *)data dataType:(TWURLRequestDataType)aDataType error:(NSError **)outError;

- (id)initWithURLString:(NSString *)urlString;

@end
