//
//  ViewController.m
//  ZXCPickerManagerDemo
//
//  Created by 周希财 on 2018/3/23.
//  Copyright © 2018年 VIC. All rights reserved.
//

#import "ViewController.h"
#import "ZXCPickerManager.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *time;
@property (weak, nonatomic) IBOutlet UIButton *item;
@property (weak, nonatomic) IBOutlet UIButton *address;

@end

@implementation ViewController


- (IBAction)selectTime:(id)sender {
    [[ZXCPickerManager sharePickerManager]showDatePickerWithminimumDate:nil maximumDate:nil commitBlock:^(NSDate * _Nonnull date) {
        [self.time setTitle:[NSString stringWithFormat:@"%@",date] forState:UIControlStateNormal];
    } Cancel:^{
        
    }];
}



- (IBAction)selectItem:(id)sender {
    [[ZXCPickerManager sharePickerManager] showZXCPickerViewWithDataArray:@[@"压缩", @"劫", @"德玛", @"比尔", @"恕瑞玛"] commitBlock:^(NSString * _Nonnull string, NSInteger index) {
         [self.item setTitle:string forState:UIControlStateNormal];
    } cancelBlock:^{
        
    }];
}



- (IBAction)selestAddress:(id)sender {
    [[ZXCPickerManager sharePickerManager] showZXCAddressPickerWithTitle:nil cancelTitle:@"取消" commitTitle:@"确定" commitBlock:^(NSString * _Nullable address, NSString * _Nullable zipcode) {
        [self.address setTitle:address forState:UIControlStateNormal];
    } cancelBlock:^{
        
    }];
}





- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
