//
//  BatteryView.h
//  EMSD
//
//  Created by 李国栋 on 2019/6/2.
//  Copyright © 2019年 李国栋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BatteryView : UIView
+ (BatteryView *)batteryView;
- (void)setProgress:(CGFloat)progress;
@end
