//
//  ZPContailerVC.m
//  ZPDatePicker
//
//  Created by 曲正平 on 2018/4/19.
//  Copyright © 2018年 曲正平. All rights reserved.
//

#import "ZPContailerVC.h"
#import "ZPAppdefine.h"

@interface ZPContailerVC ()<UIViewControllerTransitioningDelegate>
@property (nonatomic) ITAnimationType animationType;
@property (strong, nonatomic) UIView *contentView;
@property (strong, nonatomic) UIView *backgroundView;
@end

@implementation ZPContailerVC


- (instancetype)init {
    if (self = [super init]) {
        [self configContainerController];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self configContainerController];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self configContainerController];
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil
                         bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        [self configContainerController];
    }
    return self;
}


- (instancetype)initWithContentView:(UIView *)contentView
                      animationType:(ITAnimationType)animationType{
    self = [super init];
    if (self) {
        _contentView = contentView;
        _animationType = animationType;
        [self configContainerController];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
    [self.view insertSubview:self.backgroundView atIndex:0];
    [self.view addSubview:self.contentView];
    [self addSingleTapGestures];
    
    [self autoLayoutSubviews];
}

#pragma mark - IBActions
#pragma mark -

- (void)singleTap:(UITapGestureRecognizer *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Private
#pragma mark -

- (void)configContainerController {
    self.providesPresentationContextTransitionStyle = YES;
    self.definesPresentationContext = YES;
    self.modalPresentationStyle = UIModalPresentationCustom;
    self.transitioningDelegate = self;
}

- (void)addSingleTapGestures {
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
    [self.backgroundView addGestureRecognizer:singleTap];
}

- (void)autoLayoutSubviews {
    
    CGFloat contentWidth = CGRectGetWidth(self.contentView.frame);
    CGFloat contentHeight = CGRectGetHeight(self.contentView.frame);
    switch (self.animationType) {
        case ITAnimationTypeBottom: {
            self.contentView.frame = CGRectMake((ScreenWidth-contentWidth)/2, ScreenHeight-contentHeight, contentWidth, contentHeight);
            break;
        }
        case ITAnimationTypeCenter: {
            self.contentView.center = self.view.center;
            break;
        }
    }

}

#pragma mark - Delegate Collection

#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source {
    return [ITAnimation animationWithType:self.animationType presenting:YES];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [ITAnimation animationWithType:self.animationType presenting:NO];
}

- (UIView *)viewContainer {
    return self.view;
}

- (UIView *)backgroundView {
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc] initWithFrame:self.view.bounds];
        _backgroundView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    }
    return _backgroundView;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
