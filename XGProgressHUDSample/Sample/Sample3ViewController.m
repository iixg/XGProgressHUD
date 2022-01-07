//
//  Sample3ViewController.m
//  XGProgressHUDSample
//
//  Created by ixg on 2022/1/5.
//

#import "Sample3ViewController.h"

@interface Sample3ViewController ()

@end

@implementation Sample3ViewController

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
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.view xg_hideProgressHUD:@"success"
                                 style:XGProgressHUDStyleToast];
    });
}


@end
