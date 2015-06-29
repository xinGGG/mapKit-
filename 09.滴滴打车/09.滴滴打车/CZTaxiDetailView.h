//
//  CZTaxiDetailView.h
//  09.滴滴打车
//
//  Created by Vincent_Guo on 15-1-26.
//  Copyright (c) 2015年 Fung. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CZTaxiDetailView : UIView



@property (weak, nonatomic) IBOutlet UIImageView *driverHeadView;//头像
@property (weak, nonatomic) IBOutlet UILabel *dirverNameLabel;//驾驶员名字
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;//子标题
@property (weak, nonatomic) IBOutlet UILabel *orderNumLabel;//定单数量
@property (weak, nonatomic) IBOutlet UIButton *detailBtn;

@property (weak, nonatomic) IBOutlet UIImageView *starsView;
@property (weak, nonatomic) IBOutlet UIImageView *bgStarView;

+(instancetype)taxiDetailView;

@end
