//
//  SDSearchingGoodsViewController.m
//  SuperDriver
//  找货
//  Created by shengangneng on 2017/11/21.
//  Copyright © 2017年 com.shen.superdriver. All rights reserved.
//

#import "SDSearchingGoodsViewController.h"
#import "SDOrdersView.h"
#import "SDSearchingGoodsViewModel.h"

@interface SDSearchingGoodsViewController () <UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIView *headerView;               /**< 头部 */
@property (nonatomic, strong) UIScrollView *headerScrollView;   /**< 头部滚动视图 */
@property (nonatomic, strong) UIView *lineView;                 /**< 头部跟随的线条 */
@property (nonatomic, strong) UIButton *headerButton;           /**< 头部按钮 */

@property (nonatomic, strong) UIScrollView *topPopupView;       /**< 顶部弹出视图 */
@property (nonatomic, strong) UIView *bottomPopupView;          /**< 底部弹出视图 */

@property (nonatomic, strong) UIScrollView *mainView;           /**< 主要的活动视图 */
@property (nonatomic, strong) UIView *locateView;               /**< 定位 */
@property (nonatomic, strong) SDOrdersView *ordersView;         /**< 订单 */
@property (nonatomic, strong) UIView *pathesView;               /**< 路线 */
@property (nonatomic, strong) UIView *prePayView;               /**< 定金 */

@property (nonatomic, strong) SDSearchingGoodsViewModel *viewModel;

// data
@property (nonatomic, copy) NSArray *firstNavArray;
@property (nonatomic, copy) NSArray *seconNavArray;
@property (nonatomic, copy) NSArray *thirdNavArray;

// 当前选中的按钮
@property (nonatomic, strong) UIButton *curretnSelectedButton;
@end

@implementation SDSearchingGoodsViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self getLocalSourceOfTxt];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self p_setupHeaderView];
        });
    });
    
    self.title = @"首页";
    self.view.backgroundColor = [UIColor whiteColor];
    [self p_setupMainView];
}

- (void)getLocalSourceOfTxt {
    NSError *error;
    NSString *filePath=[[NSBundle mainBundle] pathForResource:@"source"ofType:@"txt"];
    NSString *str=[NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
    NSString * str2 = [str stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    str2 = [str2 stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    str2 = [str2 stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    if(str2 == nil || str2 == NULL || [str2 isKindOfClass:[NSNull class]]){
        [self getLocalSourceOfTxt];
    }
    NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:[str2 dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:&error];
    
    self.firstNavArray = responseDic[@"data"][@"firstNavigationList"];
    self.seconNavArray = responseDic[@"data"][@"secondNavigationList"];
    self.thirdNavArray = responseDic[@"data"][@"thirdNavigationList"];
    
    NSLog(@"hello");
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)p_setupHeaderView {
    
    self.headerScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth - 40, 42)];
    self.headerScrollView.showsHorizontalScrollIndicator = NO;
    self.headerScrollView.backgroundColor = [UIColor whiteColor];
    int padding = 15;
    int totalLength = 0;
    for (int i = 0; i < self.firstNavArray.count; i++) {
        NSString *title = self.firstNavArray[i][@"title"];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        CGFloat btnHeight = 42;
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitle:title forState:UIControlStateHighlighted];
        [btn sizeToFit];
        CGRect btnFrame = CGRectMake(padding*(i+1)+totalLength, (42 - btn.frame.size.height)/2, btn.frame.size.width, btnHeight);
        totalLength += btn.frame.size.width;
        [btn setFrame:btnFrame];
        [btn sizeToFit];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:RGBA(248, 217, 97, 1) forState:UIControlStateHighlighted];
        [btn setTitleColor:RGBA(248, 217, 97, 1) forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(p_btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.headerScrollView addSubview:btn];
    }
    self.headerScrollView.contentSize = CGSizeMake(padding * (self.firstNavArray.count + 1) + totalLength, 40);
    [self.headerScrollView addSubview:self.lineView];
    [self p_btnClicked:self.headerScrollView.subviews.firstObject];
    
    [self.headerView addSubview:self.headerScrollView];
    [self.headerView addSubview:self.headerButton];
}

- (void)p_setupMainView {
    [self p_setupLocateView];
    [self p_setupOrdersView];
    [self p_setupPathesView];
    [self p_setupPrePayView];
}

- (void)p_setupLocateView {
    self.locateView.backgroundColor = RGBA(251, 251, 251, 1);
}

- (void)p_setupOrdersView {
    self.ordersView.orderDetailTableView.delegate = self;
    self.ordersView.orderDetailTableView.dataSource = self;
}

- (void)p_setupPathesView {
    self.pathesView.backgroundColor = [UIColor yellowColor];
}

- (void)p_setupPrePayView {
    self.prePayView.backgroundColor = [UIColor blueColor];
}

#pragma mark - TargetAction

- (void)p_btnClicked:(UIButton *)sender {
    sender.selected = YES;
    if (self.curretnSelectedButton) {
        self.curretnSelectedButton.selected = NO;
        self.curretnSelectedButton = sender;
    } else {
        self.curretnSelectedButton = sender;
    }
    [self p_animateLineView:sender.frame];
}

- (void)headerbuttonClicked:(UIButton *)sender {
//    [UIView animateWithDuration:0.2 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//        CGRect frame1 = CGRectMake(0, 0, ScreenWidth, 500);
//        self.topPopupView.frame = frame1;
//    } completion:^(BOOL finished) {
//    }];
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame1 = CGRectMake(0, 0, ScreenWidth, 500);
        self.topPopupView.frame = frame1;
        CGRect frame2 = CGRectMake(0, 500, ScreenWidth, ScreenHeight - 500);
        self.bottomPopupView.frame = frame2;
    }];
}

