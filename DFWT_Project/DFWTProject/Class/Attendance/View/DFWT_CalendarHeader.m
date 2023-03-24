//
//  DFWT_CalendarHeader.m
//  DFWTProject
//
//  Created by Administrator on 2022/11/3.
//  Copyright © 2022 Administrator. All rights reserved.
//

#import "DFWT_CalendarHeader.h"
#import <FSCalendar/FSCalendar.h>
@interface DFWT_CalendarHeader()<FSCalendarDelegate,FSCalendarDataSource>
@property (weak, nonatomic) IBOutlet FSCalendar *calendar;
@property (strong, nonatomic) NSCalendar *gregorian;
@property (weak, nonatomic) IBOutlet UIButton *lastBtn;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleLb;

@end
@implementation DFWT_CalendarHeader

-(void)awakeFromNib{
    [super awakeFromNib];
    self.lastBtn.layer.borderColor = DEF_HEXColor(0xEBEDF0).CGColor;
    self.lastBtn.layer.borderWidth = 1;
    self.lastBtn.layer.cornerRadius = 20;
    self.lastBtn.layer.masksToBounds = YES;
    self.nextBtn.layer.borderColor = DEF_HEXColor(0xEBEDF0).CGColor;
    self.nextBtn.layer.borderWidth = 1;
    self.nextBtn.layer.cornerRadius = 20;
    self.nextBtn.layer.masksToBounds = YES;
    [self setCalendarStyle];
}
- (void)setCalendarStyle{
    //初始化
    self.gregorian = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    
    self.calendar.delegate = self;
    self.calendar.dataSource = self;
    //允许多选
    self.calendar.allowsMultipleSelection = YES;
    //设置为方格
    self.calendar.appearance.borderRadius = 0;
    // 当不显示头的时候设置
    self.calendar.headerHeight = 0.0f;
    //今天颜色
    self.calendar.appearance.todayColor = DEF_HEXColor(0x224CDA);
    //周文字颜色
    self.calendar.appearance.headerTitleColor = [UIColor blackColor];
    //title文字颜色
    self.calendar.appearance.weekdayTextColor = DEF_HEXColor(0x939496);
   //修改week文字
    self.calendar.appearance.caseOptions = FSCalendarCaseOptionsHeaderUsesUpperCase|FSCalendarCaseOptionsWeekdayUsesSingleUpperCase;
    //修改头部日期格式
    self.calendar.appearance.headerDateFormat = @"YYYY年MM月";
    //隐藏上下月透明度
    self.calendar.appearance.headerMinimumDissolvedAlpha = 0;
    [self setUpTitle];
}

//设置今天文字为"今",其他不变.

- (NSString *)calendar:(FSCalendar *)calendar titleForDate:(NSDate *)date{
    
    if ([self.gregorian isDateInToday:date]){
        return @"今";
    }
    return nil;
}
//上一个月
- (IBAction)lastAction:(UIButton *)sender {
    NSDate *lastMonth = [self.gregorian dateByAddingUnit:NSCalendarUnitMonth value:-1 toDate:self.calendar.currentPage options:0];
    [self.calendar setCurrentPage:lastMonth animated:YES];
    [self setUpTitle];
}
//下一个月
- (IBAction)nextAction:(UIButton *)sender {
    NSDate *nextMonth = [self.gregorian dateByAddingUnit:NSCalendarUnitMonth value:1 toDate:self.calendar.currentPage options:0];
    [self.calendar setCurrentPage:nextMonth animated:YES];
    [self setUpTitle];
}


// 设置年月日期
- (void)setUpTitle {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | //年
    NSCalendarUnitMonth | //月份
    NSCalendarUnitDay | //日
    NSCalendarUnitHour |  //小时
    NSCalendarUnitMinute |  //分钟
    NSCalendarUnitSecond;  // 秒
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:self.calendar.currentPage];
    NSInteger year = [dateComponent year];
    NSInteger month = [dateComponent month];
    self.titleLb.text = [NSString stringWithFormat:@"%ld年%ld月",year,month];
}

@end
