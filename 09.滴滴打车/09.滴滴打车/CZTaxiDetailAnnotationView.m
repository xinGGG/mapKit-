//
//  CZTaxiDetailView.m
//  09.滴滴打车
//
//  Created by Vincent_Guo on 15-1-26.
//  Copyright (c) 2015年 Fung. All rights reserved.
//

#import "CZTaxiDetailAnnotationView.h"
#import "CZTaxiDetailView.h"
#import "CZTaxi.h"
#import "CZTaxiDetailAnnotation.h"

@interface CZTaxiDetailAnnotationView(){
    
    DetailViewClickBlock _clickBlock;//点击回调的block
}

@property(nonatomic,weak)CZTaxiDetailView *detailView;
@end

@implementation CZTaxiDetailAnnotationView

-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
       
        // 往 "标记视图" 添加xib的View
        // 1 从xib中加载View
        CZTaxiDetailView *detailView = [CZTaxiDetailView taxiDetailView];
#pragma mark 默认自身没有尺寸，要设置
        //self.backgroundColor = [UIColor redColor];
        // 2 设置 "标记视图" 的尺寸为xib的尺寸 * 2 + 18
        CGRect bounds = detailView.bounds;
        bounds.size.height *= 2;
        bounds.size.height += 18;
        self.bounds = bounds;
        [detailView.detailBtn addTarget:self action:@selector(detailBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        // 3 往 "标记视图" 添加xib的View
        [self addSubview:detailView];
        self.detailView = detailView;
    }
    
    return self;
}

+(instancetype)annotationView{
    static NSString *ID = @"CZTaxiDetailAnnotationView";
    
    // 1.创建 出租车详情标记视图
    CZTaxiDetailAnnotationView *tlAnnoView = [[CZTaxiDetailAnnotationView alloc] initWithAnnotation:nil reuseIdentifier:ID];
    
    
    return tlAnnoView;
}

-(void)setAnnotation:(id<MKAnnotation>)annotation{
    [super setAnnotation:annotation];
    
    if (annotation) {
        //获取 “标记模型” 里的 “出租车信息模型”
        CZTaxiDetailAnnotation *tdAnnotation = annotation;
        CZTaxi *taxi = tdAnnotation.taxi;
        
        //设置驾驶员名字
        self.detailView.dirverNameLabel.text = taxi.driverName;
        
        //设置车牌号和出租车公司名
        self.detailView.subTitleLabel.text = [NSString stringWithFormat:@"%@ %@",taxi.carNum,taxi.taxiCompany];
        
        //设置定单数
        self.detailView.orderNumLabel.text = [NSString stringWithFormat:@"%ld单",taxi.orderNum];
        //driverpage_icon_litterstare
        
        //设置星级driverpage_icon_litterstare1
        UIImage *starImg = [UIImage imageNamed:@"img_star"];
        CGRect starsFrm = self.detailView.starsView.frame;
        starsFrm.size.width = starImg.size.width * taxi.commentStar;
        starsFrm.size.height = starImg.size.height;
        self.detailView.starsView.frame = starsFrm;
        self.detailView.starsView.backgroundColor = [UIColor colorWithPatternImage:starImg];

        
    }
    //NSLog(@"%@",annotation);
}

-(void)setDetailViewClickBlock:(DetailViewClickBlock)block{

    _clickBlock = block;
}

-(void)detailBtnClick{
    if (_clickBlock) {
        _clickBlock(self.annotation);
    }
}

@end
