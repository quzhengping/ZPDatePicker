//
//  ViewController.m
//  ZPDatePicker
//
//  Created by 曲正平 on 2018/4/19.
//  Copyright © 2018年 曲正平. All rights reserved.
//

#import "ViewController.h"
#import "ZPDatePicker.h"
#import "ZPContailerVC.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)StartDate:(id)sender {
    
    ZPDatePicker *datePicker = [[ZPDatePicker alloc] initWithDefaultDate:@"2017-04-21" MaximumDate:@"2017-04-30" MinimumDate:@"2017-06-01"];
    datePicker.doneButtonBlock = ^(NSString *dateString) {
        NSLog(@"============date    %@",dateString);
    };
    datePicker.mode = ZPDatePickerModeYearMonthDay;
    ZPContailerVC *controller = [[ZPContailerVC alloc] initWithContentView:datePicker animationType:ITAnimationTypeBottom];
    
    [self presentViewController:controller animated:YES completion:nil];
}


- (IBAction)endDate:(id)sender {
    ZPDatePicker *datePicker = [[ZPDatePicker alloc] init];
    datePicker.doneButtonBlock = ^(NSString *dateString) {
        NSLog(@"============date    %@",dateString);
    };
    datePicker.mode = ZPDatePickerModeYear;
    
    ZPContailerVC *controller = [[ZPContailerVC alloc] initWithContentView:datePicker animationType:ITAnimationTypeBottom];
    [self presentViewController:controller animated:YES completion:nil];

}

- (IBAction)YMDAction:(id)sender {
    
    ZPDatePicker *datePicker = [[ZPDatePicker alloc] init];
    datePicker.doneButtonBlock = ^(NSString *dateString) {
        NSLog(@"============date    %@",dateString);
    };
    datePicker.mode = ZPDatePickerModeYearMonthDay;
   
    ZPContailerVC *controller = [[ZPContailerVC alloc] initWithContentView:datePicker animationType:ITAnimationTypeBottom];
    
    [self presentViewController:controller animated:YES completion:nil];
}


- (IBAction)YMAction:(id)sender {
    
    ZPDatePicker *datePicker = [[ZPDatePicker alloc] init];
    datePicker.doneButtonBlock = ^(NSString *dateString) {
        NSLog(@"============date    %@",dateString);
    };
    datePicker.mode = ZPDatePickerModeYearMonth;
    
    ZPContailerVC *controller = [[ZPContailerVC alloc] initWithContentView:datePicker animationType:ITAnimationTypeBottom];
    
    [self presentViewController:controller animated:YES completion:nil];
}

- (IBAction)YAction:(id)sender {
    
    ZPDatePicker *datePicker = [[ZPDatePicker alloc] init];
    datePicker.doneButtonBlock = ^(NSString *dateString) {
        NSLog(@"============date   %@",dateString);
    };
    datePicker.mode = ZPDatePickerModeYear;
  
    ZPContailerVC *controller = [[ZPContailerVC alloc] initWithContentView:datePicker animationType:ITAnimationTypeBottom];
    
    [self presentViewController:controller animated:YES completion:nil];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
