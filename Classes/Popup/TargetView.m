//
//  TargetView.m
//  HSFloatingBallDemo
//
//  Created by henry yi on 6/3/15.
//  Copyright (c) 2015 henry yi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TargetView.h"
#import <QuartzCore/QuartzCore.h>
#import "PopupViewController.h"

@interface TargetView()

@property(nonatomic) int xOffset;
@property(nonatomic) int yOffset;

@property(nonatomic) UIColor *bgColor;

@property(nonatomic) double insetAmount;
@property (assign, nonatomic) CGPoint beginpoint;
@end

@implementation TargetView

- (id)initWithFrame:(CGRect)frame color:(UIColor *)color text:(NSString *)buttonlabel{

    self = [super initWithFrame:frame];
    
    if (self) {
        self.color = color;
        self.taken = NO;
        [self setOpaque:NO];
        //self.originalCenter = self.center;
        self.backgroundColor = [UIColor clearColor];
        self.bgColor = [UIColor clearColor];
        double sqrt3 = sqrt(3);
        self.insetAmount = self.frame.size.width * (sqrt3 - 1) / (2 * sqrt3);
        self.t = buttonlabel;

    }
    
    return self;
}

- (void)setDragPoint:(CGPoint)dragPoint {
    _dragPoint = dragPoint;
    
    self.xOffset = dragPoint.x - self.center.x;
    self.yOffset = dragPoint.y - self.center.y;
    
    self.xOffset = 0;
    self.yOffset = 0;
}

- (void)setLocation:(CGPoint)touchLocation {
    self.center = CGPointMake(touchLocation.x - self.xOffset, touchLocation.y - self.yOffset);
    
    [self setNeedsDisplay];
}

- (void)resetLocation {
    self.center = self.originalCenter;
}

- (void)setTaken:(BOOL)taken {
    
    if (taken) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.bgColor = [UIColor colorWithRed:1.0 green:1.0 blue:0 alpha:0.5];
            _taken = taken;
            [self setNeedsDisplay];
        });
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.bgColor = [UIColor clearColor];
            _taken = taken;
            [self setNeedsDisplay];
        });
    }
}

- (void)drawRect:(CGRect)rect {
    float lineWidth = self.taken || self.touch ? self.frame.size.width / 16 : self.frame.size.width / 24;
    CGContextRef c = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColor(c, CGColorGetComponents(self.color.CGColor));
    //CGContextSetFillColor(c, CGColorGetComponents(self.bgColor.CGColor));
    CGContextSetLineWidth(c, lineWidth);

    CGRect inset = CGRectInset(rect, lineWidth / 2, lineWidth / 2);

    [self.bgColor setFill];

    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:inset cornerRadius:lineWidth*20];
    [path setLineWidth:lineWidth];

    [path stroke];
    [path closePath];
   
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width/2,self.bounds.size.height/2)];
    label.text = self.t;
    label.textColor = [UIColor redColor];
    [label sizeToFit];
    label.center =CGPointMake(self.bounds.size.width/2,self.bounds.size.height/2);
    [self addSubview:label];

}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    self.beginpoint = [touch locationInView:self];
    [super touchesBegan:touches withEvent:event];
    [self blink];
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint currentLocation = [touch locationInView:self];
    CGRect frame = self.frame;
    frame.origin.x += currentLocation.x - self.beginpoint.x;
    frame.origin.y += currentLocation.y - self.beginpoint.y;
    self.frame = frame;

}

//闪烁效果。
-(void)blink{
    
    [self.layer addAnimation:[self opacityForever_Animation:0.2] forKey:nil];

}

-(CABasicAnimation *)opacityForever_Animation:(float)time

{
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];//必须写opacity才行。
    animation.fromValue = [NSNumber numberWithFloat:1.0f];
    animation.toValue = [NSNumber numberWithFloat:0.0f];//这是透明度。
    animation.autoreverses = YES;
    animation.duration = time;
    animation.repeatCount = 3;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];///没有的话是均匀的动画。
    return animation;
    
}

- (void)Scale {
    
    CGFloat scale = 1.1;
    [UIView animateWithDuration:0.25 animations:^{
        self.layer.transform = CATransform3DMakeScale(scale, scale, 1);
        
        self.layer.backgroundColor =[UIColor darkGrayColor].CGColor ;
        
    }];
}
@end
