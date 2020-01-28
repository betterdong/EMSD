//
//  UserDefaultsManager.h
//  EasyWedding
//
//  Created by wangliang on 16/8/25.
//  Copyright © 2016年 com.jinyouapp. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^AccountPasswordAccess_token)(NSString * account,NSString * password,NSString * type);

/**
 *  通过这个key可以获取存储在本地的字符串，以判断是否是第一次运行APP，如果有值，不是第一次运行。
 */
static NSString * const KeyFirstSetUpApp = @"KeyFirstSetUpApp";

static NSString * const keyAccount = @"account";
static NSString * const keyPassword = @"password";
static NSString * const keyType = @"type";
static NSString * const keyLoginParameters = @"keyLogParameters";
static NSString * const keyLoginInfo = @"keyLoginInfo";


@interface UserDefaultsManager : NSObject

/**
 *  登录时，存储 账号、密码、access_token
 *
 *  @param account      账号
 *  @param password     密码
 *  @param access_token access_token
 */
+ (void)saveLogInfoWithAccount:(NSString * )account Password:(NSString * )password Type:(NSString *)type;

/**
 * 能获取到返回 YES
 * 获取 账号、密码、access_token 用以自动登录 void(^AccountPasswordAccess_token)(NSString * account,NSString * password,NSString * access_token)
 */
+ (BOOL)getLogInfo:(AccountPasswordAccess_token)accountPasswordType;

/**
 *  退出登录时，清除 账号、密码、access_token
 *
 *  @param account      账号
 *  @param password     密码
 *  @param access_token access_token
 */
+ (void)clearLogInfo;


/**
 *  UserDefaults 保存自定义对象 key为其class
 *
 *  @param key   字段名
 */
+ (void)saveObject:(id)object;
/**
 *  UserDefaults 获取自定义对象
 *
 *  @param key 字段名
 *
 *  @return value 值
 */
+ ( id )getObject:(id)object ForKey:(NSString *)key;

/**
 *  UserDefaults 保存字典数组等对象
 *
 *  @param key 字段名
 *
 *  @return value 值
 */
+ ( void )saveObject:(id)object ForKey:(NSString *)key;


/**
 *  UserDefaults 保存自定义对象 key为其class
 *
 *  @param key   字段名
 */
+ ( id )getObjectForKey:(NSString *)key;

/**
 *  UserDefaults 保存字符串
 *
 *  @param key   字段名
 *  @param value 值
 */
+ (void)saveStringForKey:(NSString *)key Value:(NSString *)value;


/**
 *  UserDefaults 获取值
 *
 *  @param key 字段名
 *
 *  @return value 值
 */
+ (NSString *)getStringForKey:(NSString *)key;




@end
