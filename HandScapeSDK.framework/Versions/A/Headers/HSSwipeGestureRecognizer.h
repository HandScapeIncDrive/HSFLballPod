//
//  HSSwipeGestureRecognizer.h
//  HandyCamera
//
//  Created by Quasar on 1/26/18.
//  Copyright © 2018 Handscape. All rights reserved.
//

#import <HandScapeSDK/HandScapeSDK.h>

@interface HSSwipeGestureRecognizer : HSCGestureRecognizer

-(void)handleTouch:(HSCTouch*)touch view:(UIView*)view callback:(void (^)(HSCGestureState state, HSCSwipeDirection direction))callback;

@end
