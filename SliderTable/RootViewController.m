//
//  RootViewController.m
//  SliderTable
//
//  Created by uuu9 on 2017/7/20.
//  Copyright © 2017年 My. All rights reserved.
//

#import "RootViewController.h"
#import "Slider/SliderView.h"
#import "Masonry/Masonry.h"
#import "CustomLabel.h"
#import "ViewController1.h"
#import "ViewController2.h"
#import "ViewController3.h"
#import "ViewController4.h"
#import "ViewController5.h"

#define kScreenHeight [[UIScreen mainScreen] bounds].size.height
#define kScreenWidth  [[UIScreen mainScreen] bounds].size.width


#define titleHeight 36

@interface RootViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *contentScrollView;

@property (nonatomic, strong) SliderView *sliderScrollView;

@property (nonatomic, strong) UIView *sliderLine;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *array = [NSArray arrayWithObjects:@"11red111",@"2blue",@"333green333",@"44",@"5555white55555", nil];
    [self setChildrenViewController:array];
    
    [self.view addSubview:self.sliderScrollView];
    self.sliderScrollView.titleArray = [NSMutableArray arrayWithArray:array];
    [self.sliderScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.offset(0);
        make.height.mas_equalTo(titleHeight);
    }];
    NSLog(@"%i",self.sliderScrollView.subviews.count);
    
    self.sliderLine = [[UIView alloc] init];
    self.sliderLine.frame = CGRectMake(0, titleHeight - 1, self.sliderScrollView.firstWidth, 1);
    self.sliderLine.backgroundColor = [UIColor blueColor];
    [self.sliderScrollView addSubview:self.sliderLine]; 
    
 
    
    [self.view addSubview:self.contentScrollView];
    [self.contentScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.sliderScrollView.mas_bottom).offset(0);
        make.left.right.bottom.offset(0);
    }];
    self.contentScrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame) * array.count, 0);
    
    // 默认显示第0个子控制器
    [self scrollViewDidEndScrollingAnimation:self.contentScrollView];
    
}

- (SliderView *)sliderScrollView{
    if (!_sliderScrollView) {
        _sliderScrollView = [[SliderView alloc] init];
        _sliderScrollView.backgroundColor = [UIColor lightGrayColor];
        _sliderScrollView.showsHorizontalScrollIndicator = false;
        _sliderScrollView.pagingEnabled = YES;
        _sliderScrollView.height = titleHeight;
        __weak RootViewController *rootVC = self;
        _sliderScrollView.clickBlock = ^(NSInteger index) {
            [rootVC sliderClick:index];
        };
    }
    return _sliderScrollView;
}


- (void)sliderClick:(NSInteger)index{
    UIView * view= self.sliderScrollView.subviews[index];
    if ([view isKindOfClass:[CustomLabel class]]) {
        // 让底部的内容scrollView滚动到对应位置
        CGPoint offset = self.contentScrollView.contentOffset;
        offset.x = index * self.contentScrollView.frame.size.width;
        [self.contentScrollView setContentOffset:offset animated:YES];
    }
}


- (UIScrollView *)contentScrollView{
    if (!_contentScrollView) {
        _contentScrollView = [[UIScrollView alloc] init];
        _contentScrollView.backgroundColor = [UIColor whiteColor];
        _contentScrollView.delegate = self;
        _contentScrollView.pagingEnabled = YES;
        _contentScrollView.showsHorizontalScrollIndicator = false;
    }
    return _contentScrollView;
}

- (void)setChildrenViewController:(NSArray *)array{
    for (int i = 0; i < array.count; i++) {
        if (i == 0) {
            ViewController1 *vc = [[ViewController1 alloc] initWithNibName:@"ViewController1" bundle:nil];
            vc.title = [array objectAtIndex:i];
            [self addChildViewController:vc];
        } else if (i == 1) {
            ViewController2 *vc = [[ViewController2 alloc] initWithNibName:@"ViewController2" bundle:nil];
            vc.title = [array objectAtIndex:i];
            [self addChildViewController:vc];
            
        } else if (i == 2) {
            ViewController3 *vc = [[ViewController3 alloc] initWithNibName:@"ViewController3" bundle:nil];
            vc.title = [array objectAtIndex:i];
            [self addChildViewController:vc];
            
        } else if (i == 3) {
            ViewController4 *vc = [[ViewController4 alloc] initWithNibName:@"ViewController4" bundle:nil];
            vc.title = [array objectAtIndex:i];
            [self addChildViewController:vc];
            
        } else if (i == 4) {
            ViewController5 *vc = [[ViewController5 alloc] initWithNibName:@"ViewController5" bundle:nil];
            vc.title = [self.sliderScrollView.titleArray objectAtIndex:i];
            [self addChildViewController:vc];
            
        }
    }
}

#pragma mark UIScrollerView Delegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
}


- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    CGFloat width = scrollView.frame.size.width;
    CGFloat height = scrollView.frame.size.height;
    CGFloat offsetX = scrollView.contentOffset.x;
    NSInteger index = offsetX / width;
    
    // 让对应的顶部标题居中显示
    CustomLabel *label = self.sliderScrollView.subviews[index];//当前需要显示的label
    
    
    // 让其他label回到最初的状态
    for (UIView *otherLabel in self.sliderScrollView.subviews) {
        if ([otherLabel isKindOfClass:[CustomLabel class]]) {
            if (otherLabel != label) {
                ((CustomLabel *)otherLabel).scale = 0.0;
            }
        }
        
    }
    [UIView animateWithDuration:0.15 animations:^{
        CGRect frame = self.sliderLine.frame;
        frame.size.width = label.frame.size.width;
        frame.origin.x = label.frame.origin.x;
        [self.sliderLine setFrame:frame];
    }];
    
    UIViewController *willShowVc = self.childViewControllers[index];
    if ([willShowVc isViewLoaded]) {
        return;
    }
    willShowVc.view.frame = CGRectMake(offsetX, 0, width, height);
    [scrollView addSubview:willShowVc.view];
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.x < 0) {
        CGPoint offset = self.contentScrollView.contentOffset;
        offset.x = 0;
        [self.contentScrollView setContentOffset:offset animated:NO];
    }else {
        CGFloat scale = scrollView.contentOffset.x / kScreenWidth;
        if (scale < 0 || scale > self.sliderScrollView.subviews.count - 1) {
            return;
        }
        NSInteger leftIndex = scale;
        CustomLabel *leftLabel = self.sliderScrollView.subviews[leftIndex];
        
        NSInteger rightIndex = leftIndex + 1;
        CustomLabel *rightLabel = (rightIndex == self.sliderScrollView.titleArray.count) ? nil : self.sliderScrollView.subviews[rightIndex];
        // 右边比例
        CGFloat rightScale = scale - leftIndex;
        // 左边比例
        CGFloat leftScale = 1 - rightScale;
        
        // 设置label的比例
        leftLabel.scale = leftScale;
        rightLabel.scale = rightScale;
        
        
        CGPoint titleOffset = self.sliderScrollView.contentOffset;
        titleOffset.x = leftLabel.center.x - kScreenWidth * 0.5;
        CGFloat maxTitleOffsetX = self.sliderScrollView.contentSize.width - scrollView.frame.size.width;
        // 左边超出处理
        if (titleOffset.x < 0) {
            titleOffset.x = 0;
        } else if (titleOffset.x > maxTitleOffsetX) {// 右边超出处理
            titleOffset.x = maxTitleOffsetX;
        }
        
        [self.sliderScrollView setContentOffset:titleOffset animated:YES];
    }
}

@end
