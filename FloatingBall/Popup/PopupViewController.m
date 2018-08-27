//
//  PopupViewController.m
//  HSFloatingBallDemo
//
//  Created by Yifan on 2018/8/8.
//  Copyright © 2018年 Yifan. All rights reserved.
//

#import "PopupViewController.h"
#import "UIViewController+CBPopup.h"
#import <HandScapeSDK/HandScapeSDK.h>
#import "TargetView.h"

@interface PopupViewController ()<HSCTouchpadManagerDelegate>
{
    CGRect RectR1;
    CGRect RectR2;
    CGRect RectL1;
    CGRect RectL2;
}
@property (weak, nonatomic) IBOutlet UIButton *setting;
@property (weak, nonatomic) IBOutlet UIButton *save;
@property (weak, nonatomic) IBOutlet UIButton *close;
@property (weak, nonatomic) IBOutlet UIButton *delete;
@property(nonatomic) NSMutableArray *tvs;
@property(strong, nonatomic) NSMutableDictionary *gameData;
@property(strong, nonatomic) NSMutableDictionary *level;

@property(strong, nonatomic) NSArray *ButtonSettings;
@property(nonatomic) NSString* destPath;
@property(nonatomic) NSMutableArray *starts;
@property(nonatomic) float squareSize;
@property(nonatomic) NSMutableDictionary *touchToSquare;
// 是否判断删除操作
@property (nonatomic, assign) BOOL isDecideDelete;
@property (nonatomic) TargetView* targetview;

@end

@implementation PopupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [HSCTouchpadManager sharedManager].delegate = self;
    self.tvs = [[NSMutableArray alloc] init];
    // Do any additional setup after loading the view from its nib.
    self.save.layer.cornerRadius = 4.0;
    self.setting.layer.cornerRadius = 4.0;
    self.close.layer.cornerRadius = 4.0;
    self.delete.layer.cornerRadius = 4.0;
    [self.setting.layer setBorderWidth:1.0]; //边框宽度
    [self.save.layer setBorderWidth:1.0]; //边框宽度
    [self.close.layer setBorderWidth:1.0]; //边框宽度
    [self.delete.layer setBorderWidth:1.0]; //边框宽度

    self.starts = [[NSMutableArray alloc] init];
    self.touchToSquare = [[NSMutableDictionary alloc] init];

    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 1, 0, 0, 1 });
    
    [self.setting.layer setBorderColor:colorref];//边框颜色
    [self.setting addTarget:self action:@selector(MySetting:) forControlEvents:UIControlEventTouchUpInside];//button 点击回调方法
    [self.save.layer setBorderColor:colorref];
    [self.save addTarget:self action:@selector(savesetting:) forControlEvents:UIControlEventTouchUpInside];
    [self.close.layer setBorderColor:colorref];
    [self.close addTarget:self action:@selector(closesetting:) forControlEvents:UIControlEventTouchUpInside];
    [self.delete.layer setBorderColor:colorref];
    [self.delete addTarget:self action:@selector(setIsDecideDelete:) forControlEvents:UIControlEventTouchUpInside];
    self.destPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    self.destPath = [self.destPath stringByAppendingPathComponent:@"gamedata.plist"];
    //If the file doesn't exist in the Documents Folder, copy it.
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //    if ([fileManager fileExistsAtPath:self.destPath]) {
    //        [fileManager removeItemAtPath:self.destPath error:nil];
    //    }
    if (![fileManager fileExistsAtPath:self.destPath]) {
        NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"gamedata" ofType:@"plist"];
        [fileManager copyItemAtPath:sourcePath toPath:self.destPath error:nil];
    }
    NSDictionary *tempData = [NSDictionary dictionaryWithContentsOfFile: self.destPath];
    self.gameData = (NSMutableDictionary *)CFBridgingRelease(CFPropertyListCreateDeepCopy(kCFAllocatorDefault, (CFDictionaryRef)tempData, kCFPropertyListMutableContainers));
//    self.gameData = [NSMutableDictionary dictionaryWithContentsOfFile:self.destPath];
    [self setupdefault];
    
    RectR1 =  CGRectMake(2500, 1700, 1500, 1550);
    RectR2 =  CGRectMake(2500, 200, 1500, 1550);
    RectL1 =  CGRectMake(0, 1750, 1500, 1550);
    RectL2 =  CGRectMake(0, 200, 1500, 1550);

}

-(void)setupdefault
{
    self.squareSize = 45;
    self.currentSetting = 0;
    [self createLevel];

}

