//
//  FloatingBallmanager.m
//  HSFloatingBallDemo
//
//  Created by Yifan on 2018/8/6.
//  Copyright © 2018年 Yifan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FloatingBallmanager.h"

@interface FloatingBallmanager ()

/** save windows dictionary */
@property (nonatomic, strong) NSMutableDictionary *windowDic;

@end

@implementation FloatingBallmanager

static FloatingBallmanager *_instance;

+ (instancetype)shared
{
    if (!_instance) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _instance = [[self alloc] init];
        });
    }
    return _instance;
}

+ (id)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}


#pragma mark - getter
- (NSMutableDictionary *)windowDic
{
    if (!_windowDic) {
        _windowDic = [NSMutableDictionary dictionary];
    }
    return _windowDic;
}

#pragma mark - public methods

+ (UIWindow *)windowForKey:(NSString *)key
{
    return [[FloatingBallmanager shared].windowDic objectForKey:key];
}

+ (void)saveWindow:(UIWindow *)window forKey:(NSString *)key
{
    [[FloatingBallmanager shared].windowDic setObject:window forKey:key];
}

+ (void)destroyWindowForKey:(NSString *)key
{
    UIWindow *window = [[FloatingBallmanager shared].windowDic objectForKey:key];
    window.hidden = YES;
    if (window.rootViewController.presentedViewController) {
        [window.rootViewController.presentedViewController dismissViewControllerAnimated:NO completion:nil];
    }
    window.rootViewController = nil;
    [[FloatingBallmanager shared].windowDic removeObjectForKey:key];
}

+ (void)destroyAllWindow
{
    for (UIWindow *window in [FloatingBallmanager shared].windowDic.allValues) {
        window.hidden = YES;
        window.rootViewController = nil;
    }
    [[FloatingBallmanager shared].windowDic removeAllObjects];
    [[UIApplication sharedApplication].delegate.window makeKeyAndVisible];
}

@end
