//
//  CZTaxiLocationView.m
//  09.滴滴打车
//
//  Created by Vincent_Guo on 15-1-26.
//  Copyright (c) 2015年 Fung. All rights reserved.
//

#import "CZTaxiLocationAnnotationView.h"

@implementation CZTaxiLocationAnnotationView

+(instancetype)annotationView{

    static NSString *ID = @"CZTaxiLocationAnnotationView";
    
    //创建出租车位置标记视图
    //标记模型 可不用设置，系统会设置
    CZTaxiLocationAnnotationView *tlAnnoView = [[CZTaxiLocationAnnotationView alloc] initWithAnnotation:nil reuseIdentifier:ID];

    //设置图片
    tlAnnoView.image = [UIImage imageNamed:@"pin_taxi_icon"];
    
    return tlAnnoView;
}

@end
