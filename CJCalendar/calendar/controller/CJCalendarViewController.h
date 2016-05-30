//
//  CJMainViewController.h
//  CJCalendar
//
//  Created by chjsun on 16/5/23.
//  Copyright © 2016年 chjsun. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CJCalendarViewController;

@protocol CalendarViewControllerDelegate <NSObject>

@optional
-(void) CalendarViewController:(CJCalendarViewController *)controller didSelectActionYear:(NSString *)year month:(NSString *)month day:(NSString *)day;

@end

@interface CJCalendarViewController : UIViewController

/** 直接指定时间 */
@property (nonatomic, strong) NSDate *Date;

-(void) setYear:(NSString *)year month:(NSString *)month day:(NSString *)day;

/** 代理 */
@property (nonatomic, assign) id<CalendarViewControllerDelegate> delegate;

@end
