//
//  CJShowTimeView.m
//  CJCalendar
//
//  Created by chjsun on 16/5/23.
//  Copyright © 2016年 chjsun. All rights reserved.
//

//练习英文注释   不到之处 敬请谅解
#import "CJShowTimeView.h"

#define CJColor(r, g, b) ([UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1])

#define CJBasicFontToHeight 0.83
#define CJSelectAlpha 0.6

@interface CJShowTimeView()

/** title */
@property (nonatomic, strong) UILabel *titleLabel;
/** month */
@property (nonatomic, strong) UILabel *animMonthLabel;
/** day */
@property (nonatomic, strong) UILabel *animDayLabel;
/** year */
@property (nonatomic, strong) UILabel *animYearLabel;

/** headerView */
@property (nonatomic, strong) UIView *headerView;
/** monthAndDayView */
@property (nonatomic, strong) UIView *monthAndDayView;
/** yearView */
@property (nonatomic, strong) UIView *yearView;

@end

@implementation CJShowTimeView

/**
 *  标题懒加载
 *
 *  @return label
 */
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = self.contentColor;
    }
    return _titleLabel;
}

/**
 *  月份懒加载
 *
 *  @return label
 */
-(UILabel *)animMonthLabel{
    if (!_animMonthLabel) {
        _animMonthLabel = [[UILabel alloc] init];
        _animMonthLabel.textColor = self.contentColor;
    }
    return _animMonthLabel;
}
/**
 *  日期懒加载
 *
 *  @return label
 */
-(UILabel *)animDayLabel{
    if (!_animDayLabel) {
        _animDayLabel = [[UILabel alloc] init];
        _animDayLabel.textColor = self.contentColor;
    }
    return _animDayLabel;
}
/**
 *  年份懒加载
 *
 *  @return label
 */
-(UILabel *)animYearLabel{
    if (!_animYearLabel) {
        _animYearLabel = [[UILabel alloc] init];
        _animYearLabel.textColor = self.contentColor;
    }
    return _animYearLabel;
}

/**
 *  视图窗口懒加载
 *
 *  @return 视图
 */
-(UIView *)headerView{
    if (!_headerView) {
        _headerView = [[UIView alloc] init];
    }
    return _headerView;

}
/**
 *  视图窗口懒加载
 *
 *  @return 视图
 */
-(UIView *)monthAndDayView{
    if (!_monthAndDayView) {
        _monthAndDayView = [[UIView alloc] init];
    }
    return _monthAndDayView;
    
}
/**
 *  视图窗口懒加载
 *
 *  @return 视图
 */
-(UIView *)yearView{
    if (!_yearView) {
        _yearView = [[UIView alloc] init];
    }
    return _yearView;
    
}


-(instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        //set default attr
        self.headerName = @"己酉鸡年 冬月廿四 星期一";
        self.headerBackgroundColor = CJColor(45, 59, 164);
        self.headerColor = [UIColor whiteColor];
        
        self.contentBackgroundColor = CJColor(34, 42, 139);
        self.contentColor = [UIColor whiteColor];
        self.dayText = @"19";
        self.monthText = @"1月";
        self.yearText = @"1970";
        
        self.basicColor = CJColor(220, 220, 220);

    }
    return self;
}

-(void) generateView{
    //set header
    CGRect headerRect = CGRectMake(0, 0, self.bounds.size.width, 44);
    [self generateHeaderView:headerRect];
    
    CGFloat contentHeight = self.bounds.size.height - 44;
    CGRect contentRect = CGRectMake(0, 44, self.bounds.size.width, contentHeight);
    [self generateContentView:contentRect];
}

/**
 *  set HeaderView
 *
 *  @param rect headerViewFrame
 */
-(void) generateHeaderView:(CGRect)rect{

    self.headerView.frame = rect;
    self.headerView.backgroundColor = self.headerBackgroundColor;
    
    [self.headerView addSubview:self.titleLabel];
    self.titleLabel.text = self.headerName;
    self.titleLabel.textColor = self.headerColor;

    [self.titleLabel sizeToFit];
    self.titleLabel.center = self.headerView.center;

    [self addSubview:self.headerView];
}


-(void) generateContentView:(CGRect)rect{
    
    //set month and day
    [self setMonthAndDay:rect];
    
   //    //set year
    [self setYear:rect];
}

/**
 *  set month and day
 *
 *  @param rect
 */
