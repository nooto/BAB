//
//  CDeviceInfoViewController.m
//  BAB
//
//  Created by GaoAng on 2020/2/2.
//  Copyright © 2020 selfcom. All rights reserved.
//

#import "CDeviceInfoViewController.h"
#import <CoreMotion/CMAltimeter.h>
#import <CoreMotion/CoreMotion.h>

#define kaltimeter @"气压计"
#define kpressure @"压强"
#define krelativeAltitude @"高度"
#define KAccelerometer @"加速度"
#define kGyro @"螺旋仪"
#define kMagnetometer @"磁场"
#define kX @"X"
#define kY @"Y"
#define kZ @"Z"


@implementation DeviceinfoItem
- (id) initWithLeftText:(NSString*)text value:(NSString*)value{
    if (self = [super init]) {
        self.leftText = text;
        self.valueText = value;
    }
    return self;
}
@end
@interface CDeviceInfoViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView*tableView;
@property (nonatomic, strong) NSMutableArray *arrDataSource;
@property(readonly, nonatomic, getter=isGyroAvailable) BOOL gyroAvailable;
@property(assign, nonatomic) NSTimeInterval gyroUpdateInterval;

@property (nonatomic, strong) CMAltimeter *altimeter;
@property(strong,nonatomic)CMMotionManager *Manager;
@property (nonatomic, strong)  NSOperationQueue *queque;
@property (nonatomic, assign) NSTimeInterval timevalue;
@end

@implementation CDeviceInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mNavBarView.backgroundColor = [UIColor systemBlueColor];
    [self.view addSubview:self.tableView];
    self.Manager = [[CMMotionManager alloc]init];
    self.queque = [[NSOperationQueue alloc]init];
    // Do any additional setup after loading the view.
    self.timevalue = 1.0f;
    
    [self startAltimeter];
    [self startGyro];
    [self startMagnetometer];
    [self startAccelerometer];
    
}

-(void)backBtnPressed:(UIButton *)sender{
    [super backBtnPressed:sender];
    [self stopAltimeter];
}
- (UITableView*)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVBAR_H, SCREEN_W, SCREEN_H - NAVBAR_H) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.estimatedRowHeight = _tableView.rowHeight = MarginH(55.0F);
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (NSMutableArray*)arrDataSource{
    if (!_arrDataSource) {
        _arrDataSource = [[NSMutableArray alloc] initWithCapacity:2];
//        [_arrDataSource addObject:@{kaltimeter:@{@"":@"高度", @"气压":@""}}];
//        [_arrDataSource addObject:@{@"":@""}];
//        [_arrDataSource addObject:@{@"":@""}];
//        [_arrDataSource addObject:@{@"":@""}];
//        [_arrDataSource addObject:@{@"":@""}];
    }
    return _arrDataSource;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return self.arrDataSource.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSDictionary *dict = self.arrDataSource[section];
    NSArray *itemDicts = dict[dict.allKeys.firstObject];
    return itemDicts.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 45.f;
}
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(tableView.frame), [self tableView:tableView heightForHeaderInSection:section])];
    view.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.2f];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 20, 200, 20)];
    NSDictionary *dict = self.arrDataSource[section];
    [label setText:dict.allKeys.firstObject];
    [label setTextColor:[UIColor grayColor]];
    label.font = [UIFont systemFontOfSize:14];
    [view addSubview:label];
    return view;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:NSStringFromClass([UITableViewCell class])];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSDictionary *dict = self.arrDataSource[indexPath.section];
    NSArray *itemDicts = dict[dict.allKeys.firstObject];
    if (indexPath.row < itemDicts.count ) {
        DeviceinfoItem *item = itemDicts[indexPath.row];
        cell.textLabel.text = item.leftText;
        cell.detailTextLabel.text = item.valueText;
    }
    return cell;
}


- (void )updateTableDatasection:(NSString*)section text:(NSString*)text value:(NSString*)value{
    [self updateDatasection:section text:text value:value];
//    if (index == -1) {
        [self.tableView reloadData];
//    }
//    else{
//        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:index] withRowAnimation:UITableViewRowAnimationNone];
//    }
}

- (NSInteger )updateDatasection:(NSString*)section text:(NSString*)text value:(NSString*)value{
    for (NSInteger i  = 0; i <= self.arrDataSource.count; i++) {
        if (i == self.arrDataSource.count) {
            [self.arrDataSource addObject:@{section: @[[[DeviceinfoItem alloc] initWithLeftText:text value:value]]}];
            return i;
        }
        else{
            
            NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary: self.arrDataSource[i]];
            NSString *sectionKey = dict.allKeys.firstObject;
            if ([sectionKey isEqualToString:section]) {
                NSMutableArray *tempArr = [NSMutableArray arrayWithArray:dict[sectionKey]];
                for (NSInteger m = 0; m <= tempArr.count; m++) {
                    if (m == tempArr.count) {
                        [tempArr addObject:[[DeviceinfoItem alloc] initWithLeftText:text value:value]];
                        dict[sectionKey] = tempArr;
                        self.arrDataSource[i] = dict;
                        return i;
                    }
                    else{
                        DeviceinfoItem *item = tempArr[m];
                        if ([item.leftText isEqualToString:text]) {
                            item.valueText = value;
                            dict[sectionKey] = tempArr;
                            self.arrDataSource[i] = dict;
                            return i;
                        }
                    }
                }
            }
        }
    }
    return 0;
}

#pragma mark --

