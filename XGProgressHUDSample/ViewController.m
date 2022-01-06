//
//  ViewController.m
//  XGProgressHUDSample
//
//  Created by ixg on 2022/1/2.
//

#import "ViewController.h"
#import "XGProgressHUD.h"

static const CGFloat kDelay = 2.0f;

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"XGProgressHUD";
}

- (IBAction)showLoadingAction:(id)sender {
    [self.view xg_showLoadingHUD];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kDelay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //...
        
        [self.view xg_hideProgressHUD];
    });
}

- (IBAction)showLoadingWithMessageAction:(id)sender {
    
    [self.view xg_showLoadingHUD:@"this is a message!"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kDelay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //...
        
        [self.view xg_hideProgressHUD];
    });
}

- (IBAction)showLoadingWithMessage2Action:(id)sender {
    
    [self.view xg_showLoadingHUD:@"this is a message!"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kDelay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //...
        
        [self.view xg_hideProgressHUD:@"failed!"
                                 type:XGProgressHUDToastType];
    });
}

- (IBAction)showToastAction:(id)sender {
    [self.view xg_showToastHUD:@"this is a toast!"];
}

@end
