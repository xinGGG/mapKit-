//
//  CZTaxiDetailView.h
//  09.滴滴打车
//
//  Created by Vincent_Guo on 15-1-26.
//  Copyright (c) 2015年 Fung. All rights reserved.
//

#import <MapKit/MapKit.h>

typedef void (^DetailViewClickBlock)(id<MKAnnotation> anno);

@interface CZTaxiDetailAnnotationView : MKAnnotationView
+(instancetype)annotationView;

#pragma 设置点击的回调block
-(void)setDetailViewClickBlock:(DetailViewClickBlock)block;

@end
