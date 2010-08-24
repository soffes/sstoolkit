//
//  SSCollectionViewItem.h
//  SSToolkit
//
//  Created by Sam Soffes on 6/11/10.
//  Copyright 2010 Sam Soffes. All rights reserved.
//

typedef enum {
    SSCollectionViewItemStyleDefault = UITableViewCellStyleDefault,
    SSCollectionViewItemStyleSubtitle = UITableViewCellStyleSubtitle,
    SSCollectionViewItemStyleBlank
} SSCollectionViewItemStyle;

typedef enum {
	SSCollectionViewItemVerticalAlignmentCenter = UIControlContentVerticalAlignmentCenter,
	SSCollectionViewItemVerticalAlignmentTop = UIControlContentVerticalAlignmentTop,
	SSCollectionViewItemVerticalAlignmentBottom = UIControlContentVerticalAlignmentBottom
} SSCollectionViewItemVerticalAlignment;

//typedef enum {
//    SSCollectionViewItemSelectionStyleNone = UITableViewCellSelectionStyleNone,
//    SSCollectionViewItemSelectionStyleBlue = UITableViewCellSelectionStyleBlue,
//    SSCollectionViewItemSelectionStyleGray = UITableViewCellSelectionStyleGray
//} SSCollectionViewItemSelectionStyle;

//typedef enum {
//    SSCollectionViewItemEditingStyleNone = UITableViewCellEditingStyleNone,
//    SSCollectionViewItemEditingStyleDelete = UITableViewCellEditingStyleDelete,
//    SSCollectionViewItemEditingStyleInsert = UITableViewCellEditingStyleInsert
//} SSCollectionViewItemEditingStyle;


@interface SSCollectionViewItem : UIView {
	
	SSCollectionViewItemStyle _style;
	SSCollectionViewItemVerticalAlignment _verticalAlignment;
	CGSize _preferredContentSize;
	
	NSString *_reuseIdentifier;
    UIView *_contentView;
	UILabel *_textLabel;
	UILabel *_detailTextLabel;
    UIView *_backgroundView;
    UIView *_selectedBackgroundView;
	
	BOOL _selected;
	BOOL _highlighted;
}

- (id)initWithStyle:(SSCollectionViewItemStyle)style reuseIdentifier:(NSString *)aReuseIdentifier;

@property (nonatomic, assign) SSCollectionViewItemVerticalAlignment verticalAlignment;
@property (nonatomic, assign) CGSize preferredContentSize;

@property (nonatomic, readonly, retain) UILabel *textLabel;
@property (nonatomic, readonly, retain) UILabel *detailTextLabel;

@property (nonatomic, retain) UIView *backgroundView;
@property (nonatomic, retain) UIView *selectedBackgroundView;

@property (nonatomic, readonly, copy) NSString *reuseIdentifier;

@property (nonatomic, getter=isSelected) BOOL selected;
@property (nonatomic, getter=isHighlighted) BOOL highlighted;


- (void)prepareForReuse; 

- (void)setSelected:(BOOL)selected animated:(BOOL)animated;
- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated;

@end
