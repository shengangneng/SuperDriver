//
//  SDMapViewController.m
//  SuperDriver
//
//  Created by shengangneng on 2017/11/22.
//  Copyright © 2017年 com.shen.superdriver. All rights reserved.
//

#import "SDMapViewController.h"

/**核心定位服务头文件*/
#import <CoreLocation/CoreLocation.h>
/**原生地图头文件*/

#import<MapKit/MapKit.h>

@interface SDMapViewController () <MKMapViewDelegate, CLLocationManagerDelegate>

@property (nonatomic, strong)MKMapView *mapView;
@property (nonatomic, strong)CLLocationManager *locationManager;
@property (nonatomic, strong)MKPointAnnotation *currentPointAnnotation;

@end

@implementation SDMapViewController

- (MKPointAnnotation *)currentPointAnnotation {
    if (!_currentPointAnnotation) {
        _currentPointAnnotation = [[MKPointAnnotation alloc] init];
    }
    return _currentPointAnnotation;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /** 创建地图 */
    [self creatMap];
    
    /** 定位当前 */
    [self selfLocation];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

#pragma mark创建地图

- (void)creatMap {
    // 地图视图
    _mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    _mapView.delegate = self;
    [self.view addSubview:_mapView];
    
    // 添加手势到地图上
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    [_mapView addGestureRecognizer:longPress];
    
    NSArray *mapTypeArray = @[@"标准",@"卫星",@"混合"];
    UISegmentedControl *segment = [[UISegmentedControl alloc] initWithItems:mapTypeArray];
    segment.frame = CGRectMake(50,50,ScreenWidth - 100,40);
    [_mapView addSubview:segment];
    segment.selectedSegmentIndex=0;
    [segment addTarget:self action:@selector(mapTypeChanged:) forControlEvents:UIControlEventValueChanged];
}

#pragma mark定位自己

- (void)selfLocation {
    
    // 创建定位对象
    _locationManager = [[CLLocationManager alloc] init];
    // 设置定位属性
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    // 设置定位更新距离militer
    _locationManager.distanceFilter = 10.0;
    
    // 绑定定位委托
    _locationManager.delegate = self;
    
    /**设置用户请求服务*/
    
    //1.去info.plist文件添加定位服务描述,设置的内容可以在显示在定位服务弹出的提示框
    
    //取出当前应用的定位服务状态(枚举值)
    
    CLAuthorizationStatus status =[CLLocationManager authorizationStatus];
    
    // 如果未授权则请求
    if (status == kCLAuthorizationStatusNotDetermined) {
        [_locationManager requestAlwaysAuthorization];
    }
    
    //开始定位
    [_locationManager startUpdatingLocation];
}

#pragma mark CLLocationManagerDelegate

// 定位后的返回结果
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    // locations数组中存储的是CLLocation
    
    //遍历数组取出坐标--》如果不需要也可以不遍历
    CLLocation *location = [locations firstObject];
    
    // 设置地图显示该经纬度的位置
    MKCoordinateRegion region = MKCoordinateRegionMake(location.coordinate, MKCoordinateSpanMake(0.01,0.01));
    [_mapView setRegion:region animated:YES];
    
    // 设置经纬度
    self.currentPointAnnotation.coordinate = location.coordinate;
    
    // 设置主标题
    self.currentPointAnnotation.title = @"我在这里";
    
    // 设置副标题
    self.currentPointAnnotation.subtitle = @"hello world";
    
    // 将大头针添加到地图上
    [_mapView addAnnotation:self.currentPointAnnotation];
}

// 长按手势添加大头针
- (void)longPress:(UILongPressGestureRecognizer *)sender {
    if (sender.state != UIGestureRecognizerStateBegan) {
        return;
    }
    
    // 获取手势在uiview上的位置
    CGPoint longPressPoint = [sender locationInView:_mapView];
    
    // 将手势在uiview上的位置转化为经纬度
    CLLocationCoordinate2D coordinate2d = [_mapView convertPoint:longPressPoint toCoordinateFromView:_mapView];
    NSLog(@"%f%f",coordinate2d.longitude,coordinate2d.latitude);
    
    // 添加大头针
    MKPointAnnotation *pointAnnotation =[[MKPointAnnotation alloc] init];
    
    //设置经纬度
    pointAnnotation.coordinate=coordinate2d;
    
    //设置主标题和副标题
    pointAnnotation.title=@"我在这里";
    pointAnnotation.subtitle=@"你好，世界！";
    
    //添加到地图上
    [_mapView addAnnotation:pointAnnotation];
    MKCircle *circle =[MKCircle circleWithCenterCoordinate:coordinate2d radius:50];
    // 先添加，在回调方法中创建覆盖物
    [_mapView addOverlay:circle];
}

// 大头针的回调方法（与cell的复用机制很相似）
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id)annotation {
    // 复用
    MKPinAnnotationView *annotationView =(MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"PIN"];
    // 判断复用池中是否有可用的
    if (annotationView == nil) {
        annotationView =(MKPinAnnotationView *)[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"PIN"];
    }
    //添加左边的视图
    UIImageView *imageView =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow"]];
    imageView.frame=CGRectMake(0,0,50,50);
    annotationView.leftCalloutAccessoryView=imageView;
    //显示
    annotationView.canShowCallout=YES;
    //设置是否显示动画
    annotationView.animatesDrop=YES;
    // 设置右边视图
    UILabel *label =[[UILabel alloc] initWithFrame:CGRectMake(0,0,30,30)];
    label.text=@">>";
    annotationView.rightCalloutAccessoryView = label;
    // 设置大头针的颜色
    annotationView.pinTintColor = [UIColor redColor];
    return annotationView;
    
}

// 覆盖物的回调方法
- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id)overlay {
    //创建圆形覆盖物
    MKCircleRenderer *circleRender =[[MKCircleRenderer alloc] initWithCircle:overlay];
    
    //设置填充色
    circleRender.fillColor=[UIColor purpleColor];
    
    //设置边缘颜色
    circleRender.strokeColor=[UIColor redColor];
    return circleRender;
}

// 解决手势冲突，可以同时使用多个手势
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

// segment响应回调
- (void)mapTypeChanged:(UISegmentedControl *)sender {
    // 获得当前segment索引
    NSInteger index = sender.selectedSegmentIndex;
    // 设置地图的显示方式
    _mapView.mapType = index;
}

@end
