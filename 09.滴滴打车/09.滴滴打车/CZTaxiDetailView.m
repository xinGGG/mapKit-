//
//  CZTaxiDetailView.m
//  09.滴滴打车
//
//  Created by Vincent_Guo on 15-1-26.
//  Copyright (c) 2015年 Fung. All rights reserved.
//

#import "CZTaxiDetailView.h"

@interface CZTaxiDetailView()

@end
@implementation CZTaxiDetailView

+(instancetype)taxiDetailView{

    return [[[NSBundle mainBundle] loadNibNamed:@"CZTaxiDetailView" owner:nil options:nil] lastObject];
    
}

-(void)awakeFromNib{
    //设置头像圆角
    self.driverHeadView.layer.cornerRadius = self.driverHeadView.bounds.size.width * 0.5;
    self.driverHeadView.layer.masksToBounds = YES;
    
    //设置按钮图片
    UIImage *bg = [UIImage imageNamed:@"bg_map_cell"];
    bg = [bg stretchableImageWithLeftCapWidth:bg.size.width * 0.5 topCapHeight:bg.size.height * 0.4];
    [self.detailBtn setBackgroundImage:bg forState:UIControlStateNormal];
    
    //设置星级背景
    self.bgStarView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"img_star_gray"]];
    
}

@end
