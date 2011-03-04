//
//  SSSegmentedControl.h
//  SSToolkit
//
//  Created by Sam Soffes on 2/7/11.
//  Copyright 2011 Sam Soffes. All rights reserved.
//

// Limitiations:
// - Removing and inserting items is not supported
// - Setting item width is not supported
// - Setting item content offset is not supported

enum {
	SSSegmentedControlNoSegment = UISegmentedControlNoSegment
};

@interface SSSegmentedControl : UIControl {

@private
	
	NSMutableArray *_segments;
	NSInteger _selectedSegmentIndex;
	BOOL _momentary;
	NSMutableDictionary *_segmentMeta;
	
	UIImage *_buttonImage;
	UIImage *_highlightedButtonImage;
	UIImage *_dividerImage;
	UIImage *_highlightedDividerImage;
	
	UIFont *_font;
	UIColor *_textColor;
	UIColor *_disabledTextColor;
	UIColor *_textShadowColor;
	CGSize _textShadowOffset;
	UIEdgeInsets _textEdgeInsets;
}

@property (nonatomic, assign, readonly) NSUInteger numberOfSegments;
@property (nonatomic, assign) NSInteger selectedSegmentIndex;
@property (nonatomic, getter=isMomentary) BOOL momentary;

@property (nonatomic, retain) UIImage *buttonImage;
@property (nonatomic, retain) UIImage *highlightedButtonImage;
@property (nonatomic, retain) UIImage *dividerImage;
@property (nonatomic, retain) UIImage *highlightedDividerImage;

@property (nonatomic, retain) UIFont *font;
@property (nonatomic, retain) UIColor *textColor;
@property (nonatomic, retain) UIColor *disabledTextColor;
@property (nonatomic, retain) UIColor *textShadowColor;
@property (nonatomic, assign) CGSize textShadowOffset;
@property (nonatomic, assign) UIEdgeInsets textEdgeInsets;

- (id)initWithItems:(NSArray *)items;

//- (void)insertSegmentWithTitle:(NSString *)title atIndex:(NSUInteger)segment animated:(BOOL)animated;
//- (void)insertSegmentWithImage:(UIImage *)image  atIndex:(NSUInteger)segment animated:(BOOL)animated;
//- (void)removeSegmentAtIndex:(NSUInteger)segment animated:(BOOL)animated;
//- (void)removeAllSegments;

- (void)setTitle:(NSString *)title forSegmentAtIndex:(NSUInteger)segment;
- (NSString *)titleForSegmentAtIndex:(NSUInteger)segment;

- (void)setImage:(UIImage *)image forSegmentAtIndex:(NSUInteger)segment;
- (UIImage *)imageForSegmentAtIndex:(NSUInteger)segment;

//- (void)setWidth:(CGFloat)width forSegmentAtIndex:(NSUInteger)segment;
//- (CGFloat)widthForSegmentAtIndex:(NSUInteger)segment;

//- (void)setContentOffset:(CGSize)offset forSegmentAtIndex:(NSUInteger)segment;
//- (CGSize)contentOffsetForSegmentAtIndex:(NSUInteger)segment;

- (void)setEnabled:(BOOL)enabled forSegmentAtIndex:(NSUInteger)segment;
- (BOOL)isEnabledForSegmentAtIndex:(NSUInteger)segment;

@end
