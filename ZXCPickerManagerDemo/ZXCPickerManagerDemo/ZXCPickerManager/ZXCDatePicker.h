//
//  ZXCDatePicker.h
//  ZXCPickerManagerDemo
//
//  Created by 周希财 on 2018/3/23.
//  Copyright © 2018年 VIC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZXCHeaderToolView.h"

typedef void (^CommitBlock)(NSDate *date);
typedef void (^CancelBlock)(void);

@interface ZXCDatePicker : UIDatePicker
@property (nonatomic, strong) ZXCHeaderToolView *toolBar;

/**
 
 @param minimumDate 起始
 @param maximumDate 截至
 @param commitBlock 确定
 @param cancelBlock 取消
 */
- (void)showZXCDatePickerWithMinimumDate:(NSDate *)minimumDate maximumDate:(NSDate *)maximumDate commit:(CommitBlock)commitBlock cancel:(CancelBlock)cancelBlock;


@end
