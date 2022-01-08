//
//  Sample1ViewController.m
//  XGProgressHUDSample
//
//  Created by iixg on 2022/1/5.
//

#import "Sample1ViewController.h"

#import "XGProgressHUD.h"

@interface Sample1ViewController ()
@property (nonatomic, strong) XGProgressHUD *hud;
@end

@implementation Sample1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self reqeuest];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.view xg_hideProgressHUD:NO];
}

- (void)reqeuest {
    [self.view xg_showLoadingHUD];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // Do something...
        [self.view xg_hideProgressHUD];
    });
}

@end
