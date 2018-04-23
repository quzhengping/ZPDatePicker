//
//  ITContainerControllerProtocol.h
//  ITAlertBox
//
//  Created by Wit on 2017/9/16.
//  Copyright © 2017年 Wit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ZPDatePicker.h"


@protocol ITContainerControllerProtocol <NSObject>

@required

- (UIView *)viewContainer;
- (ZPDatePicker *)contentView;
- (UIView *)backgroundView;

@end
