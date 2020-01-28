//
//  RequestManager.m
//  sws
//
//  Created by 李国栋 on 2019/6/1.
//  Copyright © 2019年 李国栋. All rights reserved.
//

#import "RequestManager.h"

//#define BaseUrl @"http://146.196.52.122:8090/sws/api"
//#define BaseUrl @"https://booking.emsd.gov.hk/sws/api"
#define BaseUrl @"https://utils.bim.emsd.gov.hk/sws/api/"

#define URL_Male_Data BaseUrl@"/getmaledataipad"
#define URL_Female_Data BaseUrl@"/getfemaledataipad"
#define URL_Data BaseUrl@"/getdata"
#define URL_4BFemale_Data BaseUrl@"/get4bfemaledataipad"
#define URL_4BMale_Data BaseUrl@"/get4bmaledataipad"

#define BaseUrlTime @"http://iothub.softhard.io:3012"

#define URL_4ATimeFemale_Data BaseUrlTime@"/4A/Female"
#define URL_4BTimeFemale_Data BaseUrlTime@"/4B/Female"
#define URL_4ATimeMale_Data BaseUrlTime@"/4A/Male"
#define URL_4BTimeMale_Data BaseUrlTime@"/4B/Male"


@implementation RequestManager


+ (void)getMaleData:(void(^)(NSDictionary *dictJSON))block{
    
    [LGDHttpTool Get:URL_Male_Data parameters:nil success:^(NSDictionary *dictJSON) {
        
        if (block) {
            block(dictJSON);
        }
    } failure:^(NSError *error) {
        if (block) {
            block(nil);
        }
    }];
    
}

+ (void)getFemaleData:(void(^)(NSDictionary *dictJSON))block{
    
    [LGDHttpTool Get:URL_Female_Data parameters:nil success:^(NSDictionary *dictJSON) {
        
        if (block) {
            block(dictJSON);
        }
    } failure:^(NSError *error) {
        if (block) {
            block(nil);
        }
    }];
    
}

+ (void)getData:(void(^)(NSDictionary *dictJSON))block{
    
    [LGDHttpTool Get:URL_Data parameters:nil success:^(NSDictionary *dictJSON) {
        
        if (block) {
            block(dictJSON);
        }
    } failure:^(NSError *error) {
        if (block) {
            block(nil);
        }
    }];
    
}

+ (void)get4BMaleData:(void(^)(NSDictionary *dictJSON))block{
    
    [LGDHttpTool Get:URL_4BMale_Data parameters:nil success:^(NSDictionary *dictJSON) {
        
        if (block) {
            block(dictJSON);
        }
    } failure:^(NSError *error) {
        if (block) {
            block(nil);
        }
    }];
    
}
+ (void)get4BFemaleData:(void(^)(NSDictionary *dictJSON))block{
    
    [LGDHttpTool Get:URL_4BFemale_Data parameters:nil success:^(NSDictionary *dictJSON) {
        
        if (block) {
            block(dictJSON);
        }
    } failure:^(NSError *error) {
        if (block) {
            block(nil);
        }
    }];
    
}

+ (void)get4ATimeFemaleData:(void(^)(NSDictionary *dictJSON))block{
    
    [LGDHttpTool Get:URL_4ATimeFemale_Data parameters:nil success:^(NSDictionary *dictJSON) {
        
        if (block) {
            block(dictJSON);
        }
    } failure:^(NSError *error) {
        if (block) {
            block(nil);
        }
    }];
    
}

+ (void)get4BTimeFemaleData:(void(^)(NSDictionary *dictJSON))block{
    
    [LGDHttpTool Get:URL_4BTimeFemale_Data parameters:nil success:^(NSDictionary *dictJSON) {
        
        if (block) {
            block(dictJSON);
        }
    } failure:^(NSError *error) {
        if (block) {
            block(nil);
        }
    }];
    
}


+ (void)get4ATimeMaleData:(void(^)(NSDictionary *dictJSON))block{
    
    [LGDHttpTool Get:URL_4ATimeMale_Data parameters:nil success:^(NSDictionary *dictJSON) {
        
        if (block) {
            block(dictJSON);
        }
    } failure:^(NSError *error) {
        if (block) {
            block(nil);
        }
    }];
    
}

+ (void)get4BTimeMaleData:(void(^)(NSDictionary *dictJSON))block{
    
    [LGDHttpTool Get:URL_4BTimeMale_Data parameters:nil success:^(NSDictionary *dictJSON) {
        
        if (block) {
            block(dictJSON);
        }
    } failure:^(NSError *error) {
        if (block) {
            block(nil);
        }
    }];
    
}


+ (NSDictionary *)combine:(NSArray *)keysArray data:(NSDictionary *)dataInfo{
    NSMutableDictionary * dicMap = [NSMutableDictionary dictionary];
    NSArray* valueKey = @[@"NH3",@"PM2",@"VOC",@"FME",@"TMP",@"HMY"];
    
    for (NSString * key in keysArray) {
        NSDictionary * odor = dataInfo[key];
        if (!odor && ![odor isKindOfClass:[NSDictionary class]]) {
            continue;
        }
        
        for (int i = 0;i < valueKey.count; i ++) {
            NSString * vkey = valueKey[i];
            
            NSString * vValue = odor[vkey];
            
            if ([vValue isKindOfClass:[NSString class]]) {
                if ([SYTool isEmptyStr:vValue]) {
                    vValue = @"0";
                }
            }else if ([vValue isKindOfClass:[NSNumber class]]){
                vValue = [NSString stringWithFormat:@"%@",vValue];
            }else{
                vValue = @"0";
            }
            
            NSDecimalNumber * decimalNumber = [[NSDecimalNumber alloc] initWithString:vValue];
            NSDecimalNumber * decimalNumberMap = dicMap[vkey];
            //            CGFloat value = vValue.floatValue + dicValue.floatValue;
            //            dicMap[vkey] = [NSString stringWithFormat:@"%0.2f",value];
            if (decimalNumberMap) {
                dicMap[vkey] = [decimalNumber decimalNumberByAdding:decimalNumberMap];
            }else{
                dicMap[vkey] = decimalNumber;
            }
            
            
        }
    }
    
    NSMutableDictionary * desMap = [NSMutableDictionary dictionary];
    for (int i = 0;i < valueKey.count; i ++) {
        NSString * vkey = valueKey[i];
        NSDecimalNumber * decimalNumber = dicMap[vkey];
        NSDecimalNumber * decimalNumberC = [[NSDecimalNumber alloc] initWithString:[NSString stringWithFormat:@"%zd",keysArray.count]];
        
        NSDecimalNumberHandler *handler = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:2 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
        decimalNumber = [decimalNumber decimalNumberByDividingBy:decimalNumberC withBehavior:handler];
        
        desMap[vkey] = decimalNumber.stringValue;
        //        CGFloat desValue = value.floatValue*1.0/keysArray.count;
        //        NSString * strValue = decimalNumber.stringValue;
        //        strValue = desMap[vkey];
    }
    return desMap;
}

@end
