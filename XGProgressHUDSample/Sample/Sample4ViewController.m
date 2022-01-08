//
//  Sample4ViewController.m
//  XGProgressHUDSample
//
//  Created by iixg on 2022/1/5.
//

#import "Sample4ViewController.h"

@interface Sample4ViewController ()

@end

@implementation Sample4ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.view xg_showToastHUD:@"toast"];
}

@end
