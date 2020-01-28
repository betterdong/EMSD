//
//  DetailViewController.m
//  EMSD
//
//  Created by 李国栋 on 2019/6/2.
//  Copyright © 2019年 李国栋. All rights reserved.
//

#import "DetailViewController.h"
#import "BatteryView.h"
#import <AVFoundation/AVFoundation.h>

@interface DetailViewController ()
@property(strong,nonatomic) AVPlayer *player;
@property (weak, nonatomic) IBOutlet UIView *viewContentBattery;
@property (weak, nonatomic) IBOutlet UIImageView *imgViewNDBg;

@property (weak, nonatomic) IBOutlet UIImageView *imgViewMTBg;
@property (weak, nonatomic) IBOutlet UIImageView *imgViewMenBg;
@property (weak, nonatomic) IBOutlet UIImageView *imgViewBG;
@property (weak, nonatomic) IBOutlet UIImageView *imgViewSex;

@property (weak, nonatomic) IBOutlet UILabel *lblH2sValue;
@property (weak, nonatomic) IBOutlet UILabel *lblPM2Value;
@property (weak, nonatomic) IBOutlet UILabel *lblNh3Value;
@property (weak, nonatomic) IBOutlet UILabel *lblVocValue;
@property (weak, nonatomic) IBOutlet UILabel *lblTempValue;
@property (weak, nonatomic) IBOutlet UILabel *lblHumidity;

@property (weak, nonatomic) IBOutlet UILabel *lblPM2Title;
@property (weak, nonatomic) IBOutlet UILabel *lblCountA;
@property (weak, nonatomic) IBOutlet UILabel *lblCountB;

@property (copy, nonatomic) NSDictionary *data;
@property (weak, nonatomic) IBOutlet UIView *viewH2s;
@property (weak, nonatomic) IBOutlet UIView *viewPm;
@property (weak, nonatomic) IBOutlet UIView *viewNh3;
@property (weak, nonatomic) IBOutlet UIView *viewVoc;
@property (weak, nonatomic) IBOutlet UIView *viewHcho;
@property (weak, nonatomic) IBOutlet UILabel *lblHcho;

@property(strong,nonatomic)BatteryView * batteryView;
//@property(nonatomic,copy)NSDictionary * queueData;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.lblTitle.text = self.title;
    [self SetupVideoPlayer];
    // Do any additional setup after loading the view from its nib.
    BatteryView * batteryView = [BatteryView batteryView];
    _batteryView = batteryView;
    [self.viewContentBattery addSubview:batteryView];
    [batteryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-19);
    }];
    
    NSMutableAttributedString * attPM2 = [[NSMutableAttributedString alloc] initWithString:@"PM2.5"];
    [attPM2 setAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"SegoeUI-Light" size:17]} range:NSMakeRange(0, 2)];
    [attPM2 setAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"SegoeUI-Light" size:26]} range:NSMakeRange(2, 3)];
    self.lblPM2Title.attributedText = attPM2;
    [self refreshData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshUI:) name:@"NotificationRefreshUI" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willEnterForegroun) name:UIApplicationWillEnterForegroundNotification object:nil];
}

- (void)willEnterForegroun
{
//    [self.player play];
}

- (void)SetupVideoPlayer
{
    // 加载本地音乐
    //    NSURL *movieUrl = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"蓝莲花" ofType:@"mp3"]];
    
    // 加载本地视频
    NSURL *movieUrl = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"LogIn" ofType:@"mp4"]];
    
    // 加载网络视频
    //    NSURL *movieUrl = [NSURL URLWithString:@"http://w2.dwstatic.com/1/5/1525/127352-100-1434554639.mp4"];
    
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:movieUrl];
    
    
    // 创建 AVPlayer 播放器
    AVPlayer *player = [AVPlayer playerWithPlayerItem:playerItem];
    _player = player;
    
    // 将 AVPlayer 添加到 AVPlayerLayer 上
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
    // 设置播放页面大小
    playerLayer.frame = [UIScreen mainScreen].bounds;
    
    
    // 设置画面缩放模式
    //    playerLayer.videoGravity = AVLayerVideoGravityResize;
    
    // 在视图上添加播放器
    //    [self.view.layer addSublayer:playerLayer];
    [self.view.layer insertSublayer:playerLayer atIndex:1];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayDidEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:self.player.currentItem];
    
    
    //    // 设置音量
    //    /*
    //     范围 0 - 1，默认为 1
    //     */
    player.volume = 0;
    
    // 开始播放
    [player play];
    
    //    player.videoBounds;
}

