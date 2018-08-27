//
//  FloatingBallView.m
//  HSFloatingBallDemo
//
//  Created by Yifan on 2018/8/6.
//  Copyright © 2018年 Yifan. All rights reserved.
//

#import "FloatingBallView.h"
#import "NSObject+FloatingBallView.h"
#import "FloatingBallmanager.h"
#import "FLBallEntranceProtocol.h"

#define kLeanProportion (8/55.0)
#define kVerticalMargin 15.0

@implementation FloatingViewContainer
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.windowLevel = 1000000;
        self.clipsToBounds = YES;
    }
    return self;
}
@end

@implementation FloatingBallViewController
- (BOOL)prefersStatusBarHidden
{
    return NO;
}
@end

@implementation FloatingBallView
{
    CGFloat _suspensionScreenEdgeBottomInset;

}
+ (instancetype)defaultSuspensionViewWithDelegate:(id<FloatingBallViewDelegate>)delegate
{
    FloatingBallView *sus = [[FloatingBallView alloc] initWithFrame:CGRectMake(-kLeanProportion * 55, 100, 55, 55)
                                                              color:[UIColor colorWithRed:0.21f green:0.45f blue:0.88f alpha:1.00f]
                                                           delegate:delegate];
    return sus;
}

+ (CGFloat)suggestXWithWidth:(CGFloat)width
{
    return - width * kLeanProportion;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame
                         color:[UIColor colorWithRed:0.21f green:0.45f blue:0.88f alpha:1.00f]
                      delegate:nil];
}

- (instancetype)initWithFrame:(CGRect)frame color:(UIColor*)color delegate:(id<FloatingBallViewDelegate>)delegate
{
    if(self = [super initWithFrame:frame])
    {
        self.delegate = delegate;
        self.userInteractionEnabled = YES;
        self.backgroundColor = color;
        self.alpha = .7;
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        self.layer.borderColor = [UIColor whiteColor].CGColor;
        self.layer.borderWidth = 1.0;
        self.clipsToBounds = YES;
        
        CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
        CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
        CGFloat scale = screenW / 375.0;
        BOOL isIphoneX = MAX(screenW, screenH) > 736.0;
        
        _suspensionViewWH = 64.0 * scale;
        _suspensionLogoMargin = 8.0 * scale;
        _suspensionScreenEdgeInsets = UIEdgeInsetsMake([UIApplication sharedApplication].statusBarFrame.size.height, 15.0, isIphoneX ? 34.0 : 0, 15.0);
        _suspensionScreenEdgeBottomInset = _suspensionScreenEdgeInsets.bottom;
        CGFloat x = self.bounds.size.width * (self.suspensionLogoMargin / self.suspensionViewWH);
        CGFloat wh = self.bounds.size.width - 2 * x;
        CGFloat y = (self.bounds.size.height - wh) * 0.5;
        UIImageView *logoView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, wh, wh)];
        UIImage *logoImage = [UIImage imageNamed:@"logoImage_connected"];
               if (logoImage) {
                    logoView.image = logoImage;
                }
        [self addSubview:logoView];
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePanGesture:)];
        pan.delaysTouchesBegan = YES;
        [self addGestureRecognizer:pan];
        [self addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

#pragma mark - event response
- (void)handlePanGesture:(UIPanGestureRecognizer*)p
{
    UIWindow *appWindow = [UIApplication sharedApplication].delegate.window;
    CGPoint panPoint = [p locationInView:appWindow];
    
    if(p.state == UIGestureRecognizerStateBegan) {
        self.alpha = 1;
    }else if(p.state == UIGestureRecognizerStateChanged) {
        [FloatingBallmanager windowForKey:self.zy_md5Key].center = CGPointMake(panPoint.x, panPoint.y);
    }else if(p.state == UIGestureRecognizerStateEnded
             || p.state == UIGestureRecognizerStateCancelled) {
        self.alpha = .7;
        
        CGFloat ballWidth = self.frame.size.width;
        CGFloat ballHeight = self.frame.size.height;
        CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
        CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height;
        
        CGFloat left = fabs(panPoint.x);
        CGFloat right = fabs(screenWidth - left);
        CGFloat top = fabs(panPoint.y);
        CGFloat bottom = fabs(screenHeight - top);
        
        CGFloat minSpace = 0;
        if (self.leanType == FloatingBallViewLeanTypeHorizontal) {
            minSpace = MIN(left, right);
        }else{
            minSpace = MIN(MIN(MIN(top, left), bottom), right);
        }
        CGPoint newCenter = CGPointZero;
        CGFloat targetY = 0;
        
        //Correcting Y
        if (panPoint.y < kVerticalMargin + ballHeight / 2.0) {
            targetY = kVerticalMargin + ballHeight / 2.0;
        }else if (panPoint.y > (screenHeight - ballHeight / 2.0 - kVerticalMargin)) {
            targetY = screenHeight - ballHeight / 2.0 - kVerticalMargin;
        }else{
            targetY = panPoint.y;
        }
        
        CGFloat centerXSpace = (0.5 - kLeanProportion) * ballWidth;
        CGFloat centerYSpace = (0.5 - kLeanProportion) * ballHeight;
        
        if (minSpace == left) {
            newCenter = CGPointMake(centerXSpace, targetY);
        }else if (minSpace == right) {
            newCenter = CGPointMake(screenWidth - centerXSpace, targetY);
        }else if (minSpace == top) {
            newCenter = CGPointMake(panPoint.x, centerYSpace);
        }else {
            newCenter = CGPointMake(panPoint.x, screenHeight - centerYSpace);
        }
        
        [UIView animateWithDuration:.25 animations:^{
            [FloatingBallmanager windowForKey:self.zy_md5Key].center = newCenter;
        }];
    }else{
        NSLog(@"pan state : %zd", p.state);
    }
}

- (void)click
{
    if([self.delegate respondsToSelector:@selector(suspensionViewClick:)])
    {
        [self.delegate suspensionViewClick:self];
    }
}

#pragma mark - public methods
- (void)show
{
    if ([FloatingBallmanager windowForKey:self.zy_md5Key]) return;
    
    UIWindow *currentKeyWindow = [UIApplication sharedApplication].keyWindow;
    
    FloatingViewContainer *backWindow = [[FloatingViewContainer alloc] initWithFrame:self.frame];
    backWindow.rootViewController = [[FloatingBallViewController alloc] init];
    [backWindow makeKeyAndVisible];
    [FloatingBallmanager saveWindow:backWindow forKey:self.zy_md5Key];
    
    self.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    self.layer.cornerRadius = self.frame.size.width <= self.frame.size.height ? self.frame.size.width / 2.0 : self.frame.size.height / 2.0;
    self.titleLabel.text = @"HS";
    [backWindow addSubview:self];
    
    // Keep the original keyWindow and avoid some unpredictable problems
    [currentKeyWindow makeKeyWindow];
}

- (void)removeFromScreen
{
    [FloatingBallmanager destroyWindowForKey:self.zy_md5Key];
}

#pragma mark - getter
- (FloatingViewContainer *)containerWindow
{
    return (FloatingViewContainer *)[FloatingBallmanager windowForKey:self.zy_md5Key];
}

@end
