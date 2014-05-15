//
//  DCScrollLabel.h
//
//  Created by Dimitris Chatzieleftheriou on 5/14/14.
//  Copyright (c) 2014 Dimitris Chatzieleftheriou. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 A simple scroll label that takes an array of texts and displays them one after another.
 */
@interface DCScrollLabel : UIView

/**
 Whether the label is scrolling or not.
 */
@property (nonatomic, assign, readonly) BOOL isScrolling;

/**
 An array of texts that the label will display one after another
 */
@property (nonatomic, strong) NSMutableArray *textsArray;

@property (nonatomic) NSTextAlignment textAlignment;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIFont *font;

/**
    The speed of the scrolling.
 */
@property (nonatomic, assign) CGFloat scrollSpeed;

/**
    The time, in seconds, of which each label should stay visible.
 */
@property (nonatomic, assign) CGFloat pauseDelay;

/**
 The padding between each label.
 */
@property (nonatomic, assign) CGFloat labelPadding;

// TODO: unimplemented
@property (nonatomic, assign) NSInteger repeatCount;

/**
 Initializes and returns a newly allocated DCScrollLabel object with the specified frame rectangle and an array of texts to be shown.
 
 @param frame A rectangle for the label view
 @param textsArray A mutable array that holds any text to be shown.
 
 */
- (id)initWithFrame:(CGRect)frame andTexts:(NSMutableArray *)textsArray;


/**
 Starts the scrolling of the label.
 */
- (void)startScrolling;

/**
 Stops and resets the scrolling of the label.
 */
- (void)stopScrolling;

@end