- (void)moviePlayDidEnd:(NSNotification*)notification{
    AVPlayerItem*item = [notification object];
    
    [item seekToTime:kCMTimeZero];
    [self.player play];
}
- (void)refreshUI:(NSNotification *)note{
    
    
    
    
    if ([self.lblTitle.text containsString:@"4A"]) {
//        [RequestManager get4ATimeMaleData:^(NSDictionary *dictJSON) {
//            self.queueData = dictJSON;
//        }];
        [RequestManager getMaleData:^(NSDictionary *dictJSON) {
            if (dictJSON) {
                self.data = dictJSON[@"data"];
                [self refreshData];
            }
        }];
    }else {
//        [RequestManager get4BTimeMaleData:^(NSDictionary *dictJSON) {
//            self.queueData = dictJSON;
//        }];
        [RequestManager get4BMaleData:^(NSDictionary *dictJSON) {
            if (dictJSON) {
                self.data = dictJSON[@"data"];
                [self refreshData];
            }
        }];
    }
}

#define SaftNumber(str) ([SYTool isVaildNumberValue:(str)]?(str):@"0")

- (void)refreshData{
    //排队
    NSDictionary * quequ = nil;
    NSDictionary * hchoValue = nil;
    
    NSDictionary * H2sValue = nil;
    NSDictionary * otherValueDict = nil;
    
    if ([self.title containsString:@"4A"]) {
        H2sValue = self.data[@"Odor3"];
        quequ = self.data[@"Quene1"];
//        otherValueDict = self.data[@"Odor1"];
//        hchoValue = self.data[@"Odor1"];
        otherValueDict = [RequestManager combine:@[@"Odor1",@"Odor2",@"Odor3"] data:self.data];
        hchoValue = otherValueDict;
        
        if (!otherValueDict || ![otherValueDict isKindOfClass:[NSDictionary class]]) {
            otherValueDict = @{};
        }
        if (!hchoValue || ![hchoValue isKindOfClass:[NSDictionary class]]) {
            hchoValue = @{};
        }
        if (!quequ || ![quequ isKindOfClass:[NSDictionary class]]) {
            quequ = @{};
        }
        if (!H2sValue || ![H2sValue isKindOfClass:[NSDictionary class]]) {
            H2sValue = @{};
        }
    }else{
        quequ = self.data[@"Quene1"];
//        hchoValue = self.data[@"odor3"];
        H2sValue = self.data[@"Odor4"];
        
//        NSDictionary * odor1 = self.data[@"Odor1"];
//        NSDictionary * odor2 = self.data[@"Odor2"];
//        NSDictionary * odor3 = self.data[@"Odor3"];
//        if (!odor1 || ![odor1 isKindOfClass:[NSDictionary class]]) {
//            odor1 = @{};
//        }
//        if (!odor2 || ![odor2 isKindOfClass:[NSDictionary class]]) {
//            odor2 = @{};
//        }
//        if (!odor3 || ![odor3 isKindOfClass:[NSDictionary class]]) {
//            odor3 = @{};
//        }
        if (!quequ || ![quequ isKindOfClass:[NSDictionary class]]) {
            quequ = @{};
        }
        if (!H2sValue || ![H2sValue isKindOfClass:[NSDictionary class]]) {
            H2sValue = @{};
        }
//        NSArray * valueArray = @[odor1,odor2,odor3];
//        NSArray* valueKey = @[@"NH3",@"PM2",@"VOC",@"FME",@"TMP",@"HMY"];
//        NSMutableDictionary * valueMuDict = [NSMutableDictionary dictionary];
//        for (int i = 0;i < valueKey.count; i ++) {
//            NSString * vkey = valueKey[i];
//            NSString * odv1 = valueArray[0][vkey];
//            NSString * odv2 = valueArray[1][vkey];
//            NSString * odv3 = valueArray[2][vkey];
//
//            CGFloat valueJun = (odv1.floatValue + odv2.floatValue + odv3.floatValue)/3;
//            valueMuDict[vkey] = [NSString stringWithFormat:@"%0.0f",valueJun];
//        }
        otherValueDict = [RequestManager combine:@[@"Odor1",@"Odor2",@"Odor4"] data:self.data];
        hchoValue = otherValueDict;
    }
    

    [self.batteryView setProgress:[quequ[@"CNT"] doubleValue]];
    

    

    
    
    
    
    
    
    
    
    
    NSLog(@"%@",self.data);
    self.lblH2sValue.text = [NSString stringWithFormat:@"%@ PPB",SaftNumber(H2sValue[@"H2S"])];
    if([SaftNumber(H2sValue[@"H2S"])integerValue]>=400){
        self.viewH2s.backgroundColor=[UIColor colorWithHexString:@"#E21B1B"];
    }else if([SaftNumber(H2sValue[@"H2S"])integerValue]>100&&[SaftNumber(H2sValue[@"H2S"])integerValue]<400){
        self.viewH2s.backgroundColor=[UIColor colorWithHexString:@"#FFC000"];
    }else if([SaftNumber(H2sValue[@"H2S"])integerValue]>=0&&[SaftNumber(H2sValue[@"H2S"])integerValue]<=100){
        self.viewH2s.backgroundColor=[UIColor colorWithHexString:@"#95CF52"];
    }
    self.lblNh3Value.text = [NSString stringWithFormat:@"%@ PPB",SaftNumber(otherValueDict[@"NH3"])];
    if([SaftNumber(otherValueDict[@"NH3"])integerValue]>40){
        self.viewNh3.backgroundColor=[UIColor colorWithHexString:@"#E21B1B"];
    }else if([SaftNumber(otherValueDict[@"NH3"])integerValue]>=11&&[SaftNumber(otherValueDict[@"NH3"])integerValue]<=40){
        self.viewNh3.backgroundColor=[UIColor colorWithHexString:@"#FFC000"];
    }else if([SaftNumber(otherValueDict[@"NH3"])integerValue]>=0&&[SaftNumber(otherValueDict[@"NH3"])integerValue]<10){
        self.viewNh3.backgroundColor=[UIColor colorWithHexString:@"#95CF52"];
    }
    self.lblPM2Value.text = [NSString stringWithFormat:@"%@ ug/m³",SaftNumber(otherValueDict[@"PM2"])];
    if([SaftNumber(otherValueDict[@"PM2"])integerValue]>300){
        self.viewPm.backgroundColor=[UIColor colorWithHexString:@"#E21B1B"];
    }else if([SaftNumber(otherValueDict[@"PM2"])integerValue]>=101&&[SaftNumber(otherValueDict[@"PM2"])integerValue]<=300){
        self.viewPm.backgroundColor=[UIColor colorWithHexString:@"#FFC000"];
    }else if([SaftNumber(otherValueDict[@"PM2"])integerValue]>=0&&[SaftNumber(otherValueDict[@"PM2"])integerValue]<=100){
        self.viewPm.backgroundColor=[UIColor colorWithHexString:@"#95CF52"];
    }
    self.lblVocValue.text = [NSString stringWithFormat:@"%@ PPB",SaftNumber(otherValueDict[@"VOC"])];
    if([SaftNumber(otherValueDict[@"VOC"])integerValue]>800){
        self.viewVoc.backgroundColor=[UIColor colorWithHexString:@"#E21B1B"];
    }else if([SaftNumber(otherValueDict[@"VOC"])integerValue]>400&&[SaftNumber(otherValueDict[@"VOC"])integerValue]<=800){
        self.viewVoc.backgroundColor=[UIColor colorWithHexString:@"#FFC000"];
    }else if([SaftNumber(otherValueDict[@"VOC"])integerValue]>=0&&[SaftNumber(otherValueDict[@"VOC"])integerValue]<=400){
        self.viewVoc.backgroundColor=[UIColor colorWithHexString:@"#95CF52"];
    }
    
    self.lblHcho.text =[NSString stringWithFormat:@"%@",SaftNumber(hchoValue[@"FME"])];
    if([SaftNumber(hchoValue[@"FME"])integerValue]>301){
        self.viewHcho.backgroundColor=[UIColor colorWithHexString:@"#E21B1B"];
    }else if([SaftNumber(hchoValue[@"FME"])integerValue]>100&&[SaftNumber(hchoValue[@"FME"])integerValue]<=300){
        self.viewHcho.backgroundColor=[UIColor colorWithHexString:@"#FFC000"];
    }else if([SaftNumber(hchoValue[@"FME"])integerValue]>=0&&[SaftNumber(hchoValue[@"FME"])integerValue]<=100){
        self.viewHcho.backgroundColor=[UIColor colorWithHexString:@"#95CF52"];
    }
    
    self.lblTempValue.text = [NSString stringWithFormat:@"%@℃",SaftNumber(otherValueDict[@"TMP"])];
    self.lblHumidity.text = [NSString stringWithFormat:@"%@%%",SaftNumber(otherValueDict[@"HMY"])];
    
    NSDictionary * occupancy3 = self.data[@"Occupancy3"];
    NSDictionary * occupancy4 = self.data[@"Occupancy4"];
    NSDictionary * occupancy5 = self.data[@"Occupancy5"];
    if (!occupancy3 || ![occupancy3 isKindOfClass:[NSDictionary class]]) {
        occupancy3 = @{@"DIO":@"NORMAL"};
    }
    if (!occupancy4 || ![occupancy4 isKindOfClass:[NSDictionary class]]) {
        occupancy4 = @{@"DIO":@"NORMAL"};
    }
    if (!occupancy5 || ![occupancy5 isKindOfClass:[NSDictionary class]]) {
        occupancy5 = @{@"DIO":@"NORMAL"};
    }
    int Acount = 0;
    int Bcount = 0;
    
    if ([self.title containsString:@"4A"]) {
        if([occupancy3[@"DIO"] isEqualToString:@"NORMAL"]){
            Acount=Acount;
        }else{
            Acount=Acount+1;
        }
        
        if([occupancy4[@"DIO"] isEqualToString:@"NORMAL"]){
            Acount=Acount;
        }else{
            Acount=Acount+1;
        }
        
        if([occupancy5[@"DIO"]isEqualToString:@"NORMAL"]){
            Acount=Acount;
        }else{
            Acount=Acount+1;
        }
        NSLog(@"%d",Acount);
        
        NSDictionary * occupancy1 = self.data[@"Occupancy1"];
        NSDictionary * occupancy2 = self.data[@"Occupancy2"];
        if (!occupancy1 || ![occupancy1 isKindOfClass:[NSDictionary class]]) {
            occupancy1 = @{@"DIO":@"NORMAL"};
        }
        if (!occupancy2 || ![occupancy2 isKindOfClass:[NSDictionary class]]) {
            occupancy2 = @{@"DIO":@"NORMAL"};
        }
        
        if([occupancy1[@"DIO"] isEqualToString:@"NORMAL"]){
            Bcount=Bcount;
        }else{
            Bcount=Bcount+1;
        }
        
        if([occupancy2[@"DIO"]isEqualToString:@"NORMAL"]){
            Bcount=Bcount;
        }else{
            Bcount=Bcount+1;
        }
        self.lblCountA.text = [NSString stringWithFormat:@"%d/3",Acount];
        self.lblCountB.text = [NSString stringWithFormat:@"%d/2",Bcount];
    }else{
        
        for (int i = 16; i < 26; i ++) {
            NSDictionary * occupancy =self.data[[NSString stringWithFormat:@"Occupancy%d",i+1]];
//            if ([occupancy isKindOfClass:[NSString class]]) {
//                occupancy = @{@"DID":@""};
//            }
            if (!occupancy || ![occupancy isKindOfClass:[NSDictionary class]]) {
                occupancy = @{@"DIO":@"NORMAL"};
            }
            if([occupancy[@"DIO"] isEqualToString:@"NORMAL"]){
                Acount=Acount;
            }else{
                Acount=Acount+1;
            }
        }
        
        for (int i = 0; i < 8; i ++) {
            NSDictionary * occupancy =self.data[[NSString stringWithFormat:@"Occupancy%d",i+1]];
//            if ([occupancy isKindOfClass:[NSString class]]) {
//                occupancy = @{@"DID":@""};
//            }
            if (!occupancy || ![occupancy isKindOfClass:[NSDictionary class]]) {
                occupancy = @{@"DIO":@"NORMAL"};
            }
            
            if([occupancy[@"DIO"] isEqualToString:@"NORMAL"]){
                Bcount=Bcount;
            }else{
                Bcount=Bcount+1;
            }
        }
        
        self.lblCountA.text = [NSString stringWithFormat:@"%d/10",Acount];
        self.lblCountB.text = [NSString stringWithFormat:@"%d/8",Bcount];
    }
}





@end
