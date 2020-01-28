//
//  UserDefaultsManager.m
//  EasyWedding
//
//  Created by wangliang on 16/8/25.
//  Copyright © 2016年 com.jinyouapp. All rights reserved.
//

#import "UserDefaultsManager.h"



@interface UserDefaultsManager ()



@end

@implementation UserDefaultsManager
+ (void)saveObject:(id)object{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];

    NSData * data = [NSKeyedArchiver archivedDataWithRootObject:object];

    [userDefaults setObject:data forKey:NSStringFromClass([object class])];
    //这里建议同步存储到磁盘中，但是不是必须的
    [userDefaults synchronize];
}


+ ( id )getObject:(id)object ForKey:(NSString *)key{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData * data = [userDefaults objectForKey:key];
    if (data == nil) {
        object = [[object alloc]init];
    }else{
        object = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    return object;
}

+ ( void )saveObject:(id)object ForKey:(NSString *)key{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults setObject:object forKey:key];
    [userDefaults synchronize];

}



+ ( id )getObjectForKey:(NSString *)key{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults objectForKey:key];
}


+ (void)saveStringForKey:(NSString *)key Value:(NSString *)value{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];

    [userDefaults setValue:value forKey:key];
    //这里建议同步存储到磁盘中，但是不是必须的
    [userDefaults synchronize];
}


+ (NSString *)getStringForKey:(NSString *)key{
     NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return  [userDefaults stringForKey:key]; ;
}



+ (void)saveLogInfoWithAccount:(NSString * )account Password:(NSString * )password Type:(NSString *)type{
    [UserDefaultsManager saveStringForKey:keyAccount Value:account];
    [UserDefaultsManager saveStringForKey:keyPassword Value:password];
    [UserDefaultsManager saveStringForKey:keyType Value:type];

}

+(BOOL)getLogInfo:(AccountPasswordAccess_token)accountPasswordType{
    NSString * account = [UserDefaultsManager getStringForKey:keyAccount];
    NSString * password = [UserDefaultsManager getStringForKey:keyPassword];
    NSString * type = [UserDefaultsManager getStringForKey:keyType];
    accountPasswordType(account,password,type);
    if (account && password && type) {
        return YES;
    } else {
        return NO;
    }
}

+ (void)clearLogInfo{
    [UserDefaultsManager saveStringForKey:keyAccount Value:nil];
    [UserDefaultsManager saveStringForKey:keyPassword Value:nil];
    [UserDefaultsManager saveStringForKey:keyType Value:nil];
    [UserDefaultsManager saveObject:nil ForKey:keyLoginParameters];
    [UserDefaultsManager saveObject:nil ForKey:keyLoginInfo];
    
}

@end
