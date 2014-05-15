//
//  DCViewController.m
//  DCScollLabelPreview
//
//  Created by Dimitris Chatzieleftheriou on 5/14/14.
//  Copyright (c) 2014 Dimitris C. All rights reserved.
//

#import "DCViewController.h"
#import "DCScrollLabel.h"

@interface DCViewController ()

@property (nonatomic, strong) DCScrollLabel *scrollLabel;

@end

@implementation DCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    _scrollLabel = [[DCScrollLabel alloc] initWithFrame:CGRectMake(50, 150, 200, 40)];
    _scrollLabel.textColor = [UIColor whiteColor];
    _scrollLabel.textsArray = [@[@"First Text Goes Here",
                                 @"Second Text Goes Here",
                                 @"Third Text Goes Here",
                                 @"And So On..."] mutableCopy];
    
    _scrollLabel.font = [UIFont systemFontOfSize:15];
    _scrollLabel.scrollSpeed = 40.0f;
    _scrollLabel.pauseDelay = 2.0f;
    _scrollLabel.labelPadding = 20.0f;
    _scrollLabel.textAlignment = NSTextAlignmentCenter;
    _scrollLabel.backgroundColor = [UIColor darkGrayColor];
    
    [self.view addSubview:_scrollLabel];
    
    [_scrollLabel startScrolling];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(stopScrolling)];
    [self.view addGestureRecognizer:tap];
}

- (void)stopScrolling {
    [_scrollLabel stopScrolling];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_scrollLabel startScrolling];
    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

@end
