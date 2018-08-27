//
//  HSStrategy.h
//  HSFloatingBallDemo
//
//  Created by Yifan on 2018/8/13.
//  Copyright © 2018年 Yifan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <HandScapeSDK/HSCTouchpadManager.h>

@interface FingerTouch : NSObject
@property (nonatomic, strong) NSString *key;
@property (nonatomic) NSTimeInterval prevTouchTime;
@property (nonatomic) int prevTouchStatus;
@property (nonatomic) int tapCount;
@end



@interface HSStrategy : NSObject
{
    // tap
    NSMutableArray *aryFingerTouchs;
    NSTimeInterval intervalThrsh;
    int tapThresh;
}
typedef enum {
    hspro    = 0x100,
    // There currently aren't any other event types, but there will
    // be more device later.
} HSDeviceType;

@property (readonly) HSDeviceType eventType;

- (id) initWithDeviceType: (HSDeviceType) eType;

@end
