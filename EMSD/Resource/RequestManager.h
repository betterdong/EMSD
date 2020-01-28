//
//  RequestManager.h
//  sws
//
//  Created by 李国栋 on 2019/6/1.
//  Copyright © 2019年 李国栋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LGDHttpTool.h"
@interface RequestManager : NSObject

+ (void)getMaleData:(void(^)(NSDictionary *dictJSON))block;
+ (void)getFemaleData:(void(^)(NSDictionary *dictJSON))block;
+ (void)getData:(void(^)(NSDictionary *dictJSON))block;
+ (void)get4BMaleData:(void(^)(NSDictionary *dictJSON))block;
+ (void)get4BFemaleData:(void(^)(NSDictionary *dictJSON))block;


+ (void)get4ATimeFemaleData:(void(^)(NSDictionary *dictJSON))block;
+ (void)get4BTimeFemaleData:(void(^)(NSDictionary *dictJSON))block;
+ (void)get4ATimeMaleData:(void(^)(NSDictionary *dictJSON))block;
+ (void)get4BTimeMaleData:(void(^)(NSDictionary *dictJSON))block;

+ (NSDictionary *)combine:(NSArray *)keysArray data:(NSDictionary *)dataInfo;

@end
