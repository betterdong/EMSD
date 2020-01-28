//
//  SYTool.h
//  test
//
//  Created by 栋 on 2018/9/26.
//  Copyright © 2018年 com.pulian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//#import "TaskDetailListModel.h"

static NSString * const FormatterStringyyyy_MM_dd = @"yyyy-MM-dd";
static NSString * const FormatterStringyyyy_MM_dd_HHmmss = @"yyyy-MM-dd HH:mm:ss";
static NSString * const FormatterStringyyyy_MM_dd_HHmm = @"yyyy-MM-dd HH:mm";
static NSString * const FormatterStringyyyyYearMMMonthddDay = @"yyyy年MM月dd日";

//#import "TaskConfigModel.h"

@interface SYTool : NSObject


/**
 获取正确字符串
 
 @return  nil,null 均返回@""
 */
+ (NSString *)getSafeStringWith:(NSString *)string;

/**
 判断字符串是否为空
 @return 返回yes,字符串为空
 */
+(BOOL)isEmptyStr:(NSString *) string;


+(BOOL)isVaildNumberValue:(NSString *) string;

/**
 获取文件 json
 
 @param name 文件名,需要加后缀
 @return 返回 NSArray 或 NSDictionary
 */
+ (nullable id)sy_getFileWithName:(NSString *)name;

/**
 根据path获取文件 json 需要加后缀
 
 @param name 文件名,需要加后缀
 @return 返回 NSArray 或 NSDictionary
 */
+ (nullable id)sy_getFileWithPath:(NSString *)path;

/**
 时间戳转日期
 */
+(NSDate*) dateFromString:(NSString*)dateString WithFormatterString:(NSString*)formatterString;

/**
 日期转字符串
 */
+ (NSString *)stringFromDate:(NSDate *)date WithFormatterString:(NSString*)formatterString;

/**
 时间戳转日期字符串
 */
+ (NSString *)stringFromTimeInterval:(NSTimeInterval)timeInterval WithFormatterString:(NSString*)formatterString;

/**
 时间戳转周几
 */
+ (NSString *)stringWeekDayFromTimeInterval:(NSTimeInterval)timeInterval;


/**
 获取当前时间戳字符串--毫秒

 @return 时间戳字符串
 */
+(NSString *)getCurrentTimeStringMS;

/**
 获取当前时间戳字符串--秒
 
 @return 时间戳字符串
 */
+(NSString *)getCurrentTimeString;

/**
 获取当前网络状态(异步)

 @param block 是否有网络
 */
//+ (void)networkReachability:(void(^)(BOOL reachable))block;

/**
 获取当前网络状态(同步)
 */
+ (BOOL)networkReachable;

/**
 获取当前网络状态(同步)
 */
+ (NSString *)currentReachabilityStatus;


/**
 从OptionSetting.plist中获取配置

 @param key 配置的key
 @return 值,可能是string,dict,array,number等
 */
+(id)getConfigFromOptionSettingWithKey:(NSString *)key;

/**
 从plist中获取dict
 
 @param plistName plist名称
 @return NSMutableDictionary
 */
+(NSMutableDictionary *)getPlistWithName:(NSString *)plistName;

/**
 展示带有确定按钮的提示框

 @param title 提示内容
 */
+(void)showAlertWithTitle:(NSString *)title;

/**
 展示带有确定按钮的提示框

 @param title 提示内容
 @param completion 完成的回调
 */
+(void)showAlertWithTitle:(NSString *)title completion:(void (^ __nullable)(void))completion;

/**
 获取当前展示的VC

 @return 当前VC
 */
+ (UIViewController *)getCurrectDisplayViewController;

/**
 显示帧率,使用此方法需要引入YYFPSLabel
 并且头文件加入
 #define YYFPSLabel
 */
+(void)showFPSlabel;

//+ (void)pushToChatViewControllerWithImUserId:(NSString *)imUserId name:(NSString *)name taskDetailListModel:(TaskDetailListModel *)detailListModel RESR_STATUS:(NSString *)RESR_STATUS;

+ (BOOL)checkIfHasGNQXWith:(NSString *)gnqx;

+ (void)sendMessageFromAnyOneTypeWithMessage:(NSDictionary *)messageDict messagePostType:(int)postType messageSubtype:(short)subtype messageLength:(int)currentTimes fromUserID:(NSString *)fromUserID toUserID:(NSString *)toUserID;


/**
 截取当前视图为图片

 @param view view
 @return 截取当前视图为图片
 */
+ (UIImage *)snapshot:(UIView *)view;

@end