- (void)dismissPopview {
//    [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//        CGRect frame1 = CGRectMake(0, -500, ScreenWidth, 500);
//        CGRect frame2 = CGRectMake(0, ScreenHeight*2 - 500 , ScreenWidth, ScreenHeight - 500);
//        self.topPopupView.frame = frame1;
//        self.bottomPopupView.frame = frame2;
//    } completion:nil];
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame1 = CGRectMake(0, -500, ScreenWidth, 500);
        CGRect frame2 = CGRectMake(0, ScreenHeight*2 - 500 , ScreenWidth, ScreenHeight - 500);
        self.topPopupView.frame = frame1;
        self.bottomPopupView.frame = frame2;
    }];
}

- (void)p_animateLineView:(CGRect)frame {
    frame.origin.y = 38;
    frame.size.height = 2;
    [UIView animateWithDuration:0.8 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.lineView.frame = frame;
    } completion:^(BOOL finished) {
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGPoint offset = scrollView.contentOffset;
    if (offset.x < ScreenWidth / 2) {
        [self p_animateLineView:self.headerView.subviews[0].frame];
    } else if (offset.x < ScreenWidth * 3 / 2) {
        [self p_animateLineView:self.headerView.subviews[1].frame];
    } else if (offset.x < ScreenWidth * 5 / 2) {
        [self p_animateLineView:self.headerView.subviews[2].frame];
    } else {
        [self p_animateLineView:self.headerView.subviews[3].frame];
    }
}

#pragma mark - UITableViewDataSource&&UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.ordersDetail.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"OrderCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Lazy Init

- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 42)];
        _headerView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_headerView];
    }
    return _headerView;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = RGBA(248, 217, 97, 1);
    }
    return _lineView;
}

- (UIScrollView *)mainView {
    if (!_mainView) {
        _mainView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 20+42, ScreenWidth, ScreenHeight)];
        _mainView.contentSize = CGSizeMake(ScreenWidth * 4, ScreenHeight);
        _mainView.delegate = self;
        _mainView.pagingEnabled = YES;
        _mainView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_mainView];
    }
    return _mainView;
}

- (UIView *)locateView {
    if (!_locateView) {
        _locateView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64 - 42)];
        [self.mainView addSubview:_locateView];
    }
    return _locateView;
}

- (UIView *)ordersView {
    if (!_ordersView) {
        _ordersView = [[SDOrdersView alloc] initWithFrame:CGRectMake(ScreenWidth, 0, ScreenWidth, ScreenHeight - 64 - 42)];
        [self.mainView addSubview:_ordersView];
    }
    return _ordersView;
}

- (UIView *)pathesView {
    if (!_pathesView) {
        _pathesView = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth * 2, 0, ScreenWidth, ScreenHeight - 64 - 42)];
        [self.mainView addSubview:_pathesView];
    }
    return _pathesView;
}

- (UIView *)prePayView {
    if (!_prePayView) {
        _prePayView = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth * 3, 0, ScreenWidth, ScreenHeight - 64 - 42)];
        [self.mainView addSubview:_prePayView];
    }
    return _prePayView;
}

- (SDSearchingGoodsViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[SDSearchingGoodsViewModel alloc] init];
    }
    return _viewModel;
}

- (UIButton *)headerButton {
    if (!_headerButton) {
        _headerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_headerButton setFrame:CGRectMake(ScreenWidth - 42, 0, 42, 42)];
        [_headerButton setImage:[UIImage imageNamed:@"header_button"] forState:UIControlStateNormal];
        [_headerButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_headerButton setTitleColor:RGBA(248, 217, 97, 1) forState:UIControlStateHighlighted];
        [_headerButton setTitleColor:RGBA(248, 217, 97, 1) forState:UIControlStateSelected];
        [_headerButton addTarget:self action:@selector(headerbuttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _headerButton;
}

- (UIScrollView *)topPopupView {
    if (!_topPopupView) {
        _topPopupView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, -500, ScreenWidth, 500)];
        _topPopupView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_topPopupView];
    }
    return _topPopupView;
}

- (UIView *)bottomPopupView {
    if (!_bottomPopupView) {
        _bottomPopupView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight*2 - 500 , ScreenWidth, ScreenHeight - 500)];
        _bottomPopupView.backgroundColor = [UIColor lightGrayColor];
        _bottomPopupView.alpha = 0.3;
        [_bottomPopupView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissPopview)]];
        [self.view addSubview:_bottomPopupView];
    }
    return _bottomPopupView;
}

@end
