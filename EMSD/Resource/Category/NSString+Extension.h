//
//  NSString+Extension.h
//  EasyWedding
//
//  Created by wangliang on 16/8/29.
//  Copyright © 2016年 com.jinyouapp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)

/**
 *  将一个字符串进行utf-8编码
 *
 *  @param string 将要进行utf-8编码的字符串
 *
 *  @return 已经完成utf-8编码的字符串
 */
+(NSString *)getUTF8strFrom:(NSString *)string;

+(NSString *)delLastCharacter:(NSString*)sting;

-(NSString *)getCorrectUrlString;

@end
