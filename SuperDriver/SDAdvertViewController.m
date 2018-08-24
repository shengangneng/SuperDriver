//
//  SDAdViewController.m
//  SuperDriver
//
//  Created by shengangneng on 2017/11/13.
//  Copyright © 2017年 com.shen.superdriver. All rights reserved.
//

#import "SDAdvertViewController.h"
#import "AppDelegate.h"
#import "SDLoginViewController.h"

@interface SDAdvertViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *advertiseScrollView;
@property (nonatomic, copy) NSArray *imagesArray;

@end

@implementation SDAdvertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_setupScrollView];
}

- (NSArray *)imagesArray {
    if (!_imagesArray) {
        _imagesArray = @[@"Welcom01.jpg",@"Welcom02.jpg",@"Welcom03.jpg"];
    }
    return _imagesArray;
}

- (void)p_setupScrollView {
    _advertiseScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    _advertiseScrollView.delegate = self;
    _advertiseScrollView.pagingEnabled = YES;
    _advertiseScrollView.contentSize = CGSizeMake(ScreenWidth * 3, ScreenHeight);
    [self.view addSubview:_advertiseScrollView];
    
    for (int i = 0; i < self.imagesArray.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:self.imagesArray[i]];
        imageView.userInteractionEnabled = YES;
        imageView.frame = CGRectMake(i * ScreenWidth, 0, ScreenWidth, ScreenHeight);
        [_advertiseScrollView addSubview:imageView];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat contentOffsetX = scrollView.contentOffset.x;
    if (contentOffsetX > (self.imagesArray.count - 1) * ScreenWidth) {
        ((AppDelegate *)[UIApplication sharedApplication].delegate).window.rootViewController = [[SDLoginViewController alloc] init];
    }
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
