//
//  BatteryView.m
//  EMSD
//
//  Created by 李国栋 on 2019/6/2.
//  Copyright © 2019年 李国栋. All rights reserved.
//

#import "BatteryView.h"

@interface BatteryView()


@property (weak, nonatomic) IBOutlet UIView *pro1;
@property (weak, nonatomic) IBOutlet UIView *pro2;
@property (weak, nonatomic) IBOutlet UIView *pro3;
@property (weak, nonatomic) IBOutlet UIView *pro4;
@property (weak, nonatomic) IBOutlet UIView *pro5;
@property (weak, nonatomic) IBOutlet UIView *pro6;

@end

@implementation BatteryView

- (void)setProgress:(CGFloat)progress{
    
    UIColor * color = nil;
    if (progress>=10) {
        self.pro1.hidden =NO;
        self.pro2.hidden =NO;
        self.pro3.hidden =NO;
        self.pro4.hidden =NO;
        self.pro5.hidden =NO;
        self.pro6.hidden =NO;
        color = [UIColor colorWithHexString:@"E21B1B"];
    }else if (progress<10&& progress>=6) {
        self.pro1.hidden =NO;
        self.pro2.hidden =NO;
        self.pro3.hidden =NO;
        self.pro4.hidden =NO;
        self.pro5.hidden =YES;
        self.pro6.hidden =YES;
        color = [UIColor colorWithHexString:@"FFC000"];
    }else{
        self.pro1.hidden =NO;
        self.pro2.hidden =NO;
        self.pro3.hidden =YES;
        self.pro4.hidden =YES;
        self.pro5.hidden =YES;
        self.pro6.hidden =YES;
        color = [UIColor colorWithHexString:@"94CF52"];
    }
    self.pro1.backgroundColor =color;
    self.pro2.backgroundColor =color;
    self.pro3.backgroundColor =color;
    self.pro4.backgroundColor =color;
    self.pro5.backgroundColor =color;
    self.pro6.backgroundColor =color;
}

+ (BatteryView *)batteryView{
    BatteryView * view = [[[NSBundle mainBundle] loadNibNamed:@"BatteryView" owner:nil options:nil] lastObject];
    return view;

    
}




@end
