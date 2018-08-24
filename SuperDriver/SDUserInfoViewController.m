//
//  SDUserInfoViewController.m
//  SuperDriver
//  我的
//  Created by shengangneng on 2017/11/14.
//  Copyright © 2017年 com.shen.superdriver. All rights reserved.
//

#import "SDUserInfoViewController.h"
#import "SDUserDetailViewController.h"
#import "SDPushTransationAnimate.h"

@interface SDUserInfoViewController () <UINavigationControllerDelegate>

@end

@implementation SDUserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的";
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake((ScreenWidth-310)/2, 64+50, 310, 310)];
    self.imageView.image = [UIImage imageNamed:@"thing01.jpg"];
    self.imageView.userInteractionEnabled = YES;
    [self.view addSubview:self.imageView];
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toNextViewController)]];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    // Stop being the navigation controller's delegate
    if (self.navigationController.delegate == self) {
        self.navigationController.delegate = nil;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    if (fromVC == self && [toVC isKindOfClass:[SDUserDetailViewController class]]) {
        return [[SDPushTransationAnimate alloc] init];
    } else {
        return nil;
    }
}

- (void)toNextViewController {
    SDUserDetailViewController *desVC = [[SDUserDetailViewController alloc] init];
    desVC.imageView.image = self.imageView.image;
    [self.navigationController pushViewController:desVC animated:YES];
}

@end
