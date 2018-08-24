//
//  SDOrdersView.m
//  SuperDriver
//
//  Created by shengangneng on 2017/11/23.
//  Copyright © 2017年 com.shen.superdriver. All rights reserved.
//

#import "SDOrdersView.h"

@interface SDOrdersView ()


@end

@implementation SDOrdersView

- (UIView *)orderHeaderView {
    if (!_orderHeaderView) {
        _orderHeaderView = [[UIView alloc] init];
    }
    return _orderHeaderView;
}

- (UITableView *)orderDetailTableView {
    if (!_orderDetailTableView) {
        _orderDetailTableView = [[UITableView alloc] initWithFrame:self.frame style:UITableViewStylePlain];
        _orderDetailTableView.backgroundColor = [UIColor whiteColor];
        _orderDetailTableView.tableFooterView = [[UIView alloc] init];
    }
    return _orderDetailTableView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.orderHeaderView];
        [self addSubview:self.orderDetailTableView];
    }
    return self;
}

@end
