//
//  ViewController.m
//  EMSD
//
//  Created by 李国栋 on 2019/6/2.
//  Copyright © 2019年 李国栋. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"
#import "FemaleDetailViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [UIApplication sharedApplication].statusBarHidden = NO;
}

- (IBAction)tap4AMale:(id)sender {
    DetailViewController * vc = [DetailViewController new];
    
    vc.title = @"TOILET 4A，EMSD";
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)tap4BMale:(id)sender {
    DetailViewController * vc = [DetailViewController new];
    
    [self.navigationController pushViewController:vc animated:YES];
    vc.title = @"TOILET 4B，EMSD";
}

- (IBAction)tap4AFemale:(id)sender {
    FemaleDetailViewController * vc = [FemaleDetailViewController new];
    vc.title = @"TOILET 4A，EMSD";
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)tap4BFemale:(id)sender {
    FemaleDetailViewController * vc = [FemaleDetailViewController new];
    vc.title = @"TOILET 4B，EMSD";
    [self.navigationController pushViewController:vc animated:YES];
}



@end
