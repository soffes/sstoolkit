//
//  SCImageCollectionViewItem.h
//  SSCatalog
//
//  Created by Sam Soffes on 5/3/11.
//  Copyright 2011 Sam Soffes. All rights reserved.
//

#import <SSToolkit/SSCollectionViewItem.h>
#import "JMImageCache.h"

@interface SCImageCollectionViewItem : SSCollectionViewItem <JMImageCacheDelegate> {

@private
	
	NSString *_imageURL;
}

@property (nonatomic, retain) NSString *imageURL;

@end
