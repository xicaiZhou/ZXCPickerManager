//
//  ZXCDatePicker.m
//  ZXCPickerManagerDemo
//
//  Created by 周希财 on 2018/3/23.
//  Copyright © 2018年 VIC. All rights reserved.
//

#import "ZXCDatePicker.h"
#define UISCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define UISCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface ZXCDatePicker()
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIView *containerView;

@end

@implementation ZXCDatePicker

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initToolBar];
        [self initContainerView];

        self.frame = CGRectMake(0, 44, UISCREEN_WIDTH, 216);
        if (self) {
            self.backgroundColor = [UIColor whiteColor];
            self.datePickerMode = UIDatePickerModeDate;
            self.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
            [self initBgView];
        }
        return self;
    }
    return self;
}

- (void)initToolBar {
    self.toolBar = [[ZXCHeaderToolView alloc] initWithFrame:CGRectMake(0, 0, UISCREEN_WIDTH, 44)];
    self.toolBar.backgroundColor = [UIColor whiteColor];
}

- (void)initContainerView {
    self.containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UISCREEN_WIDTH, UISCREEN_HEIGHT)];
    self.containerView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    self.containerView.userInteractionEnabled = YES;
    [self.containerView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenWithAnimation)]];
}
- (void)initBgView {
    self.bgView = [[UIView alloc] initWithFrame:CGRectMake(0, UISCREEN_HEIGHT - self.frame.size.height - 44, UISCREEN_WIDTH, self.frame.size.height + self.toolBar.frame.size.height)];
}

- (void)showZXCDatePickerWithMinimumDate:(NSDate *)minimumDate maximumDate:(NSDate *)maximumDate commit:(CommitBlock)commitBlock cancel:(CancelBlock)cancelBlock{
   
    self.minimumDate = minimumDate;
    self.maximumDate = maximumDate;

    [self showWithAnimation];
    
    __weak __typeof(self) weakSelf = self;
    
    self.toolBar.cancelBlock = ^{
        [weakSelf hiddenWithAnimation];
        if (cancelBlock) {
            cancelBlock();
        }
    };
    
    self.toolBar.commitBlock = ^{
        
        [weakSelf hiddenWithAnimation];
        if (commitBlock) {
            //获取当前时区的准确时间
            NSInteger seconds = [[NSTimeZone systemTimeZone] secondsFromGMTForDate:weakSelf.date];
            NSDate *dateWithShangHai = [weakSelf.date dateByAddingTimeInterval:seconds];
            commitBlock(dateWithShangHai);
        }
    };
}
- (void)showWithAnimation {
    
    [self addViews];
    self.containerView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
    CGFloat height = self.bgView.frame.size.height;
    self.bgView.center = CGPointMake(UISCREEN_WIDTH / 2, UISCREEN_HEIGHT + height / 2);
    [UIView animateWithDuration:0.25 animations:^{
        self.bgView.center = CGPointMake(UISCREEN_WIDTH / 2, UISCREEN_HEIGHT - height / 2);
        self.containerView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    }];
    
}

- (void)hiddenWithAnimation {
    CGFloat height = self.bgView.frame.size.height;
    [UIView animateWithDuration:0.25 animations:^{
        self.bgView.center = CGPointMake(UISCREEN_WIDTH / 2, UISCREEN_HEIGHT + height / 2);
        self.containerView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
    } completion:^(BOOL finished) {
        [self hiddenViews];
    }];
}

- (void)addViews {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self.containerView];
    [window addSubview:self.bgView];
    [self.bgView addSubview:self.toolBar];
    [self.bgView addSubview:self];
}

- (void)hiddenViews {
    [self removeFromSuperview];
    [self.toolBar removeFromSuperview];
    [self.bgView removeFromSuperview];
    [self.containerView removeFromSuperview];
}
@end
