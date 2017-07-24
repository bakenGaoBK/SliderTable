//
//  CustomLabel.m
//  U9WatchGame
//
//  Created by uuu9 on 16/2/23.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import "CustomLabel.h"

static const CGFloat XMGRed = 0.4;
static const CGFloat XMGGreen = 0.4;
static const CGFloat XMGBlue = 0.4;

@implementation CustomLabel


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.font = [UIFont systemFontOfSize:15];
        self.textColor = [UIColor colorWithRed:XMGRed green:XMGGreen blue:XMGBlue alpha:1.0];
        self.textAlignment = NSTextAlignmentCenter;
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = YES;
        
    }
    return self;
}

- (void)setScale:(CGFloat)scale
{
    _scale = scale;
    
    //      R G B
    // 默认：0.4 0.6 0.7
    // 红色：1   0   0
    
    CGFloat red = XMGRed + (0.23 - XMGRed) * scale;
    CGFloat green = XMGGreen + (0.47 - XMGGreen) * scale;
    CGFloat blue = XMGBlue + (0.8 - XMGBlue) * scale;
    self.textColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    
    // 大小缩放比例
    CGFloat transformScale = 1 + scale * 0.13; // [1, 1.3]
    self.transform = CGAffineTransformMakeScale(transformScale, transformScale);
}


@end