- (void)createLevel {
    self.level = [self.gameData objectForKey:@"Settings"];
    self.starts = [self.level objectForKey:@"starts"];
    NSLog(@"%@",self.gameData);//直接打印数据

    NSArray* arraycopy = [self.starts copy];
    
    for (NSDictionary *start in arraycopy) {
        long startX = [[start objectForKey:@"startX"] longValue];
        long startY = [[start objectForKey:@"startY"] longValue];
        NSString *text = [start objectForKey:@"label"];
        NSString *color = [start objectForKey:@"color"];
        UIColor *uicolor;
        NSString *buttonlabel;
        if ([color isEqualToString:@"red"]) {
            uicolor = [UIColor redColor];
        } else {
            uicolor = [UIColor blueColor];
        }
        if ([text isEqualToString:@"R1"]) {
            buttonlabel =  @"R1";
        } else if ([text isEqualToString:@"R2"]) {
            buttonlabel =  @"R2";
        }else if ([text isEqualToString:@"L1"]) {
            buttonlabel =  @"L1";
        }else if ([text isEqualToString:@"L2"]) {
            buttonlabel =  @"L2";
        }
        
        
        [self addStartSquare:CGPointMake(startX, startY) color:uicolor text: buttonlabel];
    }
    
}


- (void)addStartSquare:(CGPoint)pos color:(UIColor*)color text:(NSString*)buttonlabel {
    self.targetview = [[TargetView alloc] initWithFrame:CGRectMake(pos.x, pos.y, self.squareSize, self.squareSize) color:color text:buttonlabel];
    self.targetview.center = pos;
    self.targetview.originalCenter = pos;
//    [self.starts addObject:t];
    [self.view addSubview:self.targetview];
    [self.tvs addObject:self.targetview];
    NSLog(@"tv is %@",self.targetview.t);


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)MySetting:(id)sender
{
    //READ DATA
    self.destPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    self.destPath = [self.destPath stringByAppendingPathComponent:@"gamedata.plist"];

    // If the file doesn't exist in the Documents Folder, copy it.
    NSFileManager *fileManager = [NSFileManager defaultManager];

    if (![fileManager fileExistsAtPath:self.destPath]) {
        NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"gamedata" ofType:@"plist"];
        [fileManager copyItemAtPath:sourcePath toPath:self.destPath error:nil];
    }
    self.gameData = [NSMutableDictionary dictionaryWithContentsOfFile: self.destPath];
    self.ButtonSettings = [self.gameData objectForKey:@"settings"];
    NSLog(@"%@",self.ButtonSettings);//直接打印数据

//    [self getDataFromPlist];

    
}

- (void)getDataFromPlist{
    NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"gamedata" ofType:@"plist"];
    NSMutableDictionary *dataDic = [[NSMutableDictionary alloc]initWithContentsOfFile:plistPath];
    NSLog(@"%@",dataDic);//直接打印数据
}

-(void)savesetting:(id)sender
{
    NSString *destPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    destPath = [destPath stringByAppendingPathComponent:@"gamedata.plist"];

//    NSDictionary *tempData = [NSDictionary dictionaryWithContentsOfFile: destPath];
//    NSMutableDictionary *gameData = (NSMutableDictionary *)CFBridgingRelease(CFPropertyListCreateDeepCopy(kCFAllocatorDefault, (CFDictionaryRef)tempData, kCFPropertyListMutableContainers));
//    self.gameData = [[NSMutableDictionary alloc]initWithContentsOfFile:destPath];
    self.gameData = [NSMutableDictionary dictionaryWithContentsOfFile: self.destPath];
//    NSMutableArray *Settings = [self.gameData objectForKey:@"Settings"];
    self.level = [self.gameData objectForKey:@"Settings"];

//    NSMutableDictionary *newSetting = [[NSMutableDictionary alloc] init];
    [self.starts removeAllObjects];
    for (_targetview in self.tvs) {
        NSMutableDictionary *vd = [[NSMutableDictionary alloc] init];
//        NSString *text = [start objectForKey:@"label"];
        if ([_targetview.t isEqualToString:@"R1"]) {
            [vd setObject:@"R1" forKey:@"label"];
            
        } else if ([_targetview.t isEqualToString:@"R2"]) {
             [vd setObject:@"R2" forKey:@"label"];
        }else if ([_targetview.t isEqualToString:@"L1"]) {
            [vd setObject:@"L1" forKey:@"label"];
        }else if ([_targetview.t isEqualToString:@"L2"]) {
            [vd setObject:@"L2" forKey:@"label"];
        }
        [vd setObject:@"red" forKey:@"color"];
        [vd setObject:[NSNumber numberWithFloat:_targetview.center.x] forKey:@"startX"];
        [vd setObject:[NSNumber numberWithFloat:_targetview.center.y] forKey:@"startY"];
        [self.starts addObject:vd];
        NSLog(@"starts are %@",self.starts);
    }
    
    [self.level setObject:self.starts forKey:@"starts"];
//    [Settings addObject:newSetting];
    [self.gameData setObject:self.level forKey:@"Settings"];
    [self.gameData writeToFile:destPath atomically:YES];
    [(UIButton*)sender setBackgroundColor:[UIColor greenColor]];


}

