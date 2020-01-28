//
//  UIView+DESIGNABLE.m
//  sws
//
//  Created by 李国栋 on 2019/5/28.
//  Copyright © 2019年 李国栋. All rights reserved.
//

#import "UIView+DESIGNABLE.h"

@implementation UIView (DESIGNABLE)


- (void)setMasksToBounds:(BOOL)masksToBounds{
    self.layer.masksToBounds = masksToBounds;
}
- (BOOL)masksToBounds{
    return self.layer.masksToBounds;
}

- (void)setShowShadow:(BOOL)showShadow{
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(5, 5);
    self.layer.shadowRadius = 5;
    self.layer.shadowOpacity = 0.3;
}

- (BOOL)showShadow{
    return self.layer.shadowOpacity==0.3;
}

- (void)setShadowColor:(UIColor *)shadowColor{
    self.layer.shadowColor = shadowColor.CGColor;
}

- (UIColor *)shadowColor{
    return [UIColor colorWithCGColor:self.layer.shadowColor];
}

- (void)setShadowOffset:(CGSize)shadowOffset{
    self.layer.shadowOffset = shadowOffset;
}

- (CGSize)shadowOffset{
    return self.layer.shadowOffset;
}

- (void)setShadowOpacity:(CGFloat)shadowOpacity{
    self.layer.shadowOpacity = shadowOpacity;
}

- (CGFloat)shadowOpacity{
    return self.layer.shadowOpacity;
}

- (void)setShadowRadius:(CGFloat)shadowRadius{
    self.layer.shadowRadius = shadowRadius;
}

- (CGFloat)shadowRadius{
    return self.layer.shadowRadius;
}

- (void)setCornerRadius:(double)cornerRadius{
    self.layer.cornerRadius = cornerRadius;
}

- (double)cornerRadius{
    return  self.layer.cornerRadius;
}
- (void)setBorderWidth:(CGFloat)borderWidth{
    self.layer.borderWidth = borderWidth;
}

- (CGFloat)borderWidth{
    return self.layer.borderWidth;
}

- (void)setBorderColor:(UIColor *)borderColor{
    self.layer.borderColor = borderColor.CGColor;
}

- (UIColor *)borderColor{
    return [UIColor colorWithCGColor:self.layer.borderColor];
}



@end
