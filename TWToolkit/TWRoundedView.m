//
//  TWRoundedView.m
//  TWToolkit
//
//  Created by Sam Soffes on 9/18/09.
//  Copyright 2009 Tasteful Works, Inc. All rights reserved.
//

#import "TWRoundedView.h"

@interface TWRoundedView(PrivateMethods) 
- (void)drawRoundedCornersInRect:(CGRect)rect inContext:(CGContextRef)c;
- (void)drawCornerInContext:(CGContextRef)c cornerX:(NSInteger)x cornerY:(NSInteger)y arcEndX:(NSInteger)endX arcEndY:(NSInteger)endY;
@end


@implementation TWRoundedView

@synthesize radius;
@synthesize cornerColor;
@synthesize roundLowerLeft;
@synthesize roundLowerRight;
@synthesize roundUpperLeft;
@synthesize roundUpperRight;

- (id) initWithFrame:(CGRect) frame {
    if (self = [super initWithFrame:frame]) {
        self.cornerColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
        self.opaque = NO;
        radius = 5;
        roundUpperLeft = YES;
		roundUpperRight = YES;
        roundLowerLeft = YES;
		roundLowerRight = YES;
    }
    return self;
}


- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    // We pretend like no points are inside our bounds so the events
    // can continue up the responder chain
    return NO;
}


- (void) drawRect:(CGRect) rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (context != nil)  {
        CGContextSetFillColorWithColor(context, self.cornerColor.CGColor);
        [self drawRoundedCornersInRect:self.bounds inContext:context];
        CGContextFillPath(context);
    }
}


- (void) drawCornerInContext:(CGContextRef)context cornerX:(NSInteger)x cornerY:(NSInteger)y arcEndX:(NSInteger)endX arcEndY:(NSInteger)endY {
    CGContextMoveToPoint(context, x, endY);
    CGContextAddArcToPoint(context, x, y, endX, y, radius);
    CGContextAddLineToPoint(context, x, y);
    CGContextAddLineToPoint(context, x, endY);
}


- (void) drawRoundedCornersInRect:(CGRect)rect inContext:(CGContextRef)context {
	NSInteger x_left = rect.origin.x;
	NSInteger x_left_center = rect.origin.x + radius;
	NSInteger x_right_center = rect.origin.x + rect.size.width - radius;
	NSInteger x_right = rect.origin.x + rect.size.width;
	NSInteger y_top = rect.origin.y;
	NSInteger y_top_center = rect.origin.y + radius;
	NSInteger y_bottom_center = rect.origin.y + rect.size.height - radius;
	NSInteger y_bottom = rect.origin.y + rect.size.height;
	
    if (roundUpperLeft) {
        [self drawCornerInContext:context cornerX:x_left cornerY:y_top arcEndX:x_left_center arcEndY:y_top_center];
    }
	
    if (roundUpperRight) {
        [self drawCornerInContext:context cornerX:x_right cornerY:y_top arcEndX: x_right_center arcEndY:y_top_center];
    }
	
    if (roundLowerRight) {
        [self drawCornerInContext:context cornerX:x_right cornerY:y_bottom arcEndX:x_right_center arcEndY:y_bottom_center];
    }
	
    if (roundLowerLeft) {
        [self drawCornerInContext:context cornerX: x_left cornerY: y_bottom arcEndX: x_left_center arcEndY: y_bottom_center];
    }
}

@end
