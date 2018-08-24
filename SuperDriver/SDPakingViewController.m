//
//  SDPakingViewController.m
//  SuperDriver
//  配货
//  Created by shengangneng on 2017/11/14.
//  Copyright © 2017年 com.shen.superdriver. All rights reserved.
//

#import "SDPakingViewController.h"
#import "BRAddressPickerView.h"

@interface SDPakingViewController ()

@property (nonatomic, strong) UILabel *startLabel;
@property (nonatomic, strong) UILabel *endLabel;

@end

@implementation SDPakingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"配货";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.backgroundColor = [UIColor blueColor];
    [btn1 setTitle:@"出发地" forState:UIControlStateNormal];
    btn1.frame = CGRectMake(20, 100, 50, 30);
    [btn1 addTarget:self action:@selector(btn1:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    _startLabel = [[UILabel alloc] init];
    _startLabel.backgroundColor = [UIColor lightGrayColor];
    _startLabel.frame = CGRectMake(90, 100, 50, 30);
    [self.view addSubview:_startLabel];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.backgroundColor = [UIColor blueColor];
    [btn2 setTitle:@"目的地" forState:UIControlStateNormal];
    btn2.frame = CGRectMake(ScreenWidth - 140, 100, 50, 30);
    [btn2 addTarget:self action:@selector(btn2:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
    _endLabel = [[UILabel alloc] init];
    _endLabel.backgroundColor = [UIColor lightGrayColor];
    _endLabel.frame = CGRectMake(ScreenWidth - 70, 100, 50, 30);
    [self.view addSubview:_endLabel];
    
}

- (void)btn1:(UIButton *)sender {
    [BRAddressPickerView showAddressPickerWithDefaultSelected:@[@10,@0,@3] isAutoSelect:NO resultBlock:^(NSArray *selectAddressArr) {
        NSLog(@"%@",selectAddressArr);
        _startLabel.text = selectAddressArr.firstObject;
        
    }];
}

- (void)btn2:(UIButton *)sender {
    [BRAddressPickerView showAddressPickerWithDefaultSelected:@[@10,@0,@3] isAutoSelect:NO resultBlock:^(NSArray *selectAddressArr) {
        NSLog(@"%@",selectAddressArr);
        _endLabel.text = selectAddressArr.firstObject;
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