-(void)setMonthAndDay:(CGRect)rect{

    CGFloat smallestUnitHeight = rect.size.height/4;
    //set month and day
    CGRect monthAndDayRect = CGRectMake(rect.origin.x,
                                        rect.origin.y,
                                        rect.size.width,
                                        smallestUnitHeight * 3);
    
    self.monthAndDayView.frame = monthAndDayRect;

    self.monthAndDayView.backgroundColor = self.contentBackgroundColor;
    //set month
    [self.monthAndDayView addSubview:self.animMonthLabel];
    
    self.animMonthLabel.text = self.monthText;
    self.animMonthLabel.textColor = self.contentColor;

    self.animMonthLabel.font = [UIFont systemFontOfSize:smallestUnitHeight * CJBasicFontToHeight];
    
    [self.animMonthLabel sizeToFit];
    self.animMonthLabel.center = CGPointMake(rect.size.width/2, smallestUnitHeight / 2);
    
    //set day
    [self.monthAndDayView addSubview:self.animDayLabel];
    
    self.animDayLabel.text = self.dayText;
    self.animDayLabel.textColor = self.contentColor;
    self.animDayLabel.font = [UIFont systemFontOfSize:smallestUnitHeight * 2];
    [self.animDayLabel sizeToFit];
    self.animDayLabel.center = CGPointMake(rect.size.width/2, smallestUnitHeight * 2);
    [self.monthAndDayView addSubview:self.animDayLabel];
    
    [self addSubview:self.monthAndDayView];
    
    //set tap UITapGestureRecognizer
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(monthAndDayTap)];
    [self.monthAndDayView addGestureRecognizer:tap];
    
}

-(void)monthAndDayTap{
    [UIView animateWithDuration:0.25 animations:^{
        //动画变小
        _animMonthLabel.transform = CGAffineTransformMakeScale(0.8, 0.8);
        _animDayLabel.transform = CGAffineTransformMakeScale(0.8, 0.8);
        
        //set select color
        _animMonthLabel.alpha = 1;
        _animDayLabel.alpha = 1;
        _animYearLabel.alpha = CJSelectAlpha;
        
    }completion:^(BOOL finished) {
        // 变小之后弹性回归
        [UIView animateWithDuration:0.8 delay:0 usingSpringWithDamping:0.3 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            _animMonthLabel.transform = CGAffineTransformIdentity;
            _animDayLabel.transform = CGAffineTransformIdentity;
            
            //代理传值
            if ([_delegate respondsToSelector:@selector(ShowTimeView:didSelectMonth:day:)]) {
                [_delegate ShowTimeView:self didSelectMonth:_animMonthLabel.text day:_animDayLabel.text];
            }
        } completion:nil];
    }];
    
}

/**
 *  set year
 *
 *  @param rect
 */
-(void)setYear:(CGRect)rect{
    CGFloat smallestUnitHeight = rect.size.height/4;
    
    CGRect yearRect = CGRectMake(rect.origin.x,
                                 rect.origin.y + rect.size.height/4 * 3,
                                 rect.size.width,
                                 smallestUnitHeight);

    self.yearView.frame = yearRect;
    self.yearView.backgroundColor = self.contentBackgroundColor;
    
    [self.yearView addSubview:self.animYearLabel];
    //记录label 方便做动画
    self.animYearLabel = self.animYearLabel;
    //初始化透明度
    self.animYearLabel.alpha = CJSelectAlpha;
    
    self.animYearLabel.text = self.yearText;
    self.animYearLabel.textColor = self.contentColor;
    self.animYearLabel.font = [UIFont systemFontOfSize:smallestUnitHeight * CJBasicFontToHeight];
    
    [self.animYearLabel sizeToFit];
    self.animYearLabel.center = CGPointMake(rect.size.width/2, smallestUnitHeight / 2);
    
    [self addSubview:self.yearView];
    
    //set tap UITapGestureRecognizer
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(yearTap)];
    [self.yearView addGestureRecognizer:tap];

}

-(void)yearTap{
    [UIView animateWithDuration:0.25 animations:^{
        // 动画变小
        _animYearLabel.transform = CGAffineTransformMakeScale(0.8, 0.8);
        
        // set select color
        _animMonthLabel.alpha = CJSelectAlpha;
        _animDayLabel.alpha = CJSelectAlpha;
        _animYearLabel.alpha = 1;

        
    }completion:^(BOOL finished) {
        // 变小之后弹性回归
        [UIView animateWithDuration:0.8 delay:0 usingSpringWithDamping:0.3 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            _animYearLabel.transform = CGAffineTransformIdentity;

            //代理传值
            if ([_delegate respondsToSelector:@selector(ShowTimeView:didSelectYear:)]) {
                [_delegate ShowTimeView:self didSelectYear:_animYearLabel.text];
            }
        } completion:nil];
    }];
}


@end
