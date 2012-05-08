//
//  NSURL+SSToolkitAdditions.m
//  SSToolkit
//
//  Created by Sam Soffes on 4/27/10.
//  Copyright 2010-2011 Sam Soffes. All rights reserved.
//

#import "NSURL+SSToolkitAdditions.h"
#import "NSDictionary+SSToolkitAdditions.h"

@implementation NSURL (SSToolkitAdditions)

+ (id)URLWithFormat:(NSString *)format, ... {
	va_list arguments;
    va_start(arguments, format);
	NSString *string = [[NSString alloc] initWithFormat:format arguments:arguments];
	va_end(arguments);
	
	return [NSURL URLWithString:string];
}


- (NSDictionary *)queryDictionary {
	 return [NSDictionary dictionaryWithFormEncodedString:self.query];
}

@end
