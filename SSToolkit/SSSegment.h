//
//  SSSegment.h
//  SSToolkit
//
//  Created by Sam Soffes on 3/3/11.
//  Copyright 2011 Sam Soffes. All rights reserved.
//

typedef enum {
	SSSegmentPositionLeft,
	SSSegmentPositionCenter,
	SSSegmentPositionRight
} SSSegmentPosition;

@interface SSSegment : UIView {

@private
	
	BOOL _enabled;
	BOOL _highlighted;
	BOOL _selected;
	SSSegmentPosition _position;
	
	UIView *_contentView;
	
	UIImage *_backgroundImage;
	UIImage *_highlightedBackgroundImage;
	
	UIImage *_dividerImage;
	UIImage *_highlightedDividerImage;
}

@property (nonatomic, assign, getter=isEnabled) BOOL enabled;
@property (nonatomic, assign, getter=isHighlighted) BOOL highlighted;
@property (nonatomic, assign, getter=isSelected) BOOL selected;
@property (nonatomic, assign) SSSegmentPosition position;

@property (nonatomic, retain) UIView *contentView;

@property (nonatomic, retain) UIImage *backgroundImage;
@property (nonatomic, retain) UIImage *highlightedBackgroundImage;

@property (nonatomic, retain) UIImage *dividerImage;
@property (nonatomic, retain) UIImage *highlightedDividerImage;

@end
