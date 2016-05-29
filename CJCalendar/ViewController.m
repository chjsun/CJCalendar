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
}


- (IBAction)btnClick:(id)sender {
    CJCalendarViewController *calendarController = [[CJCalendarViewController alloc] init];
    calendarController.view.frame = self.view.frame;

    [self presentViewController:calendarController animated:YES completion:nil];
}


@end
