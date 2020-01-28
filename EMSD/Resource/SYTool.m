//
//  SYTool.m
//  test
//
//  Created by 栋 on 2018/9/26.
//  Copyright © 2018年 com.pulian. All rights reserved.
//

#import "SYTool.h"

#import "AFNetworking.h"


@implementation SYTool


+ (NSString *)getSafeStringWith:(NSString *)string{
    if (!string) {
        return @"";
    }
    if ([string isEqual:nil]) {
        return @"";
    }
    if ([string isEqual:@""]) {
        return @"";
    }
    if ([string isEqual:@"(null)"]) {
        return @"";
    }
    id tempStr=string;
    if (tempStr==[NSNull null]) {
        return @"";
    }
    if ([tempStr isKindOfClass:[NSNumber class]]) {
        return [NSString stringWithFormat:@"%@",string];
    }
    return string;
}

+(BOOL)isVaildNumberValue:(NSString *) string
{
    if (![self isEmptyStr:string]) {
        return YES;
    }else if([string isKindOfClass:[NSNumber class]]){
        return YES;
    }
    
    return NO;
}

+(BOOL)isEmptyStr:(NSString *) string
{
    if (!string) {
        return YES;
    }
    if ([string isEqual:nil]) {
        return YES;
    }
    if ([string isEqual:@""]) {
        return YES;
    }
    if ([string isEqual:@"(null)"]) {
        return YES;
    }
    id tempStr=string;
    if (tempStr==[NSNull null]) {
        return YES;
    }
    
    return NO;
}

+ (nullable id)sy_getFileWithName:(NSString *)name
{
    NSString * childVCsJsonPath = [[NSBundle mainBundle] pathForResource:name ofType:nil];
    //    NSData *childVCsJSONData = [NSData dataWithContentsOfFile:childVCsJsonPath];
    //    if (!childVCsJSONData) {
    //        return nil;
    //    }
    //    id childVCsDict = [NSJSONSerialization JSONObjectWithData:childVCsJSONData options:NSJSONReadingAllowFragments error:nil];
    return [self sy_getFileWithPath:childVCsJsonPath];
}

+ (nullable id)sy_getFileWithPath:(NSString *)path
{
    NSData *childVCsJSONData = [NSData dataWithContentsOfFile:path];
    if (!childVCsJSONData) {
        return nil;
    }
    id childVCsDict = [NSJSONSerialization JSONObjectWithData:childVCsJSONData options:NSJSONReadingAllowFragments error:nil];
    return childVCsDict;
}

+(NSDate*)dateFromString:(NSString*)dateString WithFormatterString:(NSString*)formatterString
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:formatterString];
    [formatter setTimeZone:[self getSYTimeZone]];
    NSDate *date=[formatter dateFromString:dateString];
    return date;
}

+ (NSString *)stringFromDate:(NSDate *)date WithFormatterString:(NSString*)formatterString{
    
    
    
    NSDateFormatter *dateFormatter = [self getFormatterWithFormatString:formatterString];
    //    NSString * localStr = [NSBundle getCusLanguage];
    //    if (localStr) {
    //        if ([localStr containsString:@"zh"]) {
    //            [dateFormatter setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh-Hant"]];
    //        }else{
    //            [dateFormatter setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"en_us"]];
    //        }
    //    }
    
    NSString *destDateString = [dateFormatter stringFromDate:date];
    
    return destDateString;
    
}


+ (NSString *)stringFromTimeInterval:(NSTimeInterval)timeInterval WithFormatterString:(NSString*)formatterString{
//    NSTimeInterval time = timeInterval / 1000.0;
    NSTimeInterval time = 0;
    if (timeInterval>pow(10, 12)) {
        time = timeInterval / 1000.0;
    }else{
        time = timeInterval;
    }
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:time];
    return [self stringFromDate:confromTimesp WithFormatterString:formatterString];
}

