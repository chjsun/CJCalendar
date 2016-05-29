//
//  CJMonthDayViewController.m
//  CJCalendar
//
//  Created by chjsun on 16/5/24.
//  Copyright © 2016年 chjsun. All rights reserved.
//

#import "CJMonthDayViewController.h"

#import "CJMonthDayCollectionCell.h"

#import "CJUseTime.h"

@interface CJMonthDayViewController ()

/** 公历某个月的天数 */
@property (nonatomic, assign) NSInteger monthNumber;
/** 某天是星期几 */
@property (nonatomic, assign) NSInteger dayOfWeek;

/** 月日，星期几 */
@property (nonatomic, strong) NSMutableArray *monthNumberAndWeek;

/** 处理时间的方法 */
@property (nonatomic, strong) CJUseTime *useTime;
/** 设置日期被选中的背景view */
@property (nonatomic, strong) UIView *selectView;

@end

@implementation CJMonthDayViewController

static NSString * const reuseIdentifier = @"monthDayViewCell";
static NSString * const reuseHeader = @"monthDayViewHeader";

// 懒加载
-(CJUseTime *)useTime{
    if (!_useTime) {
        _useTime = [[CJUseTime alloc] init];
    }
    return _useTime;
}


//懒加载
-(UIView *)selectView{
    if (_selectView) {
        CGRect rect = self.view.frame;
//        CGFloat wh = self.view.frame.size.width/7;
        CGFloat height = rect.size.height/4;
        CGFloat width = height;
        CGFloat x = (rect.size.width - height)/2;
        CGFloat y = 0;
        UIView *selectBgView = [[UIView alloc] initWithFrame:CGRectMake(x, y, width, height)];
        
        selectBgView.backgroundColor = self.selectColor;
        selectBgView.layer.cornerRadius = height/2;
        selectBgView.layer.masksToBounds = YES;

        [_selectView addSubview:selectBgView];
    }
    return _selectView;
}


-(instancetype)initWithFrame:(CGRect)frame{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    CGFloat wh = frame.size.width/7;
    layout.itemSize = CGSizeMake(wh, wh-5);
    layout.minimumLineSpacing = 5;
    layout.minimumInteritemSpacing = -2;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 10, 0);


    self = [super initWithCollectionViewLayout:layout];
    self.view.frame = frame;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    return self;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //注册
    [self.collectionView registerClass:[CJMonthDayCollectionCell class] forCellWithReuseIdentifier:reuseIdentifier];
    //注册头部
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reuseHeader];
}



#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return (2101-1970) * 12;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    //每个月的第一天
    NSString *strYear = [NSString stringWithFormat:@"%ld", section / 12 + 1970];
    NSString *strMonth = [NSString stringWithFormat:@"%ld", section % 12 + 1];
    NSString *dateStr = [NSString stringWithFormat:@"%@-%@-01", strYear, strMonth];
    
    return [self.useTime timeFewWeekInMonth:dateStr] * 7;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CJMonthDayCollectionCell *cell = (CJMonthDayCollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    
    //每个月的第一天
    NSString *dateStr = [self getDateStrForSection:indexPath.section day:1];
    // 获得这个月的天数
    self.monthNumber = [self.useTime timeNumberOfDaysInString:dateStr];
    
    // 获得这个月第一天是星期几
    self.dayOfWeek = [self.useTime timeMonthWeekDayOfFirstDay:dateStr];
    
    NSInteger firstCorner = self.dayOfWeek;
    NSInteger lastConter = self.dayOfWeek + self.monthNumber - 1;
    if (indexPath.item <firstCorner || indexPath.item>lastConter) {
        cell.hidden = YES;
    }else{
        cell.hidden = NO;
        NSInteger gregoiain = indexPath.item - firstCorner+1;
        //阳历
        cell.gregoiainDay = [NSString stringWithFormat:@"%ld", gregoiain];
        
        //农历
        NSString *dateStr = [self getDateStrForSection:indexPath.section day:gregoiain];
        cell.lunarDay = [self.useTime timeChineseDaysWithDate:dateStr];
        
        //日期属性
        cell.gregoiainCalendar = dateStr;
        cell.chineseCalendar = [self.useTime timeChineseCalendarWithDate:dateStr];

    }

    cell.backgroundView = self.selectView;
    
    return cell;
}


//header
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:reuseHeader forIndexPath:indexPath];
        
        for (UIView *subView in headerView.subviews) {
            if (subView.tag == 11) {
                [subView removeFromSuperview];
            }
        }
        
        UILabel *yearAndMonthLabel = [[UILabel alloc] init];
        yearAndMonthLabel.tag = 11;
        
        yearAndMonthLabel.text = [NSString stringWithFormat:@"%ld年 %ld月", indexPath.section/12 + 1970, indexPath.section%12 + 1];
        
        [yearAndMonthLabel sizeToFit];
        
        CGFloat x = (headerView.frame.size.width - yearAndMonthLabel.frame.size.width)/2;
        CGFloat y = (headerView.frame.size.height - yearAndMonthLabel.frame.size.height)/2;
        CGFloat width = yearAndMonthLabel.frame.size.width;
        CGFloat height = yearAndMonthLabel.frame.size.height;
        
        yearAndMonthLabel.frame = CGRectMake(x, y, width, height);
        
        [headerView addSubview:yearAndMonthLabel];

        return headerView;
    }
    return nil;

}

-(NSString *)getDateStrForSection:(NSInteger)section day:(NSInteger)day{
    return [NSString stringWithFormat:@"%ld-%ld-%ld", section/12 + 1970, section%12 + 1, day];
}


//设置header的高度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    CGFloat ScreenWidth = [UIScreen mainScreen].bounds.size.width;
    return (CGSize){ScreenWidth, 33};
}

//cell点击
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    CJMonthDayCollectionCell *cell = (CJMonthDayCollectionCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    NSLog(@"%@", cell.gregoiainCalendar);
    NSLog(@"%@", cell.chineseCalendar);
}


@end
