//
//  SSRatingPicker.h
//  SSToolkit
//
//  Created by Sam Soffes on 2/2/11.
//  Copyright 2011 Sam Soffes. All rights reserved.
//

@interface SSRatingPicker : UIControl {

@private
	
	CGFloat _numberOfStars;
	NSUInteger _totalNumberOfStars;
	UIImage *_emptyStarImage;
	UIImage *_filledStarImage;
	CGSize _starSize;
	CGFloat _starSpacing;
	UILabel *_textLabel;
}

@property (nonatomic, assign) CGFloat numberOfStars;
@property (nonatomic, assign) NSUInteger totalNumberOfStars;
@property (nonatomic, retain) UIImage *emptyStarImage;
@property (nonatomic, retain) UIImage *filledStarImage;
@property (nonatomic, assign) CGSize starSize;
@property (nonatomic, assign) CGFloat starSpacing;
@property (nonatomic, retain) UILabel *textLabel;

@end
