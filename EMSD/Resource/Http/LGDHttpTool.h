//
//  LGDHttpTool.h
//  EasyWedding
//
//  Created by wangliang on 16/8/23.
//  Copyright © 2016年 com.jinyouapp. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^Block_JSON_Dictionary)(NSDictionary * dictJSON);

@interface LGDHttpTool : NSObject

+(NSURLSessionDataTask *)POST:(NSString *)URLString parameters:(NSDictionary *)parameters  success:(Block_JSON_Dictionary)dictSuccessJSON failure:(void (^)(NSError *error))failure;
+(NSURLSessionDataTask *)Get:(NSString *)URLString parameters:(NSDictionary *)parameters  success:(Block_JSON_Dictionary)dictSuccessJSON failure:(void (^)(NSError *error))failure;


+ (void) POSTImagesWithUrl:(NSString *)url parameters:(NSDictionary *)parameters ImageArray:(NSArray *)ImageArray fileName:(NSString*)fileName success:(Block_JSON_Dictionary)dictSuccessJSON failure:(void (^)(NSError *error))failure;

+(void)WLPOST:(NSString *)URLString parameters:(NSDictionary *)parameters  success:(Block_JSON_Dictionary)dictSuccessJSON failure:(void (^)(NSError *error))failure;

+ (void) POSTImagesWithUrl:(NSString *)url parameters:(NSDictionary *)parameters ImageArray:(NSArray *)ImageArray fileNames:(NSArray*)fileNames success:(Block_JSON_Dictionary)dictSuccessJSON failure:(void (^)(NSError *error))failure;
//检测版本更新
//+(void)onCheckVersionWithAppId:(NSString *)appid WithFindVersionBlock:(TapBlock)block;


//+ (void)requestXianquWithCity:(NSString *)city;

@end
