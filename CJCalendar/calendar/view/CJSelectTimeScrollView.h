//
//  CJSelectTime.h
//  CJCalendar
//
//  Created by chjsun on 16/5/29.
//  Copyright © 2016年 chjsun. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CJSelectTimeScrollView;
@protocol SelectTimeScrollViewDelegate <NSObject>

@optional
-(void) selectTimeView:(CJSelectTimeScrollView *)timeScroll didSelectYearAtIndexPath:(NSIndexPath *)indexPath cellText:(NSString *)cellText;

-(void) selectTimeView:(CJSelectTimeScrollView *)timeScroll didSelectMonthAndDayAtIndexPath:(NSIndexPath *)indexPath cellText:(NSString *)cellText;

@end

@interface CJSelectTimeScrollView : UIScrollView

// attr
/** 需要设置的年 */
@property (nonatomic, copy) NSString *year;
/** 需要设置的月 */
@property (nonatomic, copy) NSString *month;
/** 需要设置的日 */
@property (nonatomic, copy) NSString *day;

// methed
-(void) setUpAllControllerWithSuperControll:(UIViewController *)controller;

/** 代理 */
@property (nonatomic, assign) id<SelectTimeScrollViewDelegate> delegates;

@end
