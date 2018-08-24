//
//  SDHomeViewController.m
//  SuperDriver
//
//  Created by shengangneng on 2017/11/13.
//  Copyright © 2017年 com.shen.superdriver. All rights reserved.
//

#import "SDHomeTabBarViewController.h"
// 四个主控制器
#import "SDGoodsSourceViewController.h"
#import "SDOrderViewController.h"
#import "SDUserInfoViewController.h"

#import "SDSearchingGoodsViewController.h"
#import "SDMapViewController.h"

#import "SDTabBar.h"

@interface SDHomeTabBarViewController ()

@end

@implementation SDHomeTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 初始化所有控制器
    [self setUpChildVC];
    
    SDTabBar *tabBar = [[SDTabBar alloc] init];
    [self setValue:tabBar forKey:@"tabBar"];
    
    [tabBar setDidClickPublishBtn:^{
//        SDSearchingGoodsViewController *hmpositionVC = [[SDSearchingGoodsViewController alloc] init];
//        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:hmpositionVC];
//        [self presentViewController:nav animated:YES completion:nil];
        NSLog(@"呵呵");
        
    }];
}

- (void)setUpChildVC {
    
    SDSearchingGoodsViewController *homeVC = [[SDSearchingGoodsViewController alloc] init];
    [self setChildVC:homeVC title:@"首页" image:@"tabbar_home_normal" selectedImage:@"tabbar_home_select" nav:NO];
    
    SDMapViewController *fishpidVC = [[SDMapViewController alloc] init];
    [self setChildVC:fishpidVC title:@"货源" image:@"tabbar_find_normal" selectedImage:@"tabbar_find_select" nav:YES];
    
    SDOrderViewController *messageVC = [[SDOrderViewController alloc] init];
    [self setChildVC:messageVC title:@"订单管理" image:@"tabbar_voucher_normal" selectedImage:@"tabbar_voucher_select" nav:YES];
    
    SDUserInfoViewController *myVC = [[SDUserInfoViewController alloc] init];
    [self setChildVC:myVC title:@"我的" image:@"tabbar_my_normal" selectedImage:@"tabbar_my_select" nav:YES];
    
}

- (void)setChildVC:(UIViewController *)childVC title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage nav:(BOOL)nav {
    
    childVC.tabBarItem.title = title;
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSForegroundColorAttributeName] = [UIColor blackColor];
    dict[NSFontAttributeName] = [UIFont systemFontOfSize:10];
    [childVC.tabBarItem setTitleTextAttributes:dict forState:UIControlStateNormal];
    childVC.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVC.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:childVC];
    if (nav) {
        [self addChildViewController:navVC];
    } else {
        [self addChildViewController:childVC];
    }
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    NSInteger index = [self.tabBar.items indexOfObject:item];
    [self animationWithIndex:index];
    
    if ([item.title isEqualToString:@"发现"]) {
        // 也可以判断标题,然后做自己想做的事
    }
}
- (void)animationWithIndex:(NSInteger) index {
    
    NSMutableArray * tabbarbuttonArray = [NSMutableArray array];
    
    for (UIView *tabBarButton in self.tabBar.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabbarbuttonArray addObject:tabBarButton];
        }
    }
    CABasicAnimation*pulse = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    pulse.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pulse.duration = 0.2;
    pulse.repeatCount = 1;
    pulse.autoreverses = YES;
    pulse.fromValue = [NSNumber numberWithFloat:0.8];
    pulse.toValue = [NSNumber numberWithFloat:1.2];
    [[tabbarbuttonArray[index] layer] addAnimation:pulse forKey:nil];
}



@end
