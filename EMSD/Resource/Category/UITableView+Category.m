//
//  UITableView+Category.m
//  Freekick
//
//  Created by 李国栋 on 2017/11/26.
//  Copyright © 2017年 李国栋. All rights reserved.
//

#import "UITableView+Category.h"

@implementation UITableView (Category)

- (void)gd_registerNibWithNibName:(NSString *)nibName CellReuseIdentifier:(NSString *)reuseIdentifier{
    [self registerNib:[UINib nibWithNibName:nibName bundle:nil] forCellReuseIdentifier:reuseIdentifier];
}

@end
