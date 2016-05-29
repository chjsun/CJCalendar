//
//  CJMainViewController.m
//  CJCalendar
//
//  Created by chjsun on 16/5/23.
//  Copyright © 2016年 chjsun. All rights reserved.
//

#import "CJCalendarViewController.h"

#import "CJShowTimeView.h"

#import "CJYearViewController.h"
#import "CJMonthDayViewController.h"
#import "CJSelectTimeScrollView.h"

#import "CJDecisionView.h"

#define CJColor(r, g, b) ([UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1])

#define CJEdgeWidth 40
#define CJEdgeHeight 50

/**
 概览：
 总共整个控件分为四个部分  1，a:头部，主要显示全部时间内容，通常显示阳历对应的中国农历时间
                       2，b:年月日板 主要显示年月日和控制选择年月日的视图
                       3，c:选择板，用来选择年或者月日
                       4，d:控制板，主要是将选择的数据返回给调用者，基本有三个按钮(今日), (取消), (确定)
 计算：
    注：h是需要显示的大小，一般是整个屏幕去掉自定义的edge，即h = width - 2 * CJEdgeHeight
        1: 22 p
        2: 3/8 * h - 33 + 22 p
        3: h/2
        4: h/8 - 11
    计算思路: 1, 头部固定大小22
            2, 选择板占整个可视界面的1/2
            3, 三个控制板＋一个头部＝年月日板
 
 */

@interface CJCalendarViewController ()<ShowTimeViewDelegate, YearViewControllerDelegate, DecisionDelegate, SelectTimeScrollViewDelegate>

/** 记录高度 */
@property (nonatomic, assign) CGFloat viewHeight;

/** timeView */
@property (nonatomic, strong) CJShowTimeView *timeView;
/** selectController */
@property (nonatomic, strong) CJSelectTimeScrollView *selectScrollView;


@end

@implementation CJCalendarViewController

-(instancetype)init{

    if (self = [super init]) {
        self.view.frame = [UIScreen mainScreen].bounds;
    }
    
    return self;
}

-(CJShowTimeView *)timeView{
    if (!_timeView) {
        CGFloat timeRectWidth = self.view.bounds.size.width - 2 * CJEdgeWidth;
        // (3/8 * h - 33 + 22) + (22) === (a+b)
        
        CGFloat timeRectHeight = (self.view.bounds.size.height - 2 * CJEdgeHeight) * 3 / 8 + 11;
        self.viewHeight += timeRectHeight;
        
        CGRect rect = CGRectMake(CJEdgeWidth, CJEdgeHeight, timeRectWidth, timeRectHeight);
        _timeView = [[CJShowTimeView alloc] initWithFrame:rect];
        _timeView.delegate = self;
    }
    return _timeView;
}

-(CJSelectTimeScrollView *)selectScrollView{
    if (!_selectScrollView) {
        _selectScrollView = [[CJSelectTimeScrollView alloc] init];
        _selectScrollView.delegates = self;
        _selectScrollView.scrollEnabled = NO;
    }
    return _selectScrollView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置半透明背景
    [self setBackgroundView];
    // 设置showTime
    [self setShowTimeView];
    // 设置选择板
    [self setSelectTime];

    // 设置控制板
    [self setDecision];
    
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    // 初始化时将控制器跳转到指定时间
    self.selectScrollView.year = self.timeView.yearText;

}

// set background alpha
// 设置背景
-(void) setBackgroundView{
    UIView *bgView = [[UIView alloc] initWithFrame:self.view.frame];
    bgView.backgroundColor = [UIColor blackColor];
//    bgView.alpha = 0.8;
    [self.view addSubview:bgView];
}

// ser showTimeView
// 设置在日历上方的头部显示面板
-(void) setShowTimeView{
    [self.timeView generateView];
    
    [self.view addSubview:self.timeView];
}

// set selectView
// 设置日历选择面板
-(void) setSelectTime{
    
    CGFloat selectWidth = self.view.bounds.size.width - 2 * CJEdgeWidth;
    // (h - 2*edge)/2
    CGFloat selectHeight = (self.view.bounds.size.height - 2 * CJEdgeHeight)/2;
    CGRect selectRect = CGRectMake(CJEdgeWidth, CJEdgeHeight + self.viewHeight, selectWidth, selectHeight);
    self.viewHeight += selectHeight;
    
    self.selectScrollView.frame = selectRect;
    //设置scrollview的属性
    self.selectScrollView.contentSize = CGSizeMake(selectWidth * 2, selectHeight);
    self.selectScrollView.pagingEnabled = YES;
    self.selectScrollView.showsHorizontalScrollIndicator = FALSE;
    //设置所有的子控制器
    [self.selectScrollView setUpAllControllerWithSuperControll:self];
    
    [self.view addSubview:self.selectScrollView];
    
}

// set decisionView
// 设置最后的按钮
-(void) setDecision{
    CGFloat selectWidth = self.view.bounds.size.width - 2 * CJEdgeWidth;
    // h/8 - 11
    CGFloat selectHeight = (self.view.bounds.size.height - 2 * CJEdgeHeight) / 8 - 11;
    CGRect rect = CGRectMake(CJEdgeWidth, CJEdgeHeight + self.viewHeight, selectWidth, selectHeight);
    
    CJDecisionView *decisionView = [[CJDecisionView alloc] initWithFrame:rect];
    decisionView.backgroundColor = [UIColor whiteColor];
    [decisionView generateDecision];
    decisionView.delegate = self;
    
    [self.view addSubview:decisionView];
}


#pragma mark - showViewDelegate 具体日历上方的时间显示区代理
// 头部 月 日 -- 代理
-(void)ShowTimeView:(CJShowTimeView *)timeView didSelectMonth:(NSString *)month day:(NSString *)day{
    NSLog(@"%@, %@", month , day);
    [self setBoundsToScrollView:0];
}
// 头部 年 -- 代理
-(void)ShowTimeView:(CJShowTimeView *)timeView didSelectYear:(NSString *)year{
    self.selectScrollView.year = year;
    [self setBoundsToScrollView:1];
}

-(void) setBoundsToScrollView:(CGFloat)tag{

    CGFloat selectWidth = self.view.bounds.size.width - 2 * CJEdgeWidth;
    // (h - 2*edge)/2
    CGFloat selectHeight = (self.view.bounds.size.height - 2 * CJEdgeHeight)/2;
    self.selectScrollView.bounds = CGRectMake(selectWidth * tag, 0, selectWidth, selectHeight);

}

#pragma mark - 控制板按钮
// 确定
-(void)DecisionDidSelectAction:(CJDecisionView *)decision{
    NSLog(@"%s", __func__);
}
// 取消
-(void)DecisionDidSelectCancel:(CJDecisionView *)decision{
    [self dismissViewControllerAnimated:YES completion:nil];
}
// 今日
-(void)DecisionDidSelectNow:(CJDecisionView *)decision{
    NSLog(@"%s", __func__);
}


@end
