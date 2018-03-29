//
//  ZXCAddressPickerView.h
//  ZXCPickerManagerDemo
//
//  Created by 周希财 on 2018/3/23.
//  Copyright © 2018年 VIC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressModel.h"
#import "ZXCHeaderToolView.h"

typedef void (^commitBlock)(NSString *address, NSString *zipcode);
typedef void (^cancelBlock)(void);
typedef NS_ENUM(NSInteger, SearchType) {
    SearchTypeAddress = 0,
    SearchTypeZipcode = 1,
    SearchTypeAddressIndex = 2,
    SearchTypeZipcodeIndex = 3,
};
@interface ZXCAddressPickerView : UIPickerView
@property (nonatomic, assign) NSInteger numberOfSection;
@property (nonatomic, strong) ZXCHeaderToolView *toolBar;

- (void)showZXCAddressPickerCommitBlock:(commitBlock)commitBlock cancelBlock:(cancelBlock)cancelBlock;

- (void)searchType:(SearchType)searchType key:(NSString *)key block:(void(^)(NSString *result))block;
@end
