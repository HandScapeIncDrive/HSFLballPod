//
//  TargetView.h
//  HSFloatingBallDemo
//
//  Created by henry yi on 6/3/15.
//  Copyright (c) 2015 henry yi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PopupViewController.h"

@interface TargetView : UIView

@property(nonatomic) BOOL start;

@property(nonatomic) CGPoint dragPoint;
@property(nonatomic) BOOL taken;
@property(nonatomic) UIColor *color;
@property(nonatomic) NSString *t;

@property(nonatomic) UITouch *touch;

@property(nonatomic) CGPoint originalCenter;

- (id)initWithFrame:(CGRect)frame color:(UIColor *)color text:(NSString *)buttonlabel;

- (void)resetLocation;

- (void)setLocation:(CGPoint)touchLocation;

-(void)blink;
-(void)scale;

@end
