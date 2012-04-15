//
//  SSButton.h
//  SSToolkit
//
//  Created by Sam Soffes on 4/14/12.
//  Copyright (c) 2012 Sam Soffes. All rights reserved.
//

typedef enum {
	SSButtonImagePositionLeft,
	SSButtonImagePositionRight
} SSButtonImagePosition; 

@interface SSButton : UIButton

@property (nonatomic, assign) SSButtonImagePosition imagePosition;

@end
