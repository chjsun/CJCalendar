//
//  CJMonthDayViewController.h
//  CJCalendar
//
//  Created by chjsun on 16/5/24.
//  Copyright © 2016年 chjsun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CJMonthDayViewController : UICollectionViewController

/** 选中状态的color */
@property (nonatomic, copy) UIColor *selectColor;

-(instancetype)initWithFrame:(CGRect)frame;

@end
