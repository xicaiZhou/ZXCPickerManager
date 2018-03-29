//
//  ZXCPickerManager.m
//  ZXCPickerManagerDemo
//
//  Created by 周希财 on 2018/3/23.
//  Copyright © 2018年 VIC. All rights reserved.
//

#import "ZXCPickerManager.h"
#import "ZXCDatePicker.h"
#import "ZXCPickerView.h"
#import "ZXCAddressPickerView.h"

@interface ZXCPickerManager()
@property (nonatomic, strong) ZXCDatePicker * _Nonnull datePicker;

@property (nonatomic, strong) ZXCPickerView * _Nonnull pickView;

@property (nonatomic, strong) ZXCAddressPickerView * _Nonnull addressPicker;
@end

@implementation ZXCPickerManager

+(ZXCPickerManager *)sharePickerManager{
    
    static ZXCPickerManager *manager = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        manager = [self new];
    });
    return manager;
}

- (ZXCDatePicker *)datePicker{
    if (!_datePicker){
        _datePicker = [ZXCDatePicker new];
    }
    return _datePicker;
}
- (ZXCPickerView *)pickView{
    if (!_pickView){
        _pickView = [ZXCPickerView new];
    }
    return _pickView;
}
- (ZXCAddressPickerView *)addressPicker{
    if (!_addressPicker){
        _addressPicker = [ZXCAddressPickerView new];
    }
    return _addressPicker;
}
- (void)showDatePickerWithminimumDate:(NSDate *_Nullable)minimumDate maximumDate:(NSDate *_Nullable)maximumDate commitBlock:(DatePickerCommitBlock _Nonnull)commitBlock Cancel:(DataPickerCancelBlock _Nonnull)cancelBlock{
    self.datePicker.datePickerMode = UIDatePickerModeDate;
    
    self.datePicker.toolBar.cancelBarTitle = @"取消";
    self.datePicker.toolBar.commitBarTitle = @"确定";
    self.datePicker.toolBar.titleBarTitle = @"请选择日期";
    [self.datePicker showZXCDatePickerWithMinimumDate:minimumDate maximumDate:maximumDate commit:commitBlock cancel:cancelBlock];
}
- (void)showZXCPickerViewWithDataArray:(NSArray *_Nonnull)array title:(NSString * _Nonnull)title commitBlock:(void(^_Nonnull)(NSString * _Nonnull string, NSInteger index))commitBlock cancelBlock:(void(^_Nonnull)(void))cancelBlock{
    
    self.pickView.toolBar.titleBarTitle = title;
    [self.pickView showZXCPickerViewWithDataArray:array commitBlock:commitBlock cancelBlock:cancelBlock];
    
}


- (void)showZXCAddressPickerWithTitle:(NSString *)title cancelTitle:(NSString *)cancelTitle commitTitle:(NSString *)commitTitle commitBlock:(void(^)(NSString *address, NSString *zipcode))commitBlock cancelBlock:(void(^)(void))cancelBlock {
    self.addressPicker.toolBar.titleBarTitle = title;
    self.addressPicker.toolBar.cancelBarTitle = cancelTitle;
    self.addressPicker.toolBar.commitBarTitle = commitTitle;
    
    [self.addressPicker showZXCAddressPickerCommitBlock:^(NSString *address, NSString *zipcode) {
        if (commitBlock) {
            commitBlock(address, zipcode);
        }
    } cancelBlock:^{
        if (cancelBlock) {
            cancelBlock();
        }
    }];
}

- (void)showZXCAddressPickerWithDefaultAddress:(NSString *)address title:(NSString *)title cancelTitle:(NSString *)cancelTitle commitTitle:(NSString *)commitTitle commitBlock:(void(^)(NSString *address, NSString *zipcode))commitBlock cancelBlock:(void(^)(void))cancelBlock {
    self.addressPicker.toolBar.titleBarTitle = title;
    self.addressPicker.toolBar.cancelBarTitle = cancelTitle;
    self.addressPicker.toolBar.commitBarTitle = commitTitle;
    
    [self.addressPicker showZXCAddressPickerCommitBlock:^(NSString *address, NSString *zipcode) {
        if (commitBlock) {
            commitBlock(address, zipcode);
        }
    } cancelBlock:^{
        if (cancelBlock) {
            cancelBlock();
        }
    }];
    
    if (address == nil || [address isEqualToString:@""]) {
        return;
    }
    
    [self searchIndexByAddress:address block:^(NSString *address) {
        if (![address containsString:@"error"]) {
            NSArray *indexArr = [address componentsSeparatedByString:@"-"];
            for (int i = 0; i < indexArr.count; i++) {
                @try {
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [self.addressPicker selectRow:[indexArr[i] integerValue] inComponent:i animated:NO];
                    });
                } @catch (NSException *exception) {
                    
                } @finally {
                    
                }
                
            }
        }
    }];
    
}

- (void)showZXCAddressPickerWithDefaultZipcode:(NSString *)zipcode title:(NSString *)title cancelTitle:(NSString *)cancelTitle commitTitle:(NSString *)commitTitle commitBlock:(void (^)(NSString *, NSString *))commitBlock cancelBlock:(void (^)(void))cancelBlock {
    self.addressPicker.toolBar.titleBarTitle = title;
    self.addressPicker.toolBar.cancelBarTitle = cancelTitle;
    self.addressPicker.toolBar.commitBarTitle = commitTitle;
    
    [self.addressPicker showZXCAddressPickerCommitBlock:^(NSString *address, NSString *zipcode) {
        if (commitBlock) {
            commitBlock(address, zipcode);
        }
    } cancelBlock:^{
        if (cancelBlock) {
            cancelBlock();
        }
    }];
    
    if (zipcode == nil || [zipcode  isEqual: @""]) {
        return;
    }
    
    [self searchIndexByZipCode:zipcode block:^(NSString *address) {
        if (![address containsString:@"error"]) {
            NSArray *indexArr = [address componentsSeparatedByString:@"-"];
            for (int i = 0; i < indexArr.count; i++) {
                @try {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.addressPicker selectRow:[indexArr[i] integerValue] inComponent:i animated:NO];
                    });
                } @catch (NSException *exception) {
                    
                } @finally {
                    
                }
                
            }
        }
    }];
    
}

- (void)searchAddressByZipcode:(NSString *)zipcode block:(void(^)(NSString *address))block {
    [self.addressPicker searchType:SearchTypeAddress key:zipcode block:^(NSString *result) {
        if (block) {
            block(result);
        }
    }];
}

- (void)searchZipCodeByAddress:(NSString *)address block:(void(^)(NSString *zipcode))block {
    [self.addressPicker searchType:SearchTypeZipcode key:address block:^(NSString *result) {
        if (block) {
            block(result);
        }
    }];
}

- (void)searchIndexByAddress:(NSString *)address block:(void(^)(NSString *address))block {
    [self.addressPicker searchType:SearchTypeAddressIndex key:address block:^(NSString *result) {
        if (block) {
            block(result);
        }
    }];
}

- (void)searchIndexByZipCode:(NSString *)zipcode block:(void (^)(NSString *))block {
    [self.addressPicker searchType:SearchTypeZipcodeIndex key:zipcode block:^(NSString *result) {
        if (block) {
            block(result);
        }
    }];
}
@end
