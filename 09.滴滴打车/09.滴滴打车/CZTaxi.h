//
//  CZTaxi.h
//  09.滴滴打车
//
//  Created by Vincent_Guo on 15-1-26.
//  Copyright (c) 2015年 Fung. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CZTaxi : NSObject

//当前位置
@property(nonatomic,copy)NSString *longitude;
@property(nonatomic,copy)NSString *latitude;

@property(nonatomic,copy)NSString *carNum;//车牌号
@property(nonatomic,copy)NSString *taxiCompany;//出租出公司
@property(nonatomic,copy)NSString *driverName;//驾屎员
@property(nonatomic,assign)NSInteger orderNum;//定单数
@property(nonatomic,assign)float commentStar;//评论星级



@end
