//
//  FemaleDetailViewController.m
//  EMSD
//
//  Created by 李国栋 on 2019/6/2.
//  Copyright © 2019年 李国栋. All rights reserved.
//

#import "FemaleDetailViewController.h"
#import "BatteryView.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVKit/AVKit.h>
@interface FemaleDetailViewController ()

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
@property (weak, nonatomic) IBOutlet UILabel *lblHcho;

@property (weak, nonatomic) IBOutlet UILabel *lblPM2Title;
@property (weak, nonatomic) IBOutlet UILabel *lblCountA;

@property (copy, nonatomic) NSDictionary *data;
@property (weak, nonatomic) IBOutlet UIView *viewH2s;
@property (weak, nonatomic) IBOutlet UIView *viewPm;
@property (weak, nonatomic) IBOutlet UIView *viewVoc;
@property (weak, nonatomic) IBOutlet UIView *viewNh3;
@property (weak, nonatomic) IBOutlet UIView *viewHcho;


@property(nonatomic,strong)BatteryView * batteryView;
//@property(nonatomic,copy)NSDictionary * queueData;

@end

@implementation FemaleDetailViewController

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
    
    [self refreshData];
    NSMutableAttributedString * attPM2 = [[NSMutableAttributedString alloc] initWithString:@"PM2.5"];
    [attPM2 setAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"SegoeUI-Light" size:17]} range:NSMakeRange(0, 2)];
    [attPM2 setAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"SegoeUI-Light" size:26]} range:NSMakeRange(2, 3)];
    self.lblPM2Title.attributedText = attPM2;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshUI:) name:@"NotificationRefreshUI" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willEnterForegroun) name:UIApplicationWillEnterForegroundNotification object:nil];
}

- (void)willEnterForegroun
{
    [self.player play];
}

- (void)refreshUI:(NSNotification *)note{
    
    
//    [RequestManager getFemaleData:^(NSDictionary *dictJSON) {
//        self.data = dictJSON[@"data"];
//        [self refreshData];
//    }];
    
    
    if ([self.lblTitle.text containsString:@"4A"]) {
//        [RequestManager get4ATimeFemaleData:^(NSDictionary *dictJSON) {
//            self.queueData = dictJSON;
//        }];
        
        
        [RequestManager getFemaleData:^(NSDictionary *dictJSON) {
            if (dictJSON) {
                self.data = dictJSON[@"data"];
                [self refreshData];
            }
        }];
        
    }else {
//        [RequestManager get4BTimeFemaleData:^(NSDictionary *dictJSON) {
//            self.queueData = dictJSON;
//        }];
        
        
        [RequestManager get4BFemaleData:^(NSDictionary *dictJSON) {
            if (dictJSON) {
                self.data = dictJSON[@"data"];
                [self refreshData];
            }
        }];
    }
    

}

