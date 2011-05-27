//
//  SCImageCollectionViewItem.h
//  SSCatalog
//
//  Created by Sam Soffes on 5/3/11.
//  Copyright 2011 Sam Soffes. All rights reserved.
//

#import <SSToolkit/SSCollectionViewItem.h>

@class EGOImageView;

@interface SCImageCollectionViewItem : SSCollectionViewItem {

	EGOImageView *_remoteImageView;
}

@property (nonatomic, retain, readonly) EGOImageView *remoteImageView;

@end