+ (NSString *)stringWeekDayFromTimeInterval:(NSTimeInterval)timeInterval
{
    if (timeInterval > pow(10, 11)) {
//        是13位的毫秒
        timeInterval=timeInterval/1000.0;
    }
    
    NSDate *date=[NSDate dateWithTimeIntervalSince1970:timeInterval];

    NSCalendar *gregorian = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *weekdayComponents =
    [gregorian components:NSCalendarUnitWeekday fromDate:date];
    NSInteger _weekday = [weekdayComponents weekday];
    NSString *weekStr;
    if (_weekday == 1) {
        weekStr = @"星期日";
    }else if (_weekday == 2){
        weekStr = @"星期一";
    }else if (_weekday == 3){
        weekStr = @"星期二";
    }else if (_weekday == 4){
        weekStr = @"星期三";
    }else if (_weekday == 5){
        weekStr = @"星期四";
    }else if (_weekday == 6){
        weekStr = @"星期五";
    }else if (_weekday == 7){
        weekStr = @"星期六";
    }
    return weekStr;
}

+(NSDateFormatter *)getFormatterWithFormatString:(NSString *)formatterString{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:formatterString];
    
    [dateFormatter setTimeZone:[self getSYTimeZone]];
    return dateFormatter;
}

+(NSString *)getCurrentTimeStringMS{
    double current = [[NSDate date] timeIntervalSince1970];
    NSString * currentStr = [NSString stringWithFormat:@"%lf",current * 1000];
    if (currentStr && currentStr.length >=13) {
        currentStr = [currentStr substringToIndex:13];
    }
    return currentStr;
}

+(NSString *)getCurrentTimeString{
    double current = [[NSDate date] timeIntervalSince1970];
    NSString * currentStr = [NSString stringWithFormat:@"%lf",current ];
    if (currentStr && currentStr.length >=10) {
        currentStr = [currentStr substringToIndex:10];
    }
    return currentStr;
}

+(NSTimeZone *)getSYTimeZone{
    return [NSTimeZone systemTimeZone];
}

+(NSString * )taskConfigResorcePath{
//    NSString *xmlFilePath = [[NSBundle mainBundle]pathForResource:@"Tab_Menu"ofType:@"xml"];
    NSString * xmlPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
//    xmlSavePath = [xmlSavePath stringByAppendingPathComponent:@"11.11.48.158081OSPServerZSYGXOSPMobile/Package/Tab_Menu.xml"];
    NSString * ip = [self getConfigFromOptionSettingWithKey:@"ip"];
    NSString * port = [self getConfigFromOptionSettingWithKey:@"port"];
    NSString * server = [self getConfigFromOptionSettingWithKey:@"server"];
    NSString * APPID = [self getConfigFromOptionSettingWithKey:@"APPID"];
    xmlPath = [xmlPath stringByAppendingFormat:@"/%@%@%@%@/Package/Mobile_FMT.xml",ip,port,server,APPID];
//    xmlPath = [[NSBundle mainBundle] pathForResource:@"Demo2.xml" ofType:nil];
    return xmlPath;
}

+(NSString * )taskPackageResorcePathWithName:(NSString *)fileName{
    
    NSString * xmlPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    
    NSString * ip = [self getConfigFromOptionSettingWithKey:@"ip"];
    NSString * port = [self getConfigFromOptionSettingWithKey:@"port"];
    NSString * server = [self getConfigFromOptionSettingWithKey:@"server"];
    NSString * APPID = [self getConfigFromOptionSettingWithKey:@"APPID"];
    xmlPath = [xmlPath stringByAppendingFormat:@"/%@%@%@%@/Package/%@.xml",ip,port,server,APPID,fileName];
    //    xmlPath = [[NSBundle mainBundle] pathForResource:@"Demo2.xml" ofType:nil];
    return xmlPath;
}

