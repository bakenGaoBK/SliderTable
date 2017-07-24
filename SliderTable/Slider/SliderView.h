//
//  SliderView.h
//  SliderTable
//
//  Created by uuu9 on 2017/7/20.
//  Copyright © 2017年 My. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface SliderView : UIScrollView

@property (nonatomic, strong) NSMutableArray *titleArray;

@property (nonatomic, assign) CGFloat firstWidth;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, copy) void (^clickBlock)(NSInteger);

@end
