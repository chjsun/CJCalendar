//
//  ViewController.m
//  CJCalendar
//
//  Created by chjsun on 16/5/23.
//  Copyright © 2016年 chjsun. All rights reserved.
//

#import "ViewController.h"

#import "CJCalendarViewController.h"

@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self strToDate];
}

// 日期和字符串之间的转换
- (NSDate *) strToDate
{
    NSString *dateStr = @"2057-9-29";
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];

    [formatter setDateFormat:@"yyyy-MM-dd"]; // 年-月-日 时:分:秒
    // 这个格式可以随便定义,比如：@"yyyy,MM,dd,HH,mm,ss"
    NSDate *date = [formatter dateFromString:dateStr];
    NSCalendar *chineseCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    NSDateComponents *localeComp = [chineseCalendar components: NSCalendarUnitDay fromDate:date];
    NSLog(@"date = %@", date);
    
//    @property NSInteger era;
//    @property NSInteger year;
//    @property NSInteger month;
//    @property NSInteger day;
//    @property NSInteger hour;
//    @property NSInteger minute;
//    @property NSInteger second;

    NSLog(@"loczl day = %ld", localeComp.day);
    NSLog(@"loczl year = %ld", localeComp.year);
    NSLog(@"loczl month = %ld", localeComp.month);
    NSLog(@"loczl hour = %ld", localeComp.hour);
    NSLog(@"loczl minute = %ld", localeComp.minute);
    NSLog(@"loczl second = %ld", localeComp.second);

    
    return date;
}

- (IBAction)btnClick:(id)sender {
    CJCalendarViewController *calendarController = [[CJCalendarViewController alloc] init];
    calendarController.view.frame = self.view.frame;

    [self presentViewController:calendarController animated:YES completion:nil];
}


@end
