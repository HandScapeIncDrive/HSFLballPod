//
//  FloatingBallmanager.h
//  HSFloatingBallDemo
//
//  Created by Yifan on 2018/8/6.
//  Copyright © 2018年 Yifan. All rights reserved.
//

#ifndef FloatingBallmanager_h
#define FloatingBallmanager_h


#endif /* FloatingBallmanager_h */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FloatingBallmanager : NSObject

+ (instancetype)shared;

/**
 *  Get UIWindow based on key value
 *
 *  @param key key
 *
 *  @return window
 */
+ (UIWindow *)windowForKey:(NSString *)key;

/**
 *  Save a window and set the key
 *
 *  @param window window
 *  @param key    key
 */
+ (void)saveWindow:(UIWindow *)window forKey:(NSString *)key;

/**
 *  Destroy a window according to key
 *
 *  @param key       key
 */
+ (void)destroyWindowForKey:(NSString *)key;

/**
 *  Destroy all window
 */
+ (void)destroyAllWindow;

@end
