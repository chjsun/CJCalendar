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

#import "CJDecisionView.h"

#define CJColor(r, g, b) ([UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1])

#define CJEdgeWidth 40
#define CJEdgeHeight 50

/**
 概览：
 总共整个控件分为四个部分  1，头部，主要显示全部时间内容，通常显示阳历对应的中国农历时间
                       2，年月日板 主要显示年月日和控制选择年月日的视图
                       3，选择板，用来选择年或者月日
                       4，控制板，主要是将选择的数据返回给调用者，基本有三个按钮(今日), (取消), (确定)
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

@interface CJCalendarViewController ()<ShowTimeViewDelegate, YearViewControllerDelegate, DecisionDelegate>

/** 记录高度 */
@property (nonatomic, assign) CGFloat viewHeight;

/** timeView */
@property (nonatomic, strong) CJShowTimeView *timeView;
/** selectController */
@property (nonatomic, strong) CJYearViewController *yearController;

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

-(CJYearViewController *)yearController{
    if (!_yearController) {
     _yearController = [[CJYearViewController alloc] init];
    _yearController.delegate = self;
    }
    return _yearController;
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
    
    
    [self.yearController refreshControlWithCellText:self.timeView.yearText];
}

// set background alpha
-(void) setBackgroundView{
    UIView *bgView = [[UIView alloc] initWithFrame:self.view.frame];
    bgView.backgroundColor = [UIColor blackColor];
//    bgView.alpha = 0.8;
    [self.view addSubview:bgView];
}

// ser showTimeView
-(void) setShowTimeView{
    [self.timeView generateView];
    
    [self.view addSubview:self.timeView];
}

// set selectView
-(void) setSelectTime{
    CGFloat selectWidth = self.view.bounds.size.width - 2 * CJEdgeWidth;
    // (h - 2*edge)/2
    CGFloat selectHeight = (self.view.bounds.size.height - 2 * CJEdgeHeight)/2;
    CGRect selectRect = CGRectMake(CJEdgeWidth, CJEdgeHeight + self.viewHeight, selectWidth, selectHeight);
    self.viewHeight += selectHeight;
    
    
    self.yearController.view.frame = selectRect;
    self.yearController.selectColor = CJColor(60, 45, 140);
    
    [self addChildViewController:self.yearController];
    [self.view addSubview:self.yearController.view];
}

// set decisionView
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


#pragma mark - showViewDelegate
// 代理月日板代理
-(void)ShowTimeView:(CJShowTimeView *)timeView didSelectMonth:(NSString *)month day:(NSString *)day{
    NSLog(@"%@, %@", month , day);
}
// 年代理
-(void)ShowTimeView:(CJShowTimeView *)timeView didSelectYear:(NSString *)year{
    
    [self.yearController refreshControlWithCellText:year];
}

#pragma mark - yearDelegate
-(void)yearTableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath cellText:(NSString *)cellText{
    
    self.timeView.yearText = cellText;
    [self.timeView generateView];
    
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
