//
//  NSString+Extension.m
//  EasyWedding
//
//  Created by wangliang on 16/8/29.
//  Copyright © 2016年 com.jinyouapp. All rights reserved.
//

#import "NSString+Extension.h"



#define IOS9_OR_LATER  ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0)


@implementation NSString (Extension)

+(NSString *)getUTF8strFrom:(NSString *)string{
    if (!IOS9_OR_LATER) {
        return [string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }else{
        return  [string stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];
    }

}




+(NSString *)delLastCharacter:(NSString*)sting{
    return [sting substringWithRange:NSMakeRange(0, [sting length ]- 1)];
}

- (NSString *)getCorrectUrlString{
    NSString * string = [NSString stringWithFormat:@"%@",[self stringByReplacingOccurrencesOfString:@"\\" withString:@"/"]];
    return string;
}




@end
