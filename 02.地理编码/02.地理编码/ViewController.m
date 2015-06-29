//
//  ViewController.m
//  02.地理编码
//
//  Created by Vincent_Guo on 15-1-25.
//  Copyright (c) 2015年 Fung. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface ViewController ()
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
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"%s",__func__);
    //地方名 广州图书馆
    NSString *addName = @"花城广场";
    
    //地理编码 将地方名 转成 详细地理信息
    // 内部实现，向服务服务器发送网络请求

    [self.geocoder geocodeAddressString:addName completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error) {
            NSLog(@"%@",error);
            return;
        }
        
        
        NSLog(@"搜索到的信息个数%ld",placemarks.count);
        // 位置标记对象
        for (CLPlacemark *placemark in placemarks) {
            //经纬度 地名全称
            CLLocationCoordinate2D  coordinate = placemark.location.coordinate;
            NSLog(@"经度 %f 纬度 %f",coordinate.longitude,coordinate.latitude);
            NSLog(@"地址名称: %@",placemark.name);
            NSLog(@"街道地址: %@",placemark.thoroughfare);
            NSLog(@"国家: %@",placemark.country);
            NSLog(@"城市: %@",placemark.locality);
            
            NSLog(@"%@",placemark.addressDictionary);
            NSLog(@"＝＝＝＝＝＝＝＝＝＝＝\n\n");
            
            
        }
    }];
    
}


@end
