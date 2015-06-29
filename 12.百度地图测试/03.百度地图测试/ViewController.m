//
//  ViewController.m
//  03.百度地图测试
//
//  Created by Vincent_Guo on 15-1-29.
//  Copyright (c) 2015年 Fung. All rights reserved.
//

#import "ViewController.h"
#import "BMapKit.h"



@interface ViewController ()<BMKPoiSearchDelegate>

@property(nonatomic,weak)BMKMapView *mapView;
@property(nonatomic,strong)BMKPoiSearch *poiSearch;
@end

@implementation ViewController



-(void)viewDidLoad{
    [super viewDidLoad];
   
    BMKMapView *mapView = [[BMKMapView alloc] init];
    mapView.frame = self.view.bounds;
    [self.view addSubview:mapView];
    self.mapView = mapView;
    
    
    //创建搜索服务对象
    self.poiSearch = [[BMKPoiSearch alloc] init];
    //设置代理
    self.poiSearch.delegate = self;
    
    //添加个按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(20, 60, 80, 40);
    btn.backgroundColor = [UIColor grayColor];
    [btn setTitle:@"搜索周边酒店" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
}

-(void)btnClick{
    //搜索参数
    BMKCitySearchOption *option = [[BMKCitySearchOption alloc] init];
    option.city = @"北京";
    option.keyword = @"酒店";//搜索关键字
    option.pageCapacity = 50;//每次搜索数据的条数
    option.pageIndex = 0;//第一页
    
    //执行搜索
    [self.poiSearch poiSearchInCity:option];
}

/**
 *返回POI搜索结果
 *@param searcher 搜索对象
 *@param poiResult 搜索结果列表
 *@param errorCode 错误号，@see BMKSearchErrorCode
 */
- (void)onGetPoiResult:(BMKPoiSearch*)searcher result:(BMKPoiResult*)result errorCode:(BMKSearchErrorCode)error{
    
    // 清楚屏幕中所有的annotation
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
    [_mapView removeAnnotations:array];
    
    if (error == BMK_SEARCH_NO_ERROR) {
        for (int i = 0; i < result.poiInfoList.count; i++) {
            BMKPoiInfo* poi = [result.poiInfoList objectAtIndex:i];
            BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
            item.coordinate = poi.pt;
            item.title = poi.name;
            [_mapView addAnnotation:item];
            if(i == 0)
            {
                //将第一个点的坐标移到屏幕中央
                _mapView.centerCoordinate = poi.pt;
            }
        }
    } else if (error == BMK_SEARCH_AMBIGUOUS_ROURE_ADDR){
        NSLog(@"起始点有歧义");
    } else {
        // 各种情况的判断。。。
    }

}



@end
