//
//  ViewController.m
//  CJCalendar
//
//  Created by chjsun on 16/5/23.
//  Copyright © 2016年 chjsun. All rights reserved.
//

#import "ViewController.h"

#import "CJCalendarViewController.h"
#import "CJUseTime.h"

@interface ViewController ()

/** controller */
//@property (nonatomic, strong) CJCalendarViewController *calendarController;

/** 高亮 */
@property (nonatomic, strong) UIImageView *himageView;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];

//    self.calendarController = [[CJCalendarViewController alloc] init];
//    self.calendarController.view.frame = self.view.frame;

//    CJUseTime *useTime = [[CJUseTime alloc] init];
//    [useTime test];
    [self strToDate];
    
    
}


// 日期和字符串之间的转换
- (NSDate *) strToDate
{
    NSString *dateStr = @"1986-5-4";
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [formatter setDateFormat:@"yyyy-MM-dd"]; // 年-月-日 时:分:秒
    // 这个格式可以随便定义,比如：@"yyyy,MM,dd,HH,mm,ss"
    NSDate *date = [formatter dateFromString:dateStr];
    return date;
}

- (IBAction)btnClick:(id)sender {
    CJCalendarViewController *calendarController = [[CJCalendarViewController alloc] init];
    calendarController.view.frame = self.view.frame;

    [self presentViewController:calendarController animated:YES completion:nil];
}


@end
