//
//  HSCHandsView.h
//  HandScapeSDK
//
//  Created by John Brewer on 10/27/14.
//  Copyright (c) 2014 HandScape, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HSCXEBitmapHandsEnum.h"
#import "HSCHandMode.h"
/**
 * Fingers, palms, thumbs, pointers views
 */
@interface HSCHandsView : UIView

-(void)setBitmapHandImageFamily:(HSCXEBitmapHandsEnum)family;

// Scale up/down finger length/width.
-(void)resizeFingerLengthScale:(float)lengthScale widthScale:(float)widthScale;

-(void)setHandsOnFront:(BOOL)handsOnFront;
-(void)setHidePalms:(BOOL)hidePalms;
-(void)setHideThumbs:(BOOL)hideThumbs;
-(void)setHideHands:(BOOL)hideHands;
-(void)setHandsMode:(HSCHandMode)handMode;
-(void)splitHandsByMiddleLine;
-(void)setMaxFingerNumber:(int)number;

+ (void)setHandsViewInVC:(BOOL)newValue;
+ (BOOL)getHandsViewInVC;
+ (void)setCaseOnFront:(BOOL)newValue;
+ (BOOL)getCaseOnFront;
+ (void)setCustomKeyboardScaleY:(float)newValue;
+ (float)getCustomKeyboardScaleY;
@end
