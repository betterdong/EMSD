//
//  SwsDateLabel.m
//  sws
//
//  Created by 李国栋 on 2019/6/1.
//  Copyright © 2019年 李国栋. All rights reserved.
//

#import "SwsDateLabel.h"
#import "SYTool.h"

@implementation SwsDateLabel

- (void)awakeFromNib{
    [super awakeFromNib];
    [self otherInit];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self otherInit];
    }
    return self;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self otherInit];
    }
    return self;
}


- (void)otherInit{
    [self refresh];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refresh) name:@"NotificationRefreshUI" object:nil];
}

- (void)refresh{
    NSString * currentTime = [SYTool getCurrentTimeString];
    
    self.text = [SYTool stringFromTimeInterval:[currentTime longLongValue] WithFormatterString:FormatterStringyyyy_MM_dd_HHmmss];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}







@end
