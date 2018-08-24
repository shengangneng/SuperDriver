//
//  SDSearchingGoodsViewModel.h
//  SuperDriver
//
//  Created by shengangneng on 2017/11/23.
//  Copyright © 2017年 com.shen.superdriver. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SDSearchingGoodsViewModel : NSObject

@property (nonatomic, copy) NSArray *ordersDetail;

+ (void)queryOrdersDetail:(void(^)(NSString *))resultBlock;

@end
