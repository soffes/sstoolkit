//
//  SSSegmentedControl.h
//  SSToolkit
//
//  Created by Sam Soffes on 2/7/11.
//  Copyright 2011 Sam Soffes. All rights reserved.
//

// Limitiations:
// - Images not supported
// - Removing and inserting items is not supported
// - Momentary mode is not supported
// - Setting item width is not supported
// - Setting item content offset is not supported
// - Enabling and disabling items is not supported

@interface SSSegmentedControl : UIControl {

	NSMutableArray *_items;
	NSInteger _selectedSegmentIndex;
	
	UIImage *_buttonImage;
	UIImage *_highlightedButtonImage;
	UIImage *_dividerImage;
	UIImage *_highlightedDividerImage;
}

//@property (nonatomic, getter=isMomentary) BOOL momentary;
@property (nonatomic, assign, readonly) NSUInteger numberOfSegments;
@property (nonatomic, assign) NSInteger selectedSegmentIndex;

@property (nonatomic, retain) UIImage *buttonImage;
@property (nonatomic, retain) UIImage *highlightedButtonImage;
@property (nonatomic, retain) UIImage *dividerImage;
@property (nonatomic, retain) UIImage *highlightedDividerImage;

- (id)initWithItems:(NSArray *)items;

//- (void)insertSegmentWithTitle:(NSString *)title atIndex:(NSUInteger)segment animated:(BOOL)animated; // insert before segment number. 0..#segments. value pinned
//- (void)insertSegmentWithImage:(UIImage *)image  atIndex:(NSUInteger)segment animated:(BOOL)animated;
//- (void)removeSegmentAtIndex:(NSUInteger)segment animated:(BOOL)animated;
//- (void)removeAllSegments;

- (void)setTitle:(NSString *)title forSegmentAtIndex:(NSUInteger)segment;
- (NSString *)titleForSegmentAtIndex:(NSUInteger)segment;

//- (void)setImage:(UIImage *)image forSegmentAtIndex:(NSUInteger)segment;
//- (UIImage *)imageForSegmentAtIndex:(NSUInteger)segment;

//- (void)setWidth:(CGFloat)width forSegmentAtIndex:(NSUInteger)segment;
//- (CGFloat)widthForSegmentAtIndex:(NSUInteger)segment;

//- (void)setContentOffset:(CGSize)offset forSegmentAtIndex:(NSUInteger)segment;
//- (CGSize)contentOffsetForSegmentAtIndex:(NSUInteger)segment;

//- (void)setEnabled:(BOOL)enabled forSegmentAtIndex:(NSUInteger)segment;
//- (BOOL)isEnabledForSegmentAtIndex:(NSUInteger)segment;

@end