//+ (BOOL)networkReachable{
//    Reachability *reach = [Reachability reachabilityWithHostName:@"www.google.com"];
//
//    NetworkStatus status = [reach currentReachabilityStatus];
//
//    return status != NotReachable;
//}
//+ (NSString *)currentReachabilityStatus{
//    Reachability *reach = [Reachability reachabilityWithHostName:@"www.google.com"];
//
//    NetworkStatus status = [reach currentReachabilityStatus];
//    if (status == NotReachable) {
//        NSLog(@"NO_NETWORK");
//        return @"NO_NETWORK";
//    } else if (status == ReachableViaWiFi) {
//        NSLog(@"WIFI");
//        return @"WIFI";
//    } else if (status == ReachableViaWWAN) {
//        NSLog(@"4G");
//        return @"4G";
//    }
//    return @"UnKnown";
//}

+(id)getConfigFromOptionSettingWithKey:(NSString *)key{
//    NSString *optionPath = [[NSBundle mainBundle] pathForResource:@"OptionSetting.plist" ofType:nil];
//    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithContentsOfFile:optionPath];
    NSDictionary *dic = [self getPlistWithName:@"OptionSetting"];
//    NSDictionary *dic = [self optionPlistValue];
    NSString *restfulInterface = [dic objectForKey:key];
    return restfulInterface;
}

+(NSMutableDictionary*)getPlistWithName:(NSString *)plistName{
    NSString *optionPath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@.plist",plistName] ofType:nil];
    return [NSMutableDictionary dictionaryWithContentsOfFile:optionPath];
}

+(void)showAlertWithTitle:(NSString *)title{
    [self showAlertWithTitle:title completion:nil];
}

+(void)showAlertWithTitle:(NSString *)title completion:(void (^ __nullable)(void))completion{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:nil message:title preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * action = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (completion) {
            completion();
        }
    }];
    [alert addAction:action];
    [[self getCurrectDisplayViewController] presentViewController:alert animated:YES completion:nil];
}

+ (UIViewController *)getCurrectDisplayViewController {
    UIViewController *resultVC;
    resultVC = [self loopGetCurrentVC:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [self loopGetCurrentVC:resultVC.presentedViewController];
    }
    return resultVC;
}

+ (UIViewController *)loopGetCurrentVC:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self loopGetCurrentVC:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self loopGetCurrentVC:[(UITabBarController *)vc selectedViewController]];
    }else {
        return vc;
    }
    return nil;
}



+(void)showFPSlabel{
    
#if __has_include("YYFPSLabel.h")
    YYFPSLabel *_fpsLabel = [YYFPSLabel new];
    _fpsLabel.frame = CGRectMake(200, 200, 50, 30);
    [_fpsLabel sizeToFit];
    [[UIApplication sharedApplication].delegate.window addSubview:_fpsLabel];
#endif
}

