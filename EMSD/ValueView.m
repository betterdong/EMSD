//
//  ValueView.m
//  EMSD
//
//  Created by 李国栋 on 2019/6/3.
//  Copyright © 2019年 李国栋. All rights reserved.
//

#import "ValueView.h"

@interface ValueView()

@property(strong,nonatomic) UILabel * lblTitle;
@property(strong,nonatomic) UILabel * lblValue;

@end

@implementation ValueView

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
    
}

- (UILabel *)lblTitle{
    if (!_lblTitle) {
        _lblTitle = [UILabel new];
        [self addSubview:_lblTitle];
        [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
//           make.left.mas_equalTo()
        }];
    }
    return _lblTitle;
}















@end