- (CMAltimeter*)altimeter{
    if ([CMAltimeter isRelativeAltitudeAvailable]) {
        if (!_altimeter) {
            _altimeter = [[CMAltimeter alloc]init];
        }
    }
    return _altimeter;
}
- (void)startAltimeter{
    if (self.altimeter) {
        [self.altimeter startRelativeAltitudeUpdatesToQueue:NSOperationQueue.mainQueue withHandler:^(CMAltitudeData * _Nullable altitudeData, NSError * _Nullable error) {
            NSLog(@"%lf",[altitudeData.relativeAltitude floatValue]);
            NSLog(@"%lf",[altitudeData.pressure floatValue]);

                   NSLog(@"%@",error);
            if (error == NULL) {
                
//                [self updateDatasection:kaltimeter text:krelativeAltitude value:[NSString stringWithFormat:@"%f m",[altitudeData.relativeAltitude floatValue]]];
                [self updateDatasection:kaltimeter text:kpressure value:[NSString stringWithFormat:@"%f kPa",[altitudeData.pressure floatValue]]];
                [self.tableView reloadData];
            }
           }];
    }
}

- (void)stopAltimeter{
    if (self.altimeter) {
        [self.altimeter stopRelativeAltitudeUpdates];
        _altimeter = nil;
    }
    
    [self.Manager stopGyroUpdates];
    [self.Manager stopMagnetometerUpdates];
    [self.Manager stopAccelerometerUpdates];
}

- (void)startAccelerometer{
    if (self.Manager.isAccelerometerAvailable) {

           //设置CMMotionManager 的加速度更新频率为0.1s
        self.Manager.accelerometerUpdateInterval = self.timevalue;


           //使用代码块开始获取加速度数据

           [self.Manager startAccelerometerUpdatesToQueue:self.queque withHandler:^(CMAccelerometerData * _Nullable accelerometerData, NSError * _Nullable error) {

               if(error){

                   [self.Manager stopAccelerometerUpdates];

                   NSLog(@"获取加速度数据错误%@",error);

               }else{

                       //分别获取系统x y z 加速度数据

                   NSLog(@"x-----------%lf",accelerometerData.acceleration.x);

                   NSLog(@"y-----------%lf",accelerometerData.acceleration.y);

                   NSLog(@"x-----------%lf",accelerometerData.acceleration.z);
                   dispatch_async(dispatch_get_main_queue(), ^{
                   [self updateDatasection:KAccelerometer text:kX value:[NSString stringWithFormat:@"%f",accelerometerData.acceleration.x]];
                   [self updateDatasection:KAccelerometer text:kY value:[NSString stringWithFormat:@"%f",accelerometerData.acceleration.y]];
                   [self updateDatasection:KAccelerometer text:kZ value:[NSString stringWithFormat:@"%f",accelerometerData.acceleration.z]];
                       [self.tableView reloadData];
                   });

                   

               }

           }];

       }else{

           NSLog(@"你的设备不支持加速度数据");

       }
}

- (void)startGyro{
    if (self.Manager.isGyroAvailable) {

         //设置螺旋仪数据更新频率
        self.Manager.gyroUpdateInterval = self.timevalue;

         [self.Manager startGyroUpdatesToQueue:self.queque withHandler:^(CMGyroData * _Nullable gyroData, NSError * _Nullable error) {

             if (error) {

                 [self.Manager stopGyroUpdates];

             }else{

                 NSLog(@"x-----------%lf",gyroData.rotationRate.x);

                 NSLog(@"y-----------%lf",gyroData.rotationRate.y);

                 NSLog(@"z-----------%lf",gyroData.rotationRate.z);
                 dispatch_async(dispatch_get_main_queue(), ^{

                     [self updateDatasection:kGyro text:kX value:[NSString stringWithFormat:@"%f",gyroData.rotationRate.x]];
                     [self updateDatasection:kGyro text:kY value:[NSString stringWithFormat:@"%f",gyroData.rotationRate.y]];
                     [self updateDatasection:kGyro text:kZ value:[NSString stringWithFormat:@"%f",gyroData.rotationRate.z]];
                     [self.tableView reloadData];

                     });

             }

         }];

     }else{

         NSLog(@"你的设备不支持螺旋仪数据");

     }
    
}


- (void)startMagnetometer{
    if (self.Manager.isMagnetometerAvailable) {
          //设置磁场更新频率
        self.Manager.magnetometerUpdateInterval = self.timevalue;

\
          [self.Manager startMagnetometerUpdatesToQueue:self.queque withHandler:^(CMMagnetometerData * _Nullable magnetometerData, NSError * _Nullable error) {

              if (error) {

                  [self.Manager stopMagnetometerUpdates];

              }else{

                  NSLog(@"x-----------%lf",magnetometerData.magneticField.x);

                  NSLog(@"y-----------%lf",magnetometerData.magneticField.y);

                  NSLog(@"z-----------%lf",magnetometerData.magneticField.z);
                  dispatch_async(dispatch_get_main_queue(), ^{
                      [self updateDatasection:kMagnetometer text:kX value:[NSString stringWithFormat:@"%f",magnetometerData.magneticField.x]];
                      [self updateDatasection:kMagnetometer text:kY value:[NSString stringWithFormat:@"%f",magnetometerData.magneticField.y]];
                      [self updateDatasection:kMagnetometer text:kZ value:[NSString stringWithFormat:@"%f",magnetometerData.magneticField.z]];
                      [self.tableView reloadData];


                  });

                  

              }

          }];

      }else{

          NSLog(@"你的设备不支持磁场数据");

      }
}
@end



