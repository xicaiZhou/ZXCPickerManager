//
//  ZXCPickerView.h
//  ZXCPickerManagerDemo
//
//  Created by 周希财 on 2018/3/23.
//  Copyright © 2018年 VIC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZXCHeaderToolView.h"

@interface ZXCPickerView : UIPickerView
@property (nonatomic, strong) ZXCHeaderToolView *toolBar;

- (void)showZXCPickerViewWithDataArray:(NSArray *)array commitBlock:(void(^)(NSString *string, NSInteger index))commitBlock cancelBlock:(void(^)(void))cancelBlock;
@end
