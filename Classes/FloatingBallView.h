//
//  FloatingBallView.h
//  HSFloatingBallDemo
//
//  Created by Yifan on 2018/8/6.
//  Copyright © 2018年 Yifan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FloatingViewContainer : UIWindow
@end

@interface FloatingBallViewController : UIViewController
@end

@class FloatingBallView;
@protocol FloatingBallViewDelegate <NSObject>
/** callback for click on the FloatingBallView */
- (void)suspensionViewClick:(FloatingBallView *)suspensionView;
@end

typedef NS_ENUM(NSUInteger, FloatingBallViewLeanType) {
    /** Can only stay in the left and right */
    FloatingBallViewLeanTypeHorizontal,
    /** Can stay in the upper, lower, left, right */
    FloatingBallViewLeanTypeEachSide
};

//TODO FloatingBallState not used yet
typedef NS_ENUM(NSInteger, FloatingBallState)
{
    floatingballCollapsed,
    floatingballExpanded
};

@interface FloatingBallView : UIButton
@property (nonatomic, readonly) FloatingBallState currentState;

/** delegate */
@property (nonatomic, weak) id<FloatingBallViewDelegate> delegate;
/** lean type, default is FloatingBallViewLeanTypeHorizontal */
@property (nonatomic, assign) FloatingBallViewLeanType leanType;
/** container window */
@property (nonatomic, readonly) FloatingViewContainer *containerWindow;
@property (nonatomic, strong) UIImage *logoImage;
/**
 Create a default susView
 
 @param delegate delegate for susView
 @return obj
 */
+ (instancetype)defaultSuspensionViewWithDelegate:(id<FloatingBallViewDelegate>)delegate;

/** Get the suggest x with width */
+ (CGFloat)suggestXWithWidth:(CGFloat)width;

/**
 Create a susView
 
 @param frame frame
 @param color background color
 @param delegate delegate for susView
 @return obj
 */
- (instancetype)initWithFrame:(CGRect)frame color:(UIColor*)color delegate:(id<FloatingBallViewDelegate>)delegate;

/**
 *  Show
 */
- (void)show;

/**
 *  Remove and dealloc
 */
- (void)removeFromScreen;

/** 浮窗宽高 */
@property (nonatomic, assign, readonly) CGFloat suspensionViewWH;
/** 浮窗logo的边距 */
@property (nonatomic, assign, readonly) CGFloat suspensionLogoMargin;
/** 浮窗在窗口的内边距 */
@property (nonatomic, assign, readonly) UIEdgeInsets suspensionScreenEdgeInsets;
@end