//+ (void)pushToChatViewControllerWithImUserId:(NSString *)imUserId name:(NSString *)name taskDetailListModel:(TaskDetailListModel *)detailListModel RESR_STATUS:(NSString *)RESR_STATUS{
//#if __has_include("EFPersonChatViewController.h")
//    if ([SYTool isEmptyStr:imUserId]) {
//        [SYAlertView showErrorMessage:@"获取对方聊天信息失败"];
//        return;
//    }
//    if ([imUserId isEqualToString:[EnvironmentVariable getIMUserID]] || [imUserId isEqualToString:[EnvironmentVariable getUserID]]) {
//        [SYAlertView showErrorMessage:@"不能与自己聊天"];
//        return;
//    }
//    if (IsDebugBundle) {
//        [self defaultSendTaskMessageWith:detailListModel viewName:RESR_STATUS toUserId:imUserId];
//    }
//    
//    EFPersonChatViewController *efChatViewController = [[EFPersonChatViewController alloc] initWithUserID:imUserId.intValue];
//    efChatViewController.nickName = name;
//    efChatViewController.chatType = PersonType;
//    
//    // 聊天界面头像的形状
//    NSString *shape = [EnvironmentVariable getPropertyForKey:@"shape" WithDefaultValue:@""];
//    Byte cellHeaderImageViewShape;
//    if ([shape isEqualToString:@"Circle"]) {
//        cellHeaderImageViewShape = HeaderImageViewShapeCircle;
//    } else if ([shape isEqualToString:@"Square"]) {
//        cellHeaderImageViewShape = HeaderImageViewShapeSquare;
//    } else {
//        cellHeaderImageViewShape = HeaderImageViewShapeSquare;
//    }
//    efChatViewController.cellHeaderImageViewShape = cellHeaderImageViewShape;
//    //传递参数
//    [ViewControllerManager pushViewController:efChatViewController animated:YES];
//#else
//    [SYAlertView showErrorMessage:@"未导入聊天组件"];
//#endif
//}
//
//+ (void)defaultSendTaskMessageWith:(TaskDetailListModel *)model viewName:(NSString *)viewName toUserId:(NSString *)toUserId{
////    NSString * viewName ;
////    TaskDetailListModel * model;
//    NSMutableDictionary * param = [NSMutableDictionary dictionary];
//    param[@"TaskData"] = model.TaskData.toDictionary;
//    if ([viewName isEqualToString:@"pending"]) {
//        param[@"OP_TYPE"] = @"pending";
//        param[@"state"] = @"新的待办";
//    }else if ([viewName isEqualToString:@"processed"]) {
//        param[@"OP_TYPE"] = @"processed";
//        param[@"state"] = @"已办待办";
//    }
//    param[@"image"] = [self renderIconWith:model.TaskData.FLOW_ID];
//    param[@"smallIcon"] =  [self renderIconWith:model.TaskData.FLOW_ID];
//    param[@"systemName"] = @"任务中心";
//    param[@"stateColor"] = @"yellow";
//    param[@"show"] = @"TaskDetailFCViewController";
//    param[@"viewType"] = @"display";
//    param[@"time"] = [SYTool stringFromDate:[NSDate date] WithFormatterString:FormatterStringyyyy_MM_dd_HHmmss];
//    param[@"nowTime"] = [SYTool getCurrentTimeString]; //iOS用的时间戳
//    param[@"title"] = model.TaskData.FLOW_NAME;
//    param[@"AndroidShow"] = @"com.efounder.RNTaskDetailActivity";
//    param[@"subtitle"] = model.TaskData.BIZ_DJBH;
//    param[@"toUserID"] = toUserId;
//    param[@"currentID"] = [EnvironmentVariable getIMUserID];
//    param[@"subType"] = @(81);
//    param[@"postType"] = @(0);
//    
//    NSString *jsonStr=[SYNetwork convertToJsonData:param];
//    jsonStr = [jsonStr stringByReplacingOccurrencesOfString:@" " withString:@""];
////    [SYTool sendMessageFromAnyOneTypeWithMessage:jsonStr messagePostType:0 messageSubtype:81 messageLength:nil];
//    [SYTool sendMessageFromAnyOneTypeWithMessage:jsonStr messagePostType:0 messageSubtype:81 messageLength:0];
//}
//
//#pragma mark - 拼接消息，发送消息
//+ (void)sendMessageFromAnyOneTypeWithMessage:(NSString *)message messagePostType:(int)postType messageSubtype:(short)subtype messageLength:(int)currentTimes {
//#if __has_include("JFMessageManager.h")
//
//   JFMessageManager * _messageManager = [JFMessageManager sharedMessageManager];
//    NSData *jsonData = [message dataUsingEncoding:NSUTF8StringEncoding];
//    NSError *err;
//    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
//                                                        options:NSJSONReadingMutableContainers
//                                                          error:&err];
//    IMStructMessage * sendMessage = [[IMStructMessage alloc] init];
//    if(![dic objectForKey:@"currentID"]){
//        NSLog(@"-- 获取不到fromUserID");
//        return;
//    }else if (![dic objectForKey:@"toUserID"]){
//        NSLog(@"-- 获取不到toUserID");
//        return;
//    }
//    sendMessage.fromUserID = [[dic objectForKey:@"currentID"] intValue]; // 发送者
//    sendMessage.toUserID = [[dic objectForKey:@"toUserID"] intValue]; // 接收者
//    NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
//    long long dTime = [[NSNumber numberWithDouble:time] longLongValue];
//    sendMessage.time = dTime; // 消息时间
//    int i = arc4random() % 5;
//    sendMessage.messageID = i; // 消息ID
//    sendMessage.postType = postType; // 消息投递分类   0:个人到个人  1:个人到群组
//    sendMessage.subtype = subtype; // 消息子类型     0:文本  1:图片  2:音频  3:视频  99:用户自定义
//    sendMessage.message = message; // 消息体
//    if (currentTimes) {
//        sendMessage.messageLength = currentTimes;
//    }
//    [_messageManager sendMessage:sendMessage];
//#endif
//}
//
//
//+(NSString *)renderIconWith:(NSString *)FLOW_ID{
//    
//    if ([FLOW_ID isEqualToString:@"HR_ZPJH_LC"]) {
//        return @"http://panserver.solarsource.cn:9692/panserver/files/779cee81-5907-411c-9077-61f051875e8b/download";
//    }else if ([FLOW_ID isEqualToString:@"HR_MSKH_LC"]) {
//        return @"http://panserver.solarsource.cn:9692/panserver/files/5ed65ba8-b8f2-4ba3-acb1-a22dcb16b66a/download";
//    }else if ([FLOW_ID isEqualToString:@"HR_FLOW_SYSQ"]) {
//        return @"http://panserver.solarsource.cn:9692/panserver/files/3a410d45-76d8-4097-9bfa-f649dd7de3a5/download";
//    }else if ([FLOW_ID isEqualToString:@"QJSQLC"]) {
//        return @"http://panserver.solarsource.cn:9692/panserver/files/27bab4d9-cae7-46f5-894a-6f41fc2ac4c3/download";
//    }else if ([FLOW_ID isEqualToString:@"HR_FLOW_JBSQ"]) {
//        return @"http://panserver.solarsource.cn:9692/panserver/files/329f7221-0f52-4c74-bbc7-8163eb0d028b/download";
//    }else if ([FLOW_ID isEqualToString:@"HR_LDHTSQ_LC"]) {
//        return @"http://panserver.solarsource.cn:9692/panserver/files/8cba8bee-7d9d-4ff3-a886-bc0e40d9775d/download";
//    }else if ([FLOW_ID isEqualToString:@"HT_QTHTLC"]) {
//        return @"http://panserver.solarsource.cn:9692/panserver/files/999cf3fc-6319-4ef5-9f2a-c4b98f903e70/download";
//    }else if ([FLOW_ID isEqualToString:@"HT_SCBLC"]) {
//        return @"http://panserver.solarsource.cn:9692/panserver/files/7a2bb9df-dbd3-46d8-a7a0-a30db9532543/download";
//    }else if ([FLOW_ID isEqualToString:@"HT_YYBFZLC"]) {
//        return @"http://panserver.solarsource.cn:9692/panserver/files/8797a915-b6aa-4aff-83bf-6cf14a763d45/download";
//    }else if ([FLOW_ID isEqualToString:@"HT_CGHTSQKJ"]) {
//        return @"http://panserver.solarsource.cn:9692/panserver/files/cff51ea7-b15d-4b67-905c-2749295bd4cc/download";
//    }else if ([FLOW_ID isEqualToString:@"HT_XMSQ"]) {
//        return @"http://panserver.solarsource.cn:9692/panserver/files/a4311ad6-f7e2-4a4d-b825-070496783654/download";
//    }else if ([FLOW_ID isEqualToString:@"HT_HGBLC"]) {
//        return @"http://panserver.solarsource.cn:9692/panserver/files/c29a0c5c-83ce-406c-8633-244d4aba0960/download";
//    }
//    return @"http://11.11.48.15:8081/panserver/files/7b9c3bd2-b4f8-40e8-ab8d-eb49ed9ccbe3/download";
//}



//截取当前视图为图片
+ (UIImage *)snapshot:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, YES, 0);
    [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:YES];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


@end
