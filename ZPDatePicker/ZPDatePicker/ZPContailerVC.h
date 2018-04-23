//
//  ZPContailerVC.h
//  ZPDatePicker
//
//  Created by 曲正平 on 2018/4/19.
//  Copyright © 2018年 曲正平. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ITAnimation.h"
#import "ITContainerControllerProtocol.h"

@interface ZPContailerVC : UIViewController

- (instancetype)initWithContentView:(UIView *)contentView
                      animationType:(ITAnimationType)animationType;

@end
