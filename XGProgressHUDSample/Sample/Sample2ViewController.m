//
//  Sample2ViewController.m
//  XGProgressHUDSample
//
//  Created by iixg on 2022/1/5.
//

#import "Sample2ViewController.h"
#import "XGProgressHUD.h"

@interface Sample2ViewController ()

@end

@implementation Sample2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self request];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.view xg_hideProgressHUD:NO];
}


- (void)request {
    [self.view xg_showLoadingHUD:@"loading..."];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.view xg_hideProgressHUD];
    });
}

@end
