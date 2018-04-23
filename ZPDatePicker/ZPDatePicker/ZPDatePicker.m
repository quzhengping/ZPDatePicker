//
//  ZPDatePicker.m
//  ZPDatePicker
//
//  Created by 曲正平 on 2018/4/19.
//  Copyright © 2018年 曲正平. All rights reserved.
//

#import "ZPDatePicker.h"
#import "ZPAppdefine.h"

@interface ZPDatePicker()<UIPickerViewDelegate,UIPickerViewDataSource>
/**
 The maximum date defaults to December 2100.12.31
 */
@property (copy, nonatomic) NSString *maximumDate;

/**
 You can set the default date or default year or defalut month
 The default select date is now
 */
@property (copy, nonatomic) NSString *defaultDate;

/**
 The minimum default date is January 1900.01.01
 */
@property (copy, nonatomic) NSString *minimumDate;
@property (nonatomic) NSInteger thisYear;
@property (nonatomic) NSInteger thisMonth;
@property (nonatomic) NSInteger thisDay;
@property (nonatomic) NSInteger maximumYear;
@property (nonatomic) NSInteger maximumMonth;
@property (nonatomic) NSInteger maximumDay;
@property (nonatomic) NSInteger minimumYear;
@property (nonatomic) NSInteger minimumMonth;
@property (nonatomic) NSInteger minimumDay;
@property (strong, nonatomic) UIView *line;
@property (strong, nonatomic) UIBarButtonItem *cancelButton;
@property (strong, nonatomic) UIBarButtonItem *confirmButton;
@property (strong, nonatomic, readwrite) UIBarButtonItem *flexibleSpaceItem;
@property (strong, nonatomic, readwrite) UIToolbar *toolBar;
@property (strong, nonatomic) UIPickerView *pickerView;
@property (nonatomic) NSInteger resultYear;
@property (nonatomic) NSInteger resultMonth;
@property (nonatomic) NSInteger resultDay;
@end

@implementation ZPDatePicker





- (instancetype)initWithDefaultDate:(NSString *)defaultDate MaximumDate:(NSString *)maximumDate MinimumDate:(NSString *)minimumDate{
    self = [super init];
    if (self) {
        self.defaultDate = defaultDate;
        self.maximumDate = maximumDate;
        self.minimumDate = minimumDate;

        
        NSDate *currentDate = [NSDate date];
        NSCalendar* calendar = [NSCalendar currentCalendar];
        NSDateComponents* components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:currentDate];
        self.thisYear = [components year];
        self.thisMonth = [components month];
        self.thisDay = [components day];
        if(self.defaultDate.length>0){//有设置默认日期，就将日期设置为默认，否则就是当前日期
            self.thisYear =[[self.defaultDate  substringWithRange:NSMakeRange(0, 4)] integerValue];
            self.thisMonth = [[self.defaultDate substringWithRange:NSMakeRange(5, 2)] integerValue];
            self.thisDay = [[self.defaultDate substringWithRange:NSMakeRange(8, 2)] integerValue];
        }
        self.resultYear = self.thisYear;
        self.resultMonth = self.thisMonth;
        self.resultDay = self.thisDay;
        
        
        if(self.minimumDate.length > 0){
            self.minimumYear =[[self.minimumDate substringWithRange:NSMakeRange(0, 4)] integerValue];
            self.minimumMonth = [[self.minimumDate substringWithRange:NSMakeRange(5, 2)] integerValue];
            self.minimumDay = [[self.minimumDate substringWithRange:NSMakeRange(8, 2)] integerValue];
            
        }else{
            self.minimumDate = @"1900-01-01";
            self.minimumYear =[[self.minimumDate substringWithRange:NSMakeRange(0, 4)] integerValue];
            self.minimumMonth = [[self.minimumDate substringWithRange:NSMakeRange(5, 2)] integerValue];
            self.minimumDay = [[self.minimumDate substringWithRange:NSMakeRange(8, 2)] integerValue];
        }
        
        
        if(self.maximumDate.length > 0){
            self.maximumYear = [[self.maximumDate substringWithRange:NSMakeRange(0, 4)] integerValue];
            self.maximumMonth = [[self.maximumDate substringWithRange:NSMakeRange(5, 2)] integerValue];
            self.maximumDay = [[self.maximumDate substringWithRange:NSMakeRange(8, 2)] integerValue];
            
        }else{
            self.maximumDate = @"2900-01-01";
            self.maximumYear = [[self.maximumDate substringWithRange:NSMakeRange(0, 4)] integerValue];
            self.maximumMonth = [[self.maximumDate substringWithRange:NSMakeRange(5, 2)] integerValue];
            self.maximumDay = [[self.maximumDate substringWithRange:NSMakeRange(8, 2)] integerValue];
            
        }
        
        [self initDatePickerView];
        
    }
    return self;
    
    
}



- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.pickerView reloadAllComponents];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self refreshData];
        });
    });
}

- (void)refreshData {
    //默认选择年月日
    if (self.mode == ZPDatePickerModeYear) {
        [self.pickerView selectRow:(self.thisYear-self.minimumYear) inComponent:0 animated:NO];
    }else  if(self.mode == ZPDatePickerModeYearMonth) {
        [self.pickerView selectRow:(self.thisYear-self.minimumYear) inComponent:0 animated:NO];
        [self.pickerView selectRow:((self.thisMonth-1>=0)?(self.thisMonth-1):0) inComponent:1 animated:NO];
    }else  if(self.mode == ZPDatePickerModeYearMonthDay) {
        [self.pickerView selectRow:(self.thisYear-self.minimumYear) inComponent:0 animated:NO];
        [self.pickerView selectRow:((self.thisMonth-1>=0)?(self.thisMonth-1):0) inComponent:1 animated:NO];
        [self.pickerView selectRow:((self.thisDay-1>=0)?(self.thisDay-1):0) inComponent:2 animated:NO];
    }
}



