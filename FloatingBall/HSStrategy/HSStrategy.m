//
//  HSStrategy.m
//  HSFloatingBallDemo
//
//  Created by Yifan on 2018/8/13.
//  Copyright © 2018年 Yifan. All rights reserved.
//

#import "HSStrategy.h"

@implementation FingerTouch
@end

@implementation HSStrategy

- (id) init
{
    [[NSException exceptionWithName: @"Wrong init"
                             reason: @"Do not use init.  Use initWithDeviceType: instead"
                           userInfo: nil] raise];

    return nil;
}

- (id) initWithDeviceType: (HSDeviceType) eType;
{
    self = [super init];
    
    if (self)
    {
        _eventType = eType;
    }
    
    return self;
}

@end
