//
//  CJMainViewController.m
//  CJCalendar
//
//  Created by chjsun on 16/5/23.
//  Copyright © 2016年 chjsun. All rights reserved.
//

#import "CJMainViewController.h"

#import "CJShowTimeView.h"

#define CJEdgeWidth 40
#define CJEdgeHeight 50

@interface CJMainViewController ()<ShowTimeViewDelegate>

@end

@implementation CJMainViewController

-(instancetype)init{

    if (self = [super init]) {
        self.view.frame = [UIScreen mainScreen].bounds;
    }
    
    return self;
}

-(void) btnClick{

    [self dismissViewControllerAnimated:YES completion:nil];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置半透明背景
    [self setBackgroundView];
    //设置showTime
    [self setShowTimeView];

}

-(void) setBackgroundView{
    UIView *bgView = [[UIView alloc] initWithFrame:self.view.frame];
    bgView.backgroundColor = [UIColor blackColor];
    bgView.alpha = 0.6;
    [self.view addSubview:bgView];
}

-(void) setShowTimeView{

    CGFloat timeRectWidth = self.view.bounds.size.width - 2 * CJEdgeWidth;
    // 3/8*h+22 - 2*edge + 44    //44是头部高度
    CGFloat timeRectHeight = (self.view.bounds.size.height * 3 / 8) + 22 + 44 - 2 * CJEdgeHeight;
    
    CGRect rect = CGRectMake(CJEdgeWidth, CJEdgeHeight, timeRectWidth, timeRectHeight);
    CJShowTimeView *timeView = [[CJShowTimeView alloc] initWithFrame:rect];
    timeView.delegate = self;
    
    [timeView generateView];
    
    [self.view addSubview:timeView];
}

-(void)ShowTimeView:(CJShowTimeView *)timeView didSelectMonth:(NSString *)month day:(NSString *)day{
    NSLog(@"%@, %@", month , day);
}

-(void)ShowTimeView:(CJShowTimeView *)timeView didSelectYear:(NSString *)year{
    NSLog(@"%@", year);
}



@end
