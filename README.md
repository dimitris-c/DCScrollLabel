DCScrollLabel
=============

A simple scroll label for iOS.

Basic Usage
```
_scrollLabel = [[DCScrollLabel alloc] initWithFrame:CGRectMake(50, 150, 200, 40)];
_scrollLabel.textColor = [UIColor whiteColor];
_scrollLabel.textsArray = [@[@"First Text Goes Here",
                             @"Second Text Goes Here",
                             @"Third Text Goes Here",
                             @"And So On..."] mutableCopy];

// Label customization
_scrollLabel.font = [UIFont systemFontOfSize:15];
_scrollLabel.scrollSpeed = 40.0f;
_scrollLabel.pauseDelay = 2.0f;
_scrollLabel.labelPadding = 20.0f;
_scrollLabel.textAlignment = NSTextAlignmentCenter;
_scrollLabel.backgroundColor = [UIColor darkGrayColor];
    
[self.view addSubview:_scrollLabel];

[_scrollLabel startScrolling];
```
