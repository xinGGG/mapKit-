//
//  ViewController.m
//  09.滴滴打车
//
//  Created by Vincent_Guo on 15-1-26.
//  Copyright (c) 2015年 Fung. All rights reserved.
//

#import "ViewController.h"
#import "CZTaxi.h"
#import <MapKit/MapKit.h>

#import "CZTaxiLocationAnnotation.h"
#import "CZTaxiLocationAnnotationView.h"
#import "CZTaxiDetailAnnotation.h"
#import "CZTaxiDetailAnnotationView.h"

@interface ViewController ()<MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property(nonatomic,strong)CLLocationManager *manager;
/**
 * 出租车数据
 */
@property(nonatomic,strong)NSArray *taxis;


/**
 * 正在选中的 "出租车位置标记模型"
 */
@property(nonatomic,strong)CZTaxiLocationAnnotation *tlAnno;


/**
 * 正在显示的 "出租车详情标记模型"
 */
@property(nonatomic,strong)CZTaxiDetailAnnotation *tdAnno;



@end

@implementation ViewController



-(NSArray *)taxis{
    if (!_taxis) {
        // 1.获取文件路径
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"data.json" ofType:nil];
        // 2.将文件数据转成NSData类型
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        
        // 3.系统化Json数据，把文件里的数据读取成一个数组
        NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        
        NSMutableArray *taxisM = [NSMutableArray array];
        for (NSDictionary *dic in jsonArray) {
            CZTaxi *taxi = [[CZTaxi alloc] init];
            [taxi setValuesForKeysWithDictionary:dic];
            [taxisM addObject:taxi];
        }
        
        _taxis = taxisM;
    }
    
    return _taxis;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //经度 113.325380 纬度 23.116440
    
    //1.请求定位授权
    if([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0){
        self.manager = [[CLLocationManager alloc] init];
        [self.manager requestWhenInUseAuthorization];
    }
    
    //2.开始定位
    self.mapView.delegate = self;
    self.mapView.userTrackingMode = MKUserTrackingModeFollow;
    
}



#pragma mark 刷新数据
- (IBAction)reloadData:(id)sender {
    // 添加 "出租车位置标记模型" 到 地图上
    for (CZTaxi *taxi in self.taxis) {
        CZTaxiLocationAnnotation *tlAnno = [[CZTaxiLocationAnnotation alloc] init];
        tlAnno.taxi = taxi;

        [self.mapView addAnnotation:tlAnno];
    }
}

#pragma mark -MapView代理

#pragma mark 获取当前位置
-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    //设置当前位置标记的标题
    userLocation.title = @"当前位置";
}


#pragma mark 添加地图标记视图
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{

    // 1.判断是否为 "出租出位置" 标记模型
    if([annotation isKindOfClass:[CZTaxiLocationAnnotation class]]){
        //返回 自定义的 出租出位置标记视图
        /*
         * 标记视图 是根据 标记模型里的经纬度来显示位置了
         * 但这里并没有往 "标记视图" 里传入 "标记模型" 数据，显示的时候，系统会设置"标记视图"的annotation属性
         */
        CZTaxiLocationAnnotationView *tlAnnoView = [CZTaxiLocationAnnotationView annotationView];

        
        return tlAnnoView;
        
    // 2.判断是否为 "出租车详情标记模型"
    }else if([annotation isKindOfClass:[CZTaxiDetailAnnotation class]]){
        CZTaxiDetailAnnotationView *tdAnnoView = [CZTaxiDetailAnnotationView annotationView];
        //设置点击回调的block
        [tdAnnoView setDetailViewClickBlock:^(id<MKAnnotation> anno) {
            NSLog(@"%s 进入下一个控制器",__func__);
        }];
        return tdAnnoView;
    }
    
    return nil;
}

#pragma mark 地图标记视图取消选中
-(void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view{
    NSLog(@"%s %@",__func__,view);
}

#pragma mark 地图标记视图被选中
-(void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view{
    NSLog(@"%s",__func__);
    // 判断是否为 “出租车标记视图”
    if([view isKindOfClass:[CZTaxiLocationAnnotationView class]]){
        
        if (self.tdAnno) {
            return;
        }
        //NSLog(@"%@",view);
        // 1.出租车标记模型
        CZTaxiLocationAnnotation *tlAnno = view.annotation;
        self.tlAnno =tlAnno;
        
        // 2.添加 “出租车详细标记模型” 用于显示 “出租车详细标记视图”
        CZTaxiDetailAnnotation *tdAnno = [[CZTaxiDetailAnnotation alloc] init];
        tdAnno.taxi = tlAnno.taxi;
        [self.mapView addAnnotation:tdAnno];
        self.tdAnno = tdAnno;
    }

}

#pragma mark 地图标记视图添加完成
-(void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views{
    
    if ([views[0] isKindOfClass:[CZTaxiDetailAnnotationView class]]) {
        // 添加动画效果
        CAKeyframeAnimation *keyAnni = [CAKeyframeAnimation animation];
        keyAnni.keyPath = @"transform.scale";
        keyAnni.values = @[@0,@1.1,@1.0];
        keyAnni.duration = 0.3;
        [[views[0] layer] addAnimation:keyAnni forKey:nil];
    }
    }

#pragma mark 触摸事件
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"%s",__func__);
    
    // 判断是否有正在显示的 “出租车详细标记视图”
    if (self.tdAnno) {
        [self.mapView removeAnnotation:self.tdAnno];
        self.tdAnno = nil;
        
        // 去除 "出租车位置标记视图的" 选中
        [self.mapView deselectAnnotation:self.tlAnno animated:NO];
        self.tlAnno = nil;
    }
}
@end
