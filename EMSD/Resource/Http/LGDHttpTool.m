//
//  LGDHttpTool.m
//  EasyWedding
//
//  Created by wangliang on 16/8/23.
//  Copyright © 2016年 com.jinyouapp. All rights reserved.
//

#import "LGDHttpTool.h"
#import "AFNetworking.h"
//#import "url.h"
//#import "QuxianModel.h"
//#import "MJExtension.h"
@interface LGDHttpTool ()
@property (strong, nonatomic)  AFHTTPSessionManager *manager;
@end

@implementation LGDHttpTool

static AFHTTPSessionManager *manager;

+(AFHTTPSessionManager *)sharedHttpSessionManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [AFHTTPSessionManager manager];
        manager.requestSerializer.timeoutInterval = 10.0;
    });
    
    return manager;
}

+(NSURLSessionDataTask *)POST:(NSString *)URLString parameters:(NSDictionary *)parameters  success:(Block_JSON_Dictionary)dictSuccessJSON failure:(void (^)(NSError *error))failure{
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    AFHTTPSessionManager *manager = [LGDHttpTool sharedHttpSessionManager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    return [manager POST:URLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, NSData * responseObject) {

        NSDictionary * responseJSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];

        if (dictSuccessJSON) {
            dictSuccessJSON(responseJSON);
        }   
        

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
        
    }];

}


+(void)WLPOST:(NSString *)URLString parameters:(NSDictionary *)parameters  success:(Block_JSON_Dictionary)dictSuccessJSON failure:(void (^)(NSError *error))failure{



    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    [manager POST:URLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, NSData * responseObject) {

        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSDictionary * responseJSON = @{@"info":string};

        dictSuccessJSON(responseJSON);

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

        failure(error);
        
        
    }];
}


+(NSURLSessionDataTask *)Get:(NSString *)URLString parameters:(NSDictionary *)parameters  success:(Block_JSON_Dictionary)dictSuccessJSON failure:(void (^)(NSError *error))failure{
    //    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    AFHTTPSessionManager *manager = [LGDHttpTool sharedHttpSessionManager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    return [manager GET:URLString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary * responseJSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        if (dictSuccessJSON) {
            dictSuccessJSON(responseJSON);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
    
}
+ (void) POSTImagesWithUrl:(NSString *)url parameters:(NSDictionary *)parameters ImageArray:(NSArray *)ImageArray fileName:(NSString*)fileName success:(Block_JSON_Dictionary)dictSuccessJSON failure:(void (^)(NSError *error))failure{

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    [manager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {

        for (int i = 0 ; i<ImageArray.count ; i ++) {
            UIImage * image = ImageArray[i];
            NSData * data = nil;
            NSString * strFileType = nil;
            if (UIImagePNGRepresentation(image)) {
                data = UIImagePNGRepresentation(image);
                strFileType = @".png";
            }else{
                data = UIImageJPEGRepresentation(image, 1.0f);
                strFileType = @".jpg";
            }

            if (data) {
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                formatter.dateFormat = @"yyyyMMddHHmmss";
                NSString *str = [formatter stringFromDate:[NSDate date]];
                NSString * filesFileName = [NSString stringWithFormat:@"%d%@%@",i,str,strFileType];
                [formData appendPartWithFileData:data name:fileName fileName:filesFileName mimeType:@"image/png"];
            }
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
//        NSLog(@"%@",uploadProgress);
        dispatch_async(dispatch_get_main_queue(), ^{
//            [MBProgressHUD showError:uploadProgress.localizedDescription];
        });
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        NSDictionary * responseJSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];

        dictSuccessJSON(responseJSON);

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@",error.localizedDescription);
        failure(error);
    }];
    
}

