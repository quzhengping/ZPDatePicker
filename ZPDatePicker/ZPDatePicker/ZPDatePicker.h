//
//  ZPDatePicker.h
//  ZPDatePicker
//
//  Created by 曲正平 on 2018/4/19.
//  Copyright © 2018年 曲正平. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ZPDatePickerMode) {
    ZPDatePickerModeYear,          //Displays Only Year, like 2018
    ZPDatePickerModeYearMonth,     //Displays year, month, like 2018-04
    ZPDatePickerModeYearMonthDay,  //Displays year, month and day, like 2018-04-19
};

@interface ZPDatePicker : UIView
@property (nonatomic) ZPDatePickerMode mode;


/**
 datePicker初始化
 
 @param defaultDate 默认显示日期
 @param maximumDate 最大日期范围
 @param minimumDate 最小日期范围
 @return 返回实例
 */
- (instancetype)initWithDefaultDate:(NSString *)defaultDate MaximumDate:(NSString *)maximumDate MinimumDate:(NSString *)minimumDate;

@property(nonatomic,copy) void (^doneButtonBlock)(NSString *dateString);

@end
