//
//  ZXCHeaderToolView.h
//  ZXCPickerManagerDemo
//
//  Created by 周希财 on 2018/3/23.
//  Copyright © 2018年 VIC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZXCHeaderToolView : UIView
/**
 *  确认按钮
 */
@property (nonatomic, strong) UILabel *commitBar;

@property (nonatomic, copy) NSString *commitBarTitle;

@property (nonatomic, strong) UIColor *commitBarTintColor;

/**
 *  取消按钮
 */
@property (nonatomic, strong) UILabel *cancelBar;

@property (nonatomic, copy) NSString *cancelBarTitle;

@property (nonatomic, strong) UIColor *cancelBarTintColor;

/**
 *  中间提示信息
 */
@property (nonatomic, strong) UILabel *titleBar;

@property (nonatomic, copy) NSString *titleBarTitle;

@property (nonatomic, strong) UIColor *titleBarTextColor;

/**
 *  Blcok
 */

@property (nonatomic, copy) void (^commitBlock)(void);
@property (nonatomic, copy) void (^cancelBlock)(void);
@end
