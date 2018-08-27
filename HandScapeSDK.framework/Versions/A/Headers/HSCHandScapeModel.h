//
//  HSCHandScapeModel.h
//  HandScapeSDK
//
//  Created by John Brewer on 10/27/14.
//  Copyright (c) 2014 HandScape, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "HSCXERenderObjectHand2D.h"
#include "HSCHandMode.h"
#include "HSCAllPointData.h"
#import "HSCIExt2DHandModel.h"
#import "HSCTouchpad.h"

/**
 * HandScapeModel
 */

extern const BOOL      HSC_s_SHOW_DEBUG_OPTION;

extern const float     HSC_s_FINGER_LENGTH_DENSITYDPI_FACTOR;
extern const float     HSC_s_FINGER_WIDTH_DENSITYDPI_FACTOR;
extern const float     HSC_s_FINGER_TIP_DENSITYDPI_FACTOR;

extern HSCHandMode     HSC_s_HAND_MODE;

extern int             HSC_s_DEFAULT_FINGER_LENGTH;
extern int             HSC_s_DEFAULT_FINGER_WIDTH;
extern int             HSC_s_DEFAULT_FINGER_TIP_SIZE;

extern const int       HSC_s_MAX_FINGER_NUMBER;

extern const uint32_t  HSC_s_ANDROID_COLORS[];

@interface HSCHandScapeModel : NSObject

@property (nonatomic, retain) HSCAllPointData *dispR;
@property (nonatomic, retain) HSCAllPointData *dispL;
@property (nonatomic, retain) HSCAllPointData *prevDispR;
@property (nonatomic, retain) HSCAllPointData *prevDispL;
@property (nonatomic, retain) HSCAllPointData *rootR;
@property (nonatomic, retain) HSCAllPointData *rootL;
@property (nonatomic, retain) HSCAllPointData *prevRootR;
@property (nonatomic, retain) HSCAllPointData *prevRootL;

@property (nonatomic, assign) BOOL debugEnabled;      // set to false for final release

@property (nonatomic, assign) int fingerLength, fingerWidth;

// device dependent
@property (nonatomic, assign) int densityDPI;

@property (nonatomic, assign) HSCTouchpad *defaultDeviceId, *currentDeviceId;
// "handsOnFront=false/true" means default mode is back/front mode, and user needs to
// first touch the back/front panel in order for us to set the back/front panel device id.
@property (nonatomic, assign) BOOL defaultModeDeviceIdSet;

// -----------

@property (nonatomic, assign) int maxFingers, maxFingerR, maxFingerL, fingerTipSize;


@property (nonatomic, strong) HSCVector2f *palmRight, *palmLeft, *prevPalmRight, *prevPalmLeft;

@property (nonatomic, assign) int numOfPositionsR, numOfPositionsL, numOfDispR, numOfDispL;
@property (nonatomic, assign) int prevNumOfPositionsR, prevNumOfPositionsL, prevNumOfDispR, prevNumOfDispL;

@property (nonatomic, assign) float angleR, angleL, prevAngleR, prevAngleL;

@property (nonatomic, strong) HSCVector2f *movingDeltaRight, *movingDeltaLeft;

@property (nonatomic, assign) BOOL handsOnFront, babyHand;
@property (nonatomic, assign) BOOL hideHands, hidePalms, hideThumbs;

@property (nonatomic, assign) BOOL onCalibration;

@property (nonatomic, strong) HSCVector2f *firstTouch;
@property (nonatomic, assign) BOOL firstTouchReady;

@property (nonatomic, assign) NSInteger handModelIndex;

@property (nonatomic, assign) BOOL handsLockedForSwap;
@property (nonatomic, assign) BOOL applyHalfRuleOnly;

// for Android pinch gesture
@property (nonatomic, strong) HSCVector2f *minEnclosingCircleCenter;

// ----------

+(HSCHandScapeModel*)getModel;
// Scale up/down finger length/width/tipSize.
-(void)resizeFingerLength:(float)scaleLength fingerWidth:(float)scaleWidth;
-(instancetype) init:(int)densityDPI;
-(void)add2DHandModel:(id<HSCIExt2DHandModel>)handModel selected:(BOOL)select;
-(void)change2DHandModel;
-(BOOL)thumbPresentAtHand:(HSCHandType)handType;
-(BOOL)leftFingerPresent;
-(BOOL)rightFingerPresent;
-(BOOL)fingerPresent;
-(int)leftTouchCount;
-(int)rightTouchCount;
-(int)touchCount;
-(BOOL)leftHandFull;
-(BOOL)rightHandFull;
-(BOOL)leftHandFullDisp;
-(BOOL)rightHandFullDisp;
-(id<HSCIExt2DHandModel>)getSelected2DHandModel;
-(id<HSCIExt2DHandModel>)get2DHandModelAtIndex:(int)index;
-(void)select2DHandModel:(id<HSCIExt2DHandModel>)handModel;
-(void)updateMaxFingerLR;
-(void)setMaxFingerNumber:(int)number;

-(HSCXERenderObjectHand2D)getFingerTypeForHandType:(HSCHandType)handType index:(int)index;
-(int)getFingerIndexForHandType:(HSCHandType)handType fingerType:(HSCXERenderObjectHand2D)fingerType;

-(void)setBabyHand:(BOOL)babyHand;
-(void)toggleBabyHand;
-(void)toggleHandsOnFront;
-(void)setHandMode:(HSCHandMode)handMode;
-(HSCHandMode)getHandMode;
-(void)setHandsOnFront:(BOOL)handsOnFront;
-(void)swapHands;
-(float)leftMinEnclosingCircleRadius;
-(float)rightMinEnclosingCircleRadius;

@end
