//
//  DCScrollLabel.h
//
//  Created by Dimitris Chatzieleftheriou on 5/14/14.
//  Copyright (c) 2014 Dimitris Chatzieleftheriou. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^VoidBlock)(void);

/**
 A simple scroll label that takes an array of texts and displays them one after another.
 */
@interface DCScrollLabel : UIView

/**
 An array of texts that the label will display one after another
 */
@property (nonatomic, strong) NSMutableArray *textsArray;

@property (nonatomic, assign) NSTextAlignment textAlignment;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIFont *font;

@property (nonatomic, assign, readonly) BOOL isScrolling;

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

- (id)initWithFrame:(CGRect)frame andTexts:(NSMutableArray *)textsArray;

- (void)startScrolling;
- (void)stopScrolling;

@end