+ (void) POSTImagesWithUrl:(NSString *)url parameters:(NSDictionary *)parameters ImageArray:(NSArray *)ImageArray fileNames:(NSArray*)fileNames success:(Block_JSON_Dictionary)dictSuccessJSON failure:(void (^)(NSError *error))failure{

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];


    [manager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {

        for (int i = 0 ; i<ImageArray.count ; i ++) {
            UIImage * image = ImageArray[i];
            NSData * data = nil;
            NSString * strFileType = nil;
            if (UIImagePNGRepresentation(image)) {
                data = UIImagePNGRepresentation(image);
                strFileType = @".png";
            }else{
                data = UIImageJPEGRepresentation(image, 1.0f);
                strFileType = @".jpg";
            }

            if (data) {
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                formatter.dateFormat = @"yyyyMMddHHmmss";
                NSString *str = [formatter stringFromDate:[NSDate date]];
                NSString * filesFileName = [NSString stringWithFormat:@"%d%@%@",i,str,strFileType];
                NSLog(@"%@",filesFileName);
                [formData appendPartWithFileData:data name:fileNames[i] fileName:filesFileName mimeType:@"image/png"];
            }
        }

    } progress:^(NSProgress * _Nonnull uploadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        NSDictionary * responseJSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];

        dictSuccessJSON(responseJSON);


    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

        failure(error);
    }];

}

//+(void)onCheckVersionWithAppId:(NSString *)appid WithFindVersionBlock:(TapBlock)block
//{
//    NSString * url = [NSString stringWithFormat:@"http://itunes.apple.com/lookup?id=%@",appid];
//
//    [LGDHttpTool POST:url parameters:nil success:^(NSDictionary *resultDic) {
//
//
//        float version =[[[[resultDic objectForKey:@"results"] objectAtIndex:0] valueForKey:@"version"] floatValue];
//        NSDictionary *infoDic=[[NSBundle mainBundle] infoDictionary];
//        float currentVersion = [[infoDic valueForKey:@"CFBundleShortVersionString"] floatValue];
//
//        if (version > currentVersion) {
//            if (block) {
//                block();
//            }
//        }
//
////        if(version>0.9){
////            NSString *alertTitle=[@"发现新版本v" stringByAppendingString:[NSString stringWithFormat:@"%0.1f",version]];
////            NSString *alertMsg=@"是否立即更新？";
////            //NSString *alertMsg  = [[[resultDic objectForKey:@"results"] objectAtIndex:0] valueForKey:@"releaseNotes"]
////            UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:alertTitle message:alertMsg delegate:self cancelButtonTitle:@"稍后" otherButtonTitles:@"立即更新", nil];
////            [alertView show];
////        }
//
//
//        
//    } failure:^(NSError *error) {
//
//    }];
//    
//    
//}



////获取区县
//+ (void)requestXianquWithCity:(NSString *)city{
//    if (!city) {
//        city = @"北京";
//        [InfoManager share].city = city;
//    }
//    NSDictionary * parameters = @{@"city":city};
//    [LGDHttpTool POST:EW_SearchQuxianList_POST_URL parameters:parameters success:^(NSDictionary *dictJSON) {
//        if ([dictJSON[@"status"] integerValue] == 1) {
//            NSArray * array = [self jiexiXianqu:dictJSON[@"data"]];
//            [InfoManager share].arrayOfQuxians = array;
//        }
//    } failure:^(NSError *error) {
//
//    }];
//}
//
//+ (NSArray *)jiexiXianqu:(NSArray *)array{
//    NSMutableArray * muArr = [NSMutableArray array];
//    for (NSDictionary * dict in array) {
//        QuxianModel * model = [QuxianModel mj_objectWithKeyValues:dict];
//        [muArr addObject:model];
//    }
//    return [NSArray arrayWithArray:muArr];
//}

+(void)requestCollectedShops{
//    NSDictionary * parameters = @{@"city":city};


//    [LGDHttpTool POST:EW_SearchQuxianList_POST_URL parameters:parameters success:^(NSDictionary *dictJSON) {
//        if ([dictJSON[@"status"] integerValue] == 1) {
//            NSArray * array = [self jiexiXianqu:dictJSON[@"data"]];
//            [InfoManager share].arrayOfQuxians = array;
//        }
//    } failure:^(NSError *error) {
//
//    }];
}



@end
