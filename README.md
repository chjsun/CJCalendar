# CJCalendar
![image](https://github.com/chjsun/readmeImage/blob/master/CJCalendar/modal.gif)

![image](https://github.com/chjsun/readmeImage/blob/master/CJCalendar/selecttitle.gif)

![image](https://github.com/chjsun/readmeImage/blob/master/CJCalendar/chuanzhi.gif)

使用这个日历灰常简单
只要把calendar拖到你的项目中，就可以直接用了

### 步骤：
#### 一 初始化

初始化控制器，代理监听，设置大小
```
  CJCalendarViewController *calendarController = [[CJCalendarViewController alloc] init];
  calendarController.view.frame = self.view.frame;
  calendarController.delegate = self;

```
#### 二 实现代理方法

可选代理方法，用来接受返回的年月日

```
-(void)CalendarViewController:(CJCalendarViewController *)controller didSelectActionYear:(NSString *)year month:(NSString *)month day:(NSString *)day;
```

### 可选的方法
#### 一 指定初始时间

```
/** 直接指定时间 */
@property (nonatomic, strong) NSDate *Date;
/** 传入年、月、日 ，设置时间 */
-(void) setYear:(NSString *)year month:(NSString *)month day:(NSString *)day;

```
