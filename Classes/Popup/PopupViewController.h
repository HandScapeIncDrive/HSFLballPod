//
//  PopupViewController.h
//  HSFloatingBallDemo
//
//  Created by Yifan on 2018/8/8.
//  Copyright © 2018年 Yifan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PopupViewController : UIViewController
// 是否碰到了
@property (nonatomic, assign, readonly) BOOL isTouch;
// 判断点
@property (nonatomic, assign) CGPoint touchPoint;
@property (nonatomic, copy) void (^ViewControllerBlock)(CGPoint touchPoint);

// 配置
@property(nonatomic) int currentSetting;


@end