#define SaftNumber(str) ([SYTool isVaildNumberValue:(str)]?(str):@"0")
- (void)refreshData{
    
//    [self.batteryView setProgress:[self.queueData[@"queue"] doubleValue]];
    //排队
    NSDictionary * quequ = nil;
    if ([self.title containsString:@"4A"]) {
        quequ = self.data[@"Quene1"];
    }else{
        quequ = self.data[@"Quene1"];
    }
    if (!quequ || ![quequ isKindOfClass:[NSDictionary class]]) {
        quequ = @{};
    }
    
    [self.batteryView setProgress:[quequ[@"CNT"] doubleValue]];

    
    
    NSDictionary * H2sValue = self.data[@"Odor2"];
    NSDictionary * otherValueDict = [RequestManager combine:@[@"Odor1",@"Odor2"] data:self.data];
    if (!H2sValue || ![H2sValue isKindOfClass:[NSDictionary class]]) {
        H2sValue = @{};
    }
    if (!otherValueDict || ![otherValueDict isKindOfClass:[NSDictionary class]]) {
        otherValueDict = @{};
    }
    
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
    
    
    self.lblHcho.text =[NSString stringWithFormat:@"%@ ug/m³",SaftNumber(otherValueDict[@"FME"])];
    if([SaftNumber(otherValueDict[@"FME"])integerValue]>301){
        self.viewHcho.backgroundColor=[UIColor colorWithHexString:@"#E21B1B"];
    }else if([SaftNumber(otherValueDict[@"FME"])integerValue]>100&&[SaftNumber(otherValueDict[@"FME"])integerValue]<=300){
        self.viewHcho.backgroundColor=[UIColor colorWithHexString:@"#FFC000"];
    }else if([SaftNumber(otherValueDict[@"FME"])integerValue]>=0&&[SaftNumber(otherValueDict[@"FME"])integerValue]<=100){
        self.viewHcho.backgroundColor=[UIColor colorWithHexString:@"#95CF52"];
    }
   
    self.lblTempValue.text = [NSString stringWithFormat:@"%@℃",SaftNumber(otherValueDict[@"TMP"])];
    self.lblHumidity.text = [NSString stringWithFormat:@"%@%%",SaftNumber(otherValueDict[@"HMY"])];
    
    int Acount = 0;
    if ([self.title containsString:@"4A"]) {
        NSDictionary * occupancy1 = self.data[@"Occupancy1"];
        NSDictionary * occupancy2 = self.data[@"Occupancy2"];
        NSDictionary * occupancy3 = self.data[@"Occupancy3"];
        
        if (!occupancy1 ||![occupancy1 isKindOfClass:[NSDictionary class]]) {
            occupancy1 = @{@"DIO":@"NORMAL"};
        }
        if (!occupancy2 ||![occupancy2 isKindOfClass:[NSDictionary class]]) {
            occupancy2 = @{@"DIO":@"NORMAL"};
        }
        if (!occupancy3 ||![occupancy3 isKindOfClass:[NSDictionary class]]) {
            occupancy3 = @{@"DIO":@"NORMAL"};
        }
        
        if([occupancy1[@"DIO"] isEqualToString:@"NORMAL"]){
            Acount=Acount;
        }else{
            Acount=Acount+1;
        }
        
        if([occupancy2[@"DIO"]isEqualToString:@"NORMAL"]){
            Acount=Acount;
        }else{
            Acount=Acount+1;
        }
        
        if([occupancy3[@"DIO"]isEqualToString:@"NORMAL"]){
            Acount=Acount;
        }else{
            Acount=Acount+1;
        }
        
        self.lblCountA.text = [NSString stringWithFormat:@"%d/3",Acount];
    }else{
        
        for (int i = 0; i < 6; i ++) {
            NSDictionary * occupancy =self.data[[NSString stringWithFormat:@"occupancy%d",i+1]];
            if (!occupancy || ![occupancy isKindOfClass:[NSDictionary class]]) {
                occupancy = @{@"DIO":@"NORMAL"};
            }
            
            if([occupancy[@"DIO"] isEqualToString:@"NORMAL"]){
                Acount=Acount;
            }else{
                Acount=Acount+1;
            }
        }
        for (int i = 6; i < 10; i ++) {
            NSDictionary * occupancy =self.data[[NSString stringWithFormat:@"occupancy%d",i+1]];
            if (!occupancy || ![occupancy isKindOfClass:[NSDictionary class]]) {
                occupancy = @{@"DIO":@"NORMAL"};
            }
            
            if([occupancy[@"DIO"] isEqualToString:@"NORMAL"]){
                Acount=Acount;
            }else{
                Acount=Acount+1;
            }
        }
        
        self.lblCountA.text = [NSString stringWithFormat:@"%d/10",Acount];
    }
}
- (void)SetupVideoPlayer{
    // 加载本地视频
    NSURL *movieUrl = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"pink" ofType:@"mp4"]];
    
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
    [self.view.layer insertSublayer:playerLayer atIndex:0];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayDidEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:self.player.currentItem];
    
    
    //    // 设置音量
    //    /*
    //     范围 0 - 1，默认为 1
    //     */
    player.volume = 0;
    
    // 开始播放
    [player play];
}
- (void)moviePlayDidEnd:(NSNotification*)notification{
    AVPlayerItem*item = [notification object];
    
    [item seekToTime:kCMTimeZero];
    [self.player play];
}


@end