- (void)initDatePickerView {

    [self addSubview:self.toolBar];
    [self addSubview:self.pickerView];
    self.frame = CGRectMake(0, 0, ScreenWidth, 260);
}




#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    if (self.mode == ZPDatePickerModeYear) {
        return 1;
    }else  if(self.mode == ZPDatePickerModeYearMonth) {
        return 2;
    }else  if(self.mode == ZPDatePickerModeYearMonthDay) {
        return 3;
    }else{
        return 0;
    }
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    switch (component) {
        case 0: return _maximumYear - _minimumYear+1;;
        case 1: return 12;
        case 2: {
            if(_resultMonth == 1 ||_resultMonth == 3 ||_resultMonth == 5 ||_resultMonth ==7||_resultMonth == 8 ||_resultMonth == 10 ||_resultMonth == 11){
                return 31;
            }else if (_resultMonth == 4 ||_resultMonth == 6 ||_resultMonth == 9 ||_resultMonth ==12){
                return 30;
            }else{
                if(_resultYear%4==0){
                    return 29;
                }else{
                    return 28;
                }
            }
        }
    }
    return 0;
}

#pragma mark - UIPickerViewDelegate

- (nullable NSString *)pickerView:(UIPickerView *)pickerView
                      titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) {
        return  [NSString stringWithFormat:@"%ld年", self.minimumYear+row];
    }else if (component == 1){
        return [NSString stringWithFormat:@"%ld月", row+1];
    }else  if (component == 2){
        return [NSString stringWithFormat:@"%ld日", row+1];
    }else{
        return @"--";
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        self.resultYear = self.minimumYear+row;
        [self.pickerView reloadComponent:2];
        [self.pickerView selectRow:0 inComponent:2 animated:YES];
    }else if (component == 1){
        self.resultMonth = row+1;
        [self.pickerView reloadComponent:2];
        [self.pickerView selectRow:0 inComponent:2 animated:YES];
        
        if(self.mode == ZPDatePickerModeYearMonth||self.mode == ZPDatePickerModeYearMonthDay){
            
            if (self.resultMonth<self.minimumMonth){
                [self.pickerView selectRow:self.minimumMonth-1 inComponent:1 animated:YES];
            }else if(self.resultMonth>self.maximumMonth){
                [self.pickerView selectRow:self.maximumMonth-1 inComponent:1 animated:YES];
            }
        }
    }else  if (component == 2){
        self.resultDay = row+1;
        if(self.resultDay>self.maximumDay){
            [self.pickerView selectRow:self.maximumDay-1 inComponent:2 animated:YES];
        }else if (self.resultDay<self.minimumDay){
            [self.pickerView selectRow:self.minimumDay-1 inComponent:2 animated:YES];
        }
    }
}




- (void)cancelButtonOnClicked:(UIButton *)sender {
    
    [[self topVC] dismissViewControllerAnimated:YES completion:nil];
}

- (void)confirmButtonOnClicked:(UIButton *)sender {
    NSString *dateString;
    if (self.mode == ZPDatePickerModeYear) {
        dateString = [NSString stringWithFormat:@"%ld",self.resultYear];
    }else  if(self.mode == ZPDatePickerModeYearMonth) {
        dateString = [NSString stringWithFormat:@"%ld-%ld",self.resultYear,self.resultMonth];
    }else  if(self.mode == ZPDatePickerModeYearMonthDay) {
        dateString = [NSString stringWithFormat:@"%ld-%ld-%ld",self.resultYear,self.resultMonth,self.resultDay];
    }
    
    if(self.doneButtonBlock){
        self.doneButtonBlock(dateString);
    }
    [self cancelButtonOnClicked:nil];
}

- (UIViewController *)topVC {
    UIViewController *resultVC;
    resultVC = [self _topViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [self _topViewController:resultVC.presentedViewController];
    }
    return resultVC;
}

- (UIViewController *)_topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self _topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self _topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}

- (UIToolbar *)toolBar {
    if (!_toolBar) {
        _toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 44)];
        _toolBar.translucent = NO;
        [_toolBar setItems:@[self.cancelButton, self.flexibleSpaceItem, self.confirmButton]];
        [_toolBar addSubview:self.line];
    }
    return _toolBar;
}

- (UIPickerView *)pickerView {
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 44, ScreenWidth, 216)];
        _pickerView.backgroundColor = [UIColor whiteColor];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
    }
    return _pickerView;
}



- (UIBarButtonItem *)cancelButton {
    if (!_cancelButton) {
        _cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelButtonOnClicked:)];
    }
    return _cancelButton;
}

- (UIBarButtonItem *)flexibleSpaceItem {
    if (!_flexibleSpaceItem) {
        _flexibleSpaceItem =
        [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                      target:self
                                                      action:nil];
    }
    
    return _flexibleSpaceItem;
}

- (UIBarButtonItem *)confirmButton {
    if (!_confirmButton) {
        _confirmButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(confirmButtonOnClicked:)];
    }
    return _confirmButton;
}

- (UIView *)line {
    if (!_line) {
        _line = [[UIView alloc] initWithFrame:CGRectMake(0, 39.5, ScreenWidth, 0.5)];
        _line.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1];
    }
    return _line;
}


@end
