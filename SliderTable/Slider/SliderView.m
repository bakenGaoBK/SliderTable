//
//  SliderView.m
//  SliderTable
//
//  Created by uuu9 on 2017/7/20.
//  Copyright © 2017年 My. All rights reserved.
//

#import "SliderView.h"
#import "CustomLabel.h"

@interface SliderView()

@end

@implementation SliderView


- (void)setTitleArray:(NSMutableArray *)titleArray{
    _titleArray = titleArray;
    CGFloat totalWidth = 0;
    for (NSInteger i = 0; i < self.titleArray.count; i++) {
        CustomLabel *label = [[CustomLabel alloc] init];
        [self addSubview:label];
        label.text = self.titleArray[i];
       
        NSAttributedString *attr = [[NSAttributedString alloc] initWithString:label.text attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];
        CGFloat width = [attr boundingRectWithSize:CGSizeMake(MAXFLOAT, 19) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.width + 20;
        
        CGFloat labelX = totalWidth;
        totalWidth += width;
        label.frame = CGRectMake(labelX, 0, width, self.height);
        [label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick:)]];
        label.tag = i;
        [self addSubview:label];
        
        if (i == 0) { // 最前面的label
            label.scale = 1.0;
            self.firstWidth = ceilf(totalWidth);
        }
    };
    self.contentSize = CGSizeMake(ceilf(totalWidth), 0);
    self.contentOffset = CGPointMake(0, 0);
}

/**
 * 监听顶部label点击
 */
- (void)labelClick:(UITapGestureRecognizer *)tap {
    // 取出被点击label的索引
    NSInteger index = tap.view.tag;
    _clickBlock(index);
}


@end
