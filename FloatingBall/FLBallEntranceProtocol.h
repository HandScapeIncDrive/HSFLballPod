//
//  FLBallEntranceProtocol.h
//  FLBallEntranceProtocol
//
//  Created by yifan on 2018/8/7.
//  Copyright © 2018 HandScape. All rights reserved.
//

@protocol FLBallEntranceProtocol <NSObject>

@optional

/**
 * 需要缓存的信息（例如url）
 */
- (NSString *)HS_suspensionCacheMsg;

/**
 * 浮窗的logo图标
 */
- (UIImage *)HS_suspensionLogoImage;

/**
 * 加载浮窗的logo图标的回调
 * 当“jp_suspensionLogoImage”没有实现或者返回的是nil，就会调用该方法，需要自定义加载方案，这里只提供调用时机
 */
- (void)HS_requestSuspensionLogoImageWithLogoView:(UIImageView *)logoView;

@end
