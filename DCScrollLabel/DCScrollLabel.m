//
//  DCScrollLabel.h
//
//  Created by Dimitris Chatzieleftheriou on 5/14/14.
//  Copyright (c) 2014 Dimitris Chatzieleftheriou. All rights reserved.
//

#import "DCScrollLabel.h"

// Initial values
static const NSUInteger kTotalLabels            = 2;
static const CGFloat    kDefaultScrollSpeed     = 30.0f;
static const CGFloat    kDefaultPauseDelay      = 2.0f;
static const CGFloat    kDefaultLabelPadding    = 5.0f;
static const NSInteger  kDefaultRepeatCount     = -1;

@interface DCScrollLabel ()

@property (nonatomic, strong) NSMutableArray *labelsArray;
@property (nonatomic, strong) UILabel *currentLabelVisible;

@property (nonatomic, assign, readwrite) BOOL isScrolling;

@end

@implementation DCScrollLabel {
    
    NSInteger *currentRepeatCount;
    NSInteger currentLabelTextIndex;
    
}

#pragma mark - Initializing Methods -

- (id)initWithFrame:(CGRect)frame {
    self = [self initWithFrame:frame andTexts:nil];
    if (self) {
        [self setupLabels];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame andTexts:(NSMutableArray *)textsArray
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setupLabels];
        
        if (textsArray)
            self.textsArray = textsArray;
        
    }
    return self;
}

#pragma mark - Private Methods -

- (void)setupLabels {
    
    _scrollSpeed    = kDefaultScrollSpeed;
    _pauseDelay     = kDefaultPauseDelay;
    _labelPadding   = kDefaultLabelPadding;
    _repeatCount    = kDefaultRepeatCount;
    
    _labelsArray    = [[NSMutableArray alloc] initWithCapacity:kTotalLabels];
    
    for (int i = 0; i < kTotalLabels; i++) {
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
        label.backgroundColor = [UIColor clearColor];
        label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        
        if (_textsArray) {
            label.text = _textsArray[i % _textsArray.count];
        }
        
        [self addSubview:label];
        
        [_labelsArray addObject:label];
    }
    
    currentLabelTextIndex = 1;
    _currentLabelVisible = _labelsArray[0];
    
    self.backgroundColor = [UIColor clearColor];
    self.userInteractionEnabled = NO;
    self.clipsToBounds = YES;
    
}

- (void)setTextsArray:(NSMutableArray *)textsArray {
    
    _textsArray = textsArray;
    
    if (!_labelsArray) return;
    
    NSInteger index = 0;
    
    for (UILabel *label in _labelsArray) {
        label.text = _textsArray[index % _textsArray.count];
        index++;
    }
    
    [self updateLabels];
    
    textsArray = nil;
    
}

- (void)updateLabels {
    
    CGFloat labelOriginX = 0;
    
    for (UILabel *label in _labelsArray) {
        CGRect frame = label.frame;
        frame.origin.x = labelOriginX;
        frame.size.width = CGRectGetWidth(self.frame);
        frame.size.height = CGRectGetHeight(self.frame);
        label.frame = frame;
        
        labelOriginX += CGRectGetWidth(label.frame) + _labelPadding;
    };
    
}

#pragma mark - Label Methods -

- (void)setFont:(UIFont *)font
{
    for (UILabel *label in _labelsArray) {
        label.font = font;
    };
    
}

- (void)setTextColor:(UIColor *)textColor {

    for (UILabel *label in _labelsArray) {
        label.textColor = textColor;
    };
    
}

- (void)setTextAlignment:(NSTextAlignment )textAlignment {
    
    for (UILabel *label in _labelsArray) {
        label.textAlignment = textAlignment;
    };
    
}

#pragma mark - Scrolling Methods -

- (void)startScrolling {
    
    _isScrolling = YES;
    
    CGFloat labelWidth = CGRectGetWidth( _currentLabelVisible.frame );
    
    CGFloat labelDuration = labelWidth / _scrollSpeed;
    
    
    UILabel *firstLabel = _labelsArray[0];
    UILabel *secondLabel = _labelsArray[1];

    [UIView animateWithDuration:labelDuration
                          delay:_pauseDelay
                        options:UIViewAnimationOptionCurveLinear
                     animations:^ {
                         
                         CGRect frame = firstLabel.frame;
                         frame.origin.x = - (CGRectGetWidth(firstLabel.frame) + _labelPadding);
                         
                         firstLabel.frame = frame;
                         
                         frame = secondLabel.frame;
                         frame.origin.x = 0;
                         
                         secondLabel.frame = frame;
                        
                     }
                     completion:^(BOOL finished) {

                         if (finished) {
                             
                             CGRect frame = firstLabel.frame;
                             frame.origin.x = CGRectGetWidth(secondLabel.frame) + _labelPadding;
                             
                             firstLabel.frame = frame;
                             
                             // swap the labels on the array
                             [_labelsArray exchangeObjectAtIndex:0 withObjectAtIndex:1];
                             _currentLabelVisible = _labelsArray[0];
                         
                             currentLabelTextIndex++;
                             if (currentLabelTextIndex > _textsArray.count-1) {
                                 currentLabelTextIndex = 0;
                             }
                             firstLabel.text = _textsArray[currentLabelTextIndex];
                         
                             [self startScrolling];
                         }
                         
                     }];
    
}

- (void)stopScrolling {
    
    _isScrolling = NO;
    
    UILabel *firstLabel = _labelsArray[0];
    UILabel *secondLabel = _labelsArray[1];
    
    [firstLabel.layer removeAllAnimations];
    [secondLabel.layer removeAllAnimations];
    
    currentLabelTextIndex = 1;
    firstLabel.text = _textsArray[0];
    secondLabel.text = _textsArray[currentLabelTextIndex % _textsArray.count];
    
    CGRect frame = firstLabel.frame;
    frame.origin.x = 0;
    firstLabel.frame = frame;
    
    frame = secondLabel.frame;
    frame.origin.x = CGRectGetWidth(firstLabel.frame) + _labelPadding;
    secondLabel.frame = frame;

}

@end
