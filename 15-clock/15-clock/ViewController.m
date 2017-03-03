//
//  ViewController.m
//  15-clock
//
//  Created by XSUNT45 on 15/12/25.
//  Copyright (c) 2015年 XSUNT45. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

{
    //秒针
    CALayer *_secondHand;
    //分针
    CALayer *_minuteHand;
    //时针
    CALayer *_hourHand;
}

@property (weak, nonatomic) IBOutlet UIImageView *clockImage;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //时钟图片高度和宽度
    CGFloat clockImageW = _clockImage.bounds.size.width;
    CGFloat clockImageH = _clockImage.bounds.size.height;
    
    //添加秒针
    [self addSecondHandClockImageW:clockImageW andclockImageH:clockImageH];
    
    //添加分针
    [self addMinuteHandClockImageW:clockImageW andclockImageH:clockImageH];
    
    //添加时针
    [self addHourHandClockImageW:clockImageW andclockImageH:clockImageH];
    
    //第一次进来调用定时器方法
    [self updateTime];
    
    //创建定时器
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
    
    
}

#pragma mark - 创建秒针
-(void)addSecondHandClockImageW:(CGFloat)clockImageW andclockImageH:(CGFloat)clockImageH {
    //添加秒针
    _secondHand = [CALayer layer];
    
    //设置尺寸
    _secondHand.bounds = CGRectMake(0, 0, 1, clockImageH*0.5-20);
    
    //设置位置
    _secondHand.position = CGPointMake(clockImageW*0.5, clockImageH*0.5);
    
    //设置锚点
    _secondHand.anchorPoint = CGPointMake(0.5, 0.9);
    
    //设置颜色
    _secondHand.backgroundColor = [UIColor redColor].CGColor;
    
    [self.clockImage.layer addSublayer:_secondHand];
}

#pragma mark - 创建分针
-(void)addMinuteHandClockImageW:(CGFloat)clockImageW andclockImageH:(CGFloat)clockImageH {
    //添加秒针
    _minuteHand = [CALayer layer];
    
    //设置尺寸
    _minuteHand.bounds = CGRectMake(0, 0, 2, clockImageH*0.5-20);
    
    //设置位置
    _minuteHand.position = CGPointMake(clockImageW*0.5, clockImageH*0.5);
    
    //设置锚点
    _minuteHand.anchorPoint = CGPointMake(0.5, 0.95);
    
    //设置颜色
    _minuteHand.backgroundColor = [UIColor blueColor].CGColor;
    
    _minuteHand.cornerRadius = 2;
    
    [self.clockImage.layer addSublayer:_minuteHand];
}

#pragma mark - 创建时针
-(void)addHourHandClockImageW:(CGFloat)clockImageW andclockImageH:(CGFloat)clockImageH{
    //添加秒针
    _hourHand = [CALayer layer];
    
    //设置尺寸
    _hourHand.bounds = CGRectMake(0, 0, 4, clockImageH*0.5-50);
    
    //设置位置
    _hourHand.position = CGPointMake(clockImageW*0.5, clockImageH*0.5);
    
    //设置锚点
    _hourHand.anchorPoint = CGPointMake(0.1, 0.9);
    
    _hourHand.backgroundColor = [UIColor blackColor].CGColor;
    
    _hourHand.cornerRadius = 4;
    
    [self.clockImage.layer addSublayer:_hourHand];
    
}

#pragma mark - 定时器方法,每隔一秒执行一次
-(void)updateTime{
    
    //获取日历对象
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    //获取日期组件
    NSDateComponents *components = [calendar components:NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:[NSDate date]];
    
    //获取时分秒
    NSInteger hour = components.hour;
    CGFloat minute = components.minute;
    CGFloat second = components.second;
    
    //当前秒转过的角度
    CGFloat secondAngle = second/60 * M_PI * 2;
    _secondHand.transform = CATransform3DMakeRotation(secondAngle, 0, 0, 1);
    
    //当前分针转过的角度
    CGFloat minuteAngle = minute/60 * M_PI * 2;
    //每转一秒钟,分针转过多少度
    CGFloat secondMinuteAngle = (second/60 * M_PI * 2)/60;
    minuteAngle += secondMinuteAngle;
    _minuteHand.transform = CATransform3DMakeRotation(minuteAngle, 0, 0, 1);
    
    //当前时针转过的角度(hour是24进制的)
    CGFloat hourAngle = (hour%12)/12.0 * M_PI * 2;
    //分针每转过一分钟,时针转过多少度
    CGFloat minuteHourAngle = (minute/60 * M_PI * 2)/12;
    hourAngle += minuteHourAngle;
    
    _hourHand.transform = CATransform3DMakeRotation(hourAngle, 0, 0, 1);
    
}

@end
