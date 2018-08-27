//
//  NSObject+FloatingBallView.m
//  HSFloatingBallDemo
//
//  Created by Yifan on 2018/8/6.
//  Copyright © 2018年 Yifan. All rights reserved.
//

#import "NSObject+FloatingBallView.h"
#import <CommonCrypto/CommonDigest.h>
#import <objc/runtime.h>

const void *cyf_suspensionMd5Key = &cyf_suspensionMd5Key;

@implementation NSObject (FloatingBallView)

- (NSString *)zy_md5Key
{
    NSString *str = objc_getAssociatedObject(self, cyf_suspensionMd5Key);
    if (str.length <= 0) {
        NSString *desStr = self.description;
        const char *cStr = [desStr UTF8String];
        unsigned char result[16];
        CC_MD5( cStr, (int)strlen(cStr), result );
        str = [NSString stringWithFormat:
               @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
               result[0],result[1],result[2],result[3],
               result[4],result[5],result[6],result[7],
               result[8],result[9],result[10],result[11],
               result[12],result[13],result[14],result[15]];
        
        objc_setAssociatedObject(self, cyf_suspensionMd5Key, str, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return str;
}

@end
