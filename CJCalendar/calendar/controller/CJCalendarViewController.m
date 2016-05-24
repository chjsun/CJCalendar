//
//  CJMainViewController.m
//  CJCalendar
//
//  Created by chjsun on 16/5/23.
//  Copyright © 2016年 chjsun. All rights reserved.
//

#import "CJCalendarViewController.h"

#import "CJShowTimeView.h"

#define CJEdgeWidth 40
#define CJEdgeHeight 50

/**
 概览：
 总共整个控件分为四个部分  1，头部，主要显示全部时间内容，通常显示阳历对应的中国农历时间
                       2，年月日板 主要显示年月日和控制选择年月日的视图
                       3，选择板，用来选择年或者月日
                       4，确定板，主要是将选择的数据返回给调用者，基本有三个按钮(今日), (取消), (确定)
 计算：
    注：h是需要显示的大小，一般是整个屏幕去掉自定义的edge，即h = width - 2 * CJEdgeHeight
        1: 22 p
        2: 3/8 * h - 33 + 22 p
        3: h/2
        4: h/8 - 11
    计算思路: 1, 头部固定大小22
            2, 选择板占整个可视界面的1/2
            3, 三个确定板＋一个头部＝年月日板
 
 */

@interface CJCalendarViewController ()<ShowTimeViewDelegate>

/** 记录高度 */
@property (nonatomic, assign) CGFloat viewHeight;

@end

@implementation CJCalendarViewController

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
    
    //设置选择板
    [self setSelectTime];

}

//set background alpha
-(void) setBackgroundView{
    UIView *bgView = [[UIView alloc] initWithFrame:self.view.frame];
    bgView.backgroundColor = [UIColor blackColor];
    bgView.alpha = 0.6;
    [self.view addSubview:bgView];
}

//ser showTimeView
-(void) setShowTimeView{

    CGFloat timeRectWidth = self.view.bounds.size.width - 2 * CJEdgeWidth;
    // 3/8 * h + 11
    
    CGFloat timeRectHeight = (self.view.bounds.size.height - 2 * CJEdgeHeight) * 3 / 8 + 11;
    self.viewHeight += timeRectHeight;
    
    CGRect rect = CGRectMake(CJEdgeWidth, CJEdgeHeight, timeRectWidth, timeRectHeight);
    CJShowTimeView *timeView = [[CJShowTimeView alloc] initWithFrame:rect];
    timeView.delegate = self;
    
    [timeView generateView];
    
    [self.view addSubview:timeView];
}

//set selectView
-(void) setSelectTime{
    CGFloat selectWidth = self.view.bounds.size.width - 2 * CJEdgeWidth;
    // (h - 2*edge)/2
    CGFloat selectHeight = (self.view.bounds.size.height - 2 * CJEdgeHeight)/2;
    CGRect selectRect = CGRectMake(CJEdgeWidth, CJEdgeHeight + self.viewHeight, selectWidth, selectHeight);
    self.viewHeight += selectHeight;
    
}




#pragma mark - showViewDelegate
// 代理月日板代理
-(void)ShowTimeView:(CJShowTimeView *)timeView didSelectMonth:(NSString *)month day:(NSString *)day{
    NSLog(@"%@, %@", month , day);
}
// 年代理
-(void)ShowTimeView:(CJShowTimeView *)timeView didSelectYear:(NSString *)year{
    NSLog(@"%@", year);
}



@end
