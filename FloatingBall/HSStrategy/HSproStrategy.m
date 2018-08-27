//
//  HSproStrategy.m
//  HSFloatingBallDemo
//
//  Created by Yifan on 2018/8/9.
//  Copyright © 2018年 Yifan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HSproStrategy.h"
#import <QuartzCore/QuartzCore.h>

@interface HSproStrategy ()
{
    FingerTouch *finger;
    CGRect Rect1;
    CGRect Rect2;
    CGRect Rect3;
    CGRect Rect4;

}
@property (assign, nonatomic) CGRect startRect;
@property (nonatomic, strong) NSMutableDictionary *activeRects;

@end

@implementation HSproStrategy


- (id) init
{
    self = [super initWithDeviceType: hspro];
    
    if (self)
    {

        self.activeRects = [[NSMutableDictionary alloc] init];
//        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        // hsctap notifications
//        [nc addObserver: self selector: @selector(R1taped:) name: HSCR1_NOTIFICATION object: nil];
//        [nc addObserver: self selector: @selector(R2taped:) name: HSCR2_NOTIFICATION object: nil];
//        [nc addObserver: self selector: @selector(L1taped:) name: HSCR3_NOTIFICATION object: nil];
//        [nc addObserver: self selector: @selector(L2taped:) name: HSCR4_NOTIFICATION object: nil];
        Rect1 =  CGRectMake(0, 200, 1500, 1550);
        Rect2 =  CGRectMake(2500, 200, 1500, 1550);
        Rect3 =  CGRectMake(0, 1750, 1500, 1550);
        Rect4 =  CGRectMake(2500, 1700, 1500, 1550);
        
    }
    return self;
}


//- (void) R1taped: (HSCTouch*) touch
//{
//    if ([self detectTapGesture:touch] == YES ) {
//        NSLog(@"R1 detected");
//
//    }
//}
//
//- (void) R2taped: (HSCTouch*) touch
//{
//    if ([self detectTapGesture:touch] == YES) {
//        NSLog(@"R2 detected");
//
//    }
//}
//
//- (void) L1taped: (HSCTouch*) touch
//{
//    if ([self detectTapGesture:touch] == YES) {
//        NSLog(@"L1 detected");
//
//    }
//}
//
//- (void) L2taped: (HSCTouch*) touch
//{
//    if ([self detectTapGesture:touch] == YES) {
//        NSLog(@"L2 detected");
//
//    }
//}

#pragma mark Tap detect
- (void) initTapDetect:(int)tapNumber interval:(NSTimeInterval) timeInterval
{
    intervalThrsh = timeInterval;
    tapThresh = tapNumber;
    
    aryFingerTouchs = [[NSMutableArray alloc] init];
}

//- (BOOL) detectTapGesture:(HSCTouch *)touch
//{
//    int i;
//    BOOL tapFlag = NO;
//    if (i >= aryFingerTouchs.count)
//    { // new finger touch
//        finger = [[FingerTouch alloc] init];
//        finger.key = touch.key;
//        finger.prevTouchStatus = touch.state;
//        finger.prevTouchTime = touch.timestamp;
//        finger.tapCount = 1;
//        [aryFingerTouchs addObject:finger];
//    }
//    else
//    {
//        NSTimeInterval timeDelta = touch.timestamp - finger.prevTouchTime;
//        if (timeDelta < intervalThrsh)
//        {
//            finger.tapCount = finger.tapCount +1 ;
//            
//            if (finger.tapCount >= tapThresh)
//            {
//                finger.tapCount = 0;
//                tapFlag = YES;
//            }
//        }
//        else
//        {
//            if (touch.state == 0)
//                finger.tapCount = 1;
//            else
//                finger.tapCount = 0;
//        }
//        finger.prevTouchStatus = touch.state;
//        finger.prevTouchTime = touch.timestamp;
//    }
//    
//    return tapFlag;
//}
//


@end
