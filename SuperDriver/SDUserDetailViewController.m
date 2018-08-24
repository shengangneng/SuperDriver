//
//  SDUserDetailViewController.m
//  SuperDriver
//
//  Created by shengangneng on 2017/11/24.
//  Copyright © 2017年 com.shen.superdriver. All rights reserved.
//

#import "SDUserDetailViewController.h"
#import "SDUserInfoViewController.h"
#import "SDPopTransationAnimate.h"

@interface SDUserDetailViewController () <UINavigationControllerDelegate>

@property (nonatomic, strong) UIButton *detailButton;

@end

@implementation SDUserDetailViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 74, 150, 150)];
        self.detailButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.detailButton.frame = CGRectMake(170, 84, 50, 30);
        [self.detailButton setTitle:@"hello" forState:UIControlStateNormal];
        
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (self.navigationController.delegate == self) {
        self.navigationController.delegate = nil;
    }
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC {
    if (fromVC == self && [toVC isKindOfClass:[SDUserInfoViewController class]]) {
        return [[SDPopTransationAnimate alloc] init];
    } else {
        return nil;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.imageView];
    [self.view addSubview:self.detailButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
