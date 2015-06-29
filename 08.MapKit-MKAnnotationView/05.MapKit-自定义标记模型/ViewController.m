//
//  ViewController.m
//  04.MapKit-显示当前位置
//
//  Created by Vincent_Guo on 15-1-25.
//  Copyright (c) 2015年 Fung. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import "CZAnnotation.h"

@interface ViewController ()<MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property(nonatomic,strong)CLLocationManager *manager;

/**
 * 是否正在显示标题
 */
@property(nonatomic,assign,getter=isShowTitle)BOOL showTitle;

@end

@implementation ViewController

-(CLLocationManager *)manager{
    if (!_manager) {
        _manager = [[CLLocationManager alloc] init];
    }
    
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //ios设置 定位授权
    if ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0) {
        [self.manager requestWhenInUseAuthorization];
    }

    
    self.mapView.userTrackingMode = MKUserTrackingModeFollow;
    self.mapView.delegate = self;
    
    
    // 添加自己的标记模型到地图上
    // 1.定义标记模型
    CZAnnotation *annotation = [[CZAnnotation alloc] init];
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(23.116440, 113.325380);
    // 2.设置标记模型的经纬度
    annotation.coordinate = coordinate;
    // 3.设置标题 子标题
    annotation.title = @"广州图书馆";
    annotation.subtitle = @"开馆时间:9:00-21:00";
    
    // 4.添加标记模型到地图上
    [self.mapView addAnnotation:annotation];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
   
   
}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    NSLog(@"经度%f 纬度%f",userLocation.coordinate.longitude,userLocation.coordinate.latitude);
    
    userLocation.title = @"广州";
    userLocation.subtitle = @"花城广场";
    
}


-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    // 判断是否为 "自定义的标记模型"
    if ([annotation isKindOfClass:[CZAnnotation class]]) {
        //自己返回一个MKPinAnnotationView
        static NSString *ID = @"MyAnnotationView";
        // 创建 "纯洁" 标记视图
        MKAnnotationView *annoView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:ID];
        
        //是否显示详情，默认不显示
        annoView.canShowCallout = YES;
        

        //设置图片 driver_head/common_icon_startpoint
        annoView.image = [UIImage imageNamed:@"pin_red"];
        
        //pinAnnoView.backgroundColor = [UIColor redColor];
        annoView.calloutOffset = CGPointMake(0, -2);
        
        //详情视图左边的View
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.bounds = CGRectMake(0, 0, 40, 40);
        imageView.image = [UIImage imageNamed:@"gzlib.jpg"];
        annoView.leftCalloutAccessoryView = imageView;
        
        //详情视图右边的View
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        annoView.rightCalloutAccessoryView = btn;
        return annoView;
    }
    //返回空，系统会自己根据情况添加 标记视图
    return nil;
}


-(void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views{
    
    NSLog(@"%s %@",__func__,views);
}


@end
