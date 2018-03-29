//
//  ZXCPickerView.m
//  ZXCPickerManagerDemo
//
//  Created by 周希财 on 2018/3/23.
//  Copyright © 2018年 VIC. All rights reserved.
//
#define UISCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define UISCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#import "ZXCPickerView.h"
#import "ZXCHeaderToolView.h"

@interface ZXCPickerView()<UIPickerViewDelegate, UIPickerViewDataSource>
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, assign) NSInteger selectedRow;
@property (nonatomic, strong) ZXCHeaderToolView *toolBar;
@property (nonatomic, strong) UIView *containerView;

@end

@implementation ZXCPickerView

- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}


#pragma mark - create UI

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    [self initToolBar];
    [self initContainerView];
    self.frame = CGRectMake(0, 44, UISCREEN_WIDTH, 216);
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.delegate = self;
        self.dataSource = self;
        [self initBgView];
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

#pragma mark - Action
- (void)showZXCPickerViewWithDataArray:(NSArray *_Nonnull)array commitBlock:(void(^_Nonnull)(NSString * _Nonnull string, NSInteger index))commitBlock cancelBlock:(void(^_Nonnull)(void))cancelBlock{
    
    self.dataArr = [NSMutableArray arrayWithArray:array];
    [self reloadAllComponents];
    self.selectedRow = 0;
   
    [self selectRow:self.selectedRow inComponent:0 animated:NO];
    
    [self showWithAnimation];
    
    __weak __typeof(self) weakSelf = self;
    self.toolBar.cancelBlock = ^ {
        if (cancelBlock) {
            [weakSelf hiddenWithAnimation];
            cancelBlock();
        }
    };
    
    self.toolBar.commitBlock = ^ {
        [weakSelf hiddenWithAnimation];
        if (commitBlock) {
        
            commitBlock(weakSelf.dataArr[weakSelf.selectedRow], weakSelf.selectedRow);
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

#pragma mark - UIPickerViewDelegate,UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.dataArr.count;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 44;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.dataArr[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.selectedRow = row;
}


@end
