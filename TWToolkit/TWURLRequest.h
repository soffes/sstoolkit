//
//  TWURLRequest.h
//  TWToolkit
//
//  Created by Sam Soffes on 10/9/09.
//  Copyright 2009 Tasteful Works, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kTWURLRequestTimeout 60

typedef enum {
	TWURLRequestHTTPMethodGET = 0,
	TWURLRequestHTTPMethodPOST = 1,
	TWURLRequestHTTPMethodPUT = 2,
	TWURLRequestHTTPMethodDELETE = 3
} TWURLRequestHTTPMethod;


typedef enum {
	TWURLRequestDataTypeData = 0,
	TWURLRequestDataTypeString = 1,
	TWURLRequestDataTypeImage = 2,
	TWURLRequestDataTypeJSONArray = 3,
	TWURLRequestDataTypeJSONDictionary = 4,
	TWURLRequestDataTypeJSON = TWURLRequestDataTypeJSONArray
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

@end
