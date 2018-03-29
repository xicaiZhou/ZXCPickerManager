//
//  ZXCPickerManager.h
//  ZXCPickerManagerDemo
//
//  Created by 周希财 on 2018/3/23.
//  Copyright © 2018年 VIC. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *声明返回的block
 */
typedef  void(^DatePickerCommitBlock)(NSDate * _Nonnull date);
typedef void (^DataPickerCancelBlock)(void);

typedef void (^PickerViewCommitBlock)(NSString * _Nonnull str);
typedef void (^PickerViewCancelBlock)(void);


@interface ZXCPickerManager : NSObject

+(ZXCPickerManager *_Nullable)sharePickerManager;

/**
 时间选择器

 @param minimumDate 起始
 @param maximumDate 截至
 @param commitBlock 确定
 @param cancelBlock 取消
 */
- (void)showDatePickerWithminimumDate:(NSDate *_Nullable)minimumDate maximumDate:(NSDate *_Nullable)maximumDate commitBlock:(DatePickerCommitBlock _Nonnull)commitBlock Cancel:(DataPickerCancelBlock _Nonnull)cancelBlock;


/**
 pickerView

 @param array 数据
 @param commitBlock 确定
 @param cancelBlock 取消
 */
- (void)showZXCPickerViewWithDataArray:(NSArray *_Nonnull)array title:(NSString * _Nonnull)title commitBlock:(void(^_Nonnull)(NSString * _Nonnull string, NSInteger index))commitBlock cancelBlock:(void(^_Nonnull)(void))cancelBlock;
/**
 *  show addressPicker with your custom title, cancelTitle, commitTitle
 *
 *  @param title       your custom title
 *  @param cancelTitle your custom cancelTitle
 *  @param commitTitle your custom commitTitle
 *  @param commitBlock commitBlock
 *  @param cancelBlock cancelBlock
 */
- (void)showZXCAddressPickerWithTitle:(NSString *_Nullable)title cancelTitle:(NSString *_Nullable)cancelTitle commitTitle:(NSString *_Nullable)commitTitle commitBlock:(void(^_Nullable)(NSString * _Nullable address, NSString * _Nullable zipcode))commitBlock cancelBlock:(void(^_Nullable)(void))cancelBlock;

/**
 *  show addressPicker with your custom title, cancelTitle, commitTitle
 *
 *  @param title       your custom title
 *  @param address     default address
 *  @param cancelTitle your custom cancelTitle
 *  @param commitTitle your custom commitTitle
 *  @param commitBlock commitBlock
 *  @param cancelBlock cancelBlock
 */
- (void)showZXCAddressPickerWithDefaultAddress:(NSString *_Nullable)address title:(NSString *_Nullable)title cancelTitle:(NSString *_Nullable)cancelTitle commitTitle:(NSString *_Nullable)commitTitle commitBlock:(void(^_Nullable)(NSString * _Nullable address, NSString * _Nullable zipcode))commitBlock cancelBlock:(void(^_Nullable)(void))cancelBlock;

/**
 *  show addressPicker with your custom title, cancelTitle, commitTitle
 *
 *  @param zipcode     default zipcode
 *  @param title       your custom title
 *  @param cancelTitle your custom cancelTitle
 *  @param commitTitle your custom commitTitle
 *  @param commitBlock commitBlock
 *  @param cancelBlock cancelBlock
 */
- (void)showZXCAddressPickerWithDefaultZipcode:(NSString *_Nullable)zipcode title:(NSString *_Nullable)title cancelTitle:(NSString *_Nullable)cancelTitle commitTitle:(NSString *_Nullable)commitTitle commitBlock:(void(^_Nullable)(NSString * _Nullable address, NSString * _Nullable zipcode))commitBlock cancelBlock:(void(^_Nullable)(void))cancelBlock;

/**
 *  searchAddressByZipcode
 *
 *  @param zipcode zipcode
 *  @param block block
 */
- (void)searchAddressByZipcode:(NSString *_Nullable)zipcode block:(void(^_Nullable)(NSString * _Nullable address))block;

/**
 *  searchZipCodeByAddress
 *
 *  @param address address
 *  @param block block
 */
- (void)searchZipCodeByAddress:(NSString *_Nullable)address block:(void(^_Nullable)(NSString * _Nullable zipcode))block;


/**
 *  searchIndexByAddress
 *
 *  @param address address
 *  @param block block
 */
- (void)searchIndexByAddress:(NSString *_Nullable)address block:(void(^_Nullable)(NSString * _Nullable address))block;


/**
 *  searchIndexByZipCode
 *
 *  @param zipcode address
 *  @param block block
 */
- (void)searchIndexByZipCode:(NSString *_Nullable)zipcode block:(void(^_Nullable)(NSString * _Nullable address))block;
@end