-(void)closesetting:(id)sender
{
    [self cb_dismissPopupViewControllerAnimated:YES completion:nil];
}

- (void)setIsDecideDelete:(BOOL)isDecideDelete {
    _isDecideDelete = isDecideDelete;
    
}

- (void)setTouchPoint:(CGPoint)touchPoint {
    if (self.ViewControllerBlock) {
        self.ViewControllerBlock(touchPoint);
        NSLog(@"touchpoint is %@",NSStringFromCGPoint(touchPoint));
    }
    CGRect deletebutton = self.delete.frame;

//    // 判定区域之外
//    if (CGRectContainsPoint(deletebutton, touchPoint)) {
//        self.isTouch = YES;
//    } else {
//        self.isTouch = NO;
//    }
}
//
//- (void)setIsTouch:(BOOL)isTouch {
//
//    if (_isTouch == isTouch) return;
//    _isTouch = isTouch;
//    
//    CGFloat scale = isTouch ? 1.1 : 1.0;
//    [UIView animateWithDuration:0.25 animations:^{
//        self.delete.layer.transform = CATransform3DMakeScale(scale, scale, 1);
//        if (!self.isDecideDelete) {
//            self.delete.layer.backgroundColor = isTouch ? [UIColor darkGrayColor].CGColor : [UIColor clearColor].CGColor;
//        }
//    }];
//}

//- (TargetView *)startSquareAt:(CGPoint)point {
//
//    for (TargetView *tv in self.starts) {
//        CGPoint min = [self.view convertPoint:CGPointMake(0, 0) fromView:tv];
//        int minX = min.x;
//        int minY = min.y;
//        int maxX = min.x + tv.frame.size.width;
//        int maxY = min.y + tv.frame.size.height;
//
//        if (point.x >= minX && point.x <= maxX && point.y >= minY && point.y <= maxY) {
//            return tv;
//        }
//    }
//
//    return nil;
//}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.delete setBackgroundColor:[UIColor whiteColor]];
    
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint currentLocation = [touch locationInView:self.view];
    NSLog(@"%@",NSStringFromCGPoint(currentLocation));
    CGRect deletebutton = self.delete.frame;
    NSMutableArray* arraycopy = [self.tvs copy];
    for (_targetview in arraycopy) {
        NSLog(@"text are %@",self.targetview.t);
        CGPoint targetviewcenter = self.targetview.center;

        if ([_targetview.t isEqualToString:@"R1"]&& CGRectContainsPoint(deletebutton, targetviewcenter)) {
            [self.targetview removeFromSuperview];
            [self.tvs removeObjectAtIndex:0];
        }
        else if ([_targetview.t isEqualToString:@"R2"]&& CGRectContainsPoint(deletebutton, targetviewcenter)) {
            [self.targetview removeFromSuperview];
            [self.tvs removeObjectAtIndex:1];
        }
        else if ([_targetview.t isEqualToString:@"L1"]&& CGRectContainsPoint(deletebutton, targetviewcenter)) {
            [self.targetview removeFromSuperview];
            [self.tvs removeObjectAtIndex:2];

        }
        else if ([_targetview.t isEqualToString:@"L2"] && CGRectContainsPoint(deletebutton, targetviewcenter)) {
            [self.targetview removeFromSuperview];
            [self.tvs removeObjectAtIndex:3];
        }
    }
    [self.delete setBackgroundColor:[UIColor clearColor]];
    
}
// TODO Should have adding targetview when click on HStouch later

//HANDLE TOUCHES

#pragma HandScapeTouch
-(void)touchpadTouchReceived:(HSCTouch *)touch
{

//    NSLog(@"beganpoint is %f %f, rawpoint is %f %f",touch.beganPoint.x,touch.beganPoint.y,touch.rawPoint.x, touch.rawPoint.y);
    if (touch.state == hscTouchStateBegan) {
        NSArray* arraycopy = [self.tvs copy];
        for (_targetview in arraycopy) {
            NSLog(@"tv is %@",_targetview.t);
            if ([_targetview.t isEqualToString:@"R1"]&& CGRectContainsPoint(RectR1, touch.rawPoint)) {
                [self.targetview blink];
            }
            else if ([_targetview.t isEqualToString:@"R2"]&& CGRectContainsPoint(RectR2, touch.rawPoint)) {
                [self.targetview blink];
            }
            else if ([_targetview.t isEqualToString:@"L1"]&& CGRectContainsPoint(RectL1, touch.rawPoint)) {
                [self.targetview blink];
            }
            else if ([_targetview.t isEqualToString:@"L2"] && CGRectContainsPoint(RectL2, touch.rawPoint)) {
                NSLog(@"text are %@",self.targetview.t);
                [self.targetview blink];
            }
        }
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
