//
//  UITextField+Extension.m
//  Freekick
//
//  Created by 李国栋 on 2017/11/14.
//  Copyright © 2017年 李国栋. All rights reserved.
//

#import "UITextField+Extension.h"

@implementation UITextField (Extension)

- (void)setPlaceholderColor:(UIColor *)color{
    [self setValue:color
              forKeyPath:@"_placeholderLabel.textColor"];
}

@end
