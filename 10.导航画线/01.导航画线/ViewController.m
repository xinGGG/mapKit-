//
//  ViewController.m
//  01.导航画线
//
//  Created by Vincent_Guo on 15-1-27.
//  Copyright (c) 2015年 Fung. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import "CZAnnotation.h"

@interface ViewController ()<MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property(nonatomic,strong)CLGeocoder *geocoder;
@end

@implementation ViewController


-(CLGeocoder *)geocoder{
    if (!_geocoder) {
        _geocoder = [[CLGeocoder alloc] init];
    }
    
    return _geocoder;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mapView.delegate = self;
    
//    ①通过地理编码，获取两个地点的经纬度
//    ②通过两个经纬度计算两个地点的路线
//    ③通过计算出的路线往地图上添加画线【遮盖】
    
    //①通过地理编码，获取两个地点的经纬度
    NSString *gz = @"广州";
    NSString *bj = @"北京";
    
    //获取广州的位置
    [self.geocoder geocodeAddressString:gz completionHandler:^(NSArray *placemarks, NSError *error) {
        
        if (error) {
            NSLog(@"%@",error);
            return;
        }
        
        CLPlacemark *gzPlacemark = placemarks[0];
        
        //获取广州的位置后，再获取北京的位置
        [self.geocoder geocodeAddressString:bj completionHandler:^(NSArray *placemarks, NSError *error) {
            if (error) {
                NSLog(@"%@",error);
                return;
            }
            
            CLPlacemark *bjPlacemark = placemarks[0];
            
            [self calculateRouteFrom:gzPlacemark to:bjPlacemark];
        }];
    }];
}

#pragma mark 计算路线
-(void)calculateRouteFrom:(CLPlacemark *)from to:(CLPlacemark *)to{

    //添加 标记模型
    CZAnnotation *fromAnno = [[CZAnnotation alloc] init];
    fromAnno.coordinate = from.location.coordinate;
    fromAnno.title = from.name;
    [self.mapView addAnnotation:fromAnno];
    
    CZAnnotation *toAnno = [[CZAnnotation alloc] init];
    toAnno.coordinate = to.location.coordinate;
    toAnno.title = to.name;
    [self.mapView addAnnotation:toAnno];
    
    // 1.1创建 导航请求
    MKDirectionsRequest *request = [[MKDirectionsRequest alloc] init];
    // 1.2设置方向的起始位置
    MKPlacemark *fromPlace = [[MKPlacemark alloc] initWithPlacemark:from];
    request.source = [[MKMapItem alloc] initWithPlacemark:fromPlace];
    
    // 1.3设置方向的目标位置
    MKPlacemark *toPlace = [[MKPlacemark alloc] initWithPlacemark:to];
    request.destination = [[MKMapItem alloc] initWithPlacemark:toPlace];
    
    
    // 2.1创建 导航对象
    MKDirections *directions = [[MKDirections alloc] initWithRequest:request];
    // 2.2计算线路
    [directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error) {
        
        if (error) {
            NSLog(@"%@",error);
            
            return;
        }
        
        //2.3获取线路
        NSArray *routes = response.routes;
        NSLog(@"计算出的路线 %@",routes);
        //在地图上绘制线路
        for (MKRoute *route in routes) {
            [self.mapView addOverlay:route.polyline];
        }
        
    }];
}

#pragma mark 设置遮盖的样式
-(MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay{
    // 线路渲染/也叫路径渲染
    MKPolylineRenderer *polyline = [[MKPolylineRenderer alloc] initWithOverlay:overlay];
    //线宽
    polyline.lineWidth = 5;
    
    //线的颜色
    polyline.strokeColor = [UIColor blueColor];
    
    return polyline;
}
@end
