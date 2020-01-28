//
//  UIImageView+DESIGNABLE.m
//  sws
//
//  Created by 李国栋 on 2019/5/31.
//  Copyright © 2019年 李国栋. All rights reserved.
//

#import "UIImageView+DESIGNABLE.h"
#import <objc/runtime.h>
#import "UIImage+GIF.h"

@implementation UIImageView (DESIGNABLE)

- (void)setGifName:(NSString *)gifName{
    NSString *path = [[NSBundle mainBundle] pathForResource:gifName ofType:@"gif"];
    NSURL *filePath = [NSURL fileURLWithPath:path isDirectory:NO];
    self.image = [UIImage sd_animatedGIFWithData:[NSData dataWithContentsOfURL:filePath]];
}




@end
