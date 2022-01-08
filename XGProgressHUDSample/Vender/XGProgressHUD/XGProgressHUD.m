//  XGProgressHUD.m
//  Version 1.0.0
//  Created by iixg on 2022/1/2.
//  Copyright (c) 2022 iixg.
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.
//

#import "XGProgressHUD.h"

static const int     kXGToastTag        = 2022010323;
static const CGFloat kXGHideDelay       = 2.0;
static const CGFloat kXGMessageFontSize = 14.0;

@interface XGProgressHUD () {
    NSInteger toastCnt;
    NSInteger loadingCnt;
}

@property (nonatomic, strong) dispatch_queue_t      toastQueue;
@property (nonatomic, strong) dispatch_semaphore_t  toastSema;
@property (nonatomic, strong) XGProgressHUD         *loadingHud;
@property (nonatomic, strong) NSMutableDictionary   *loadingCntDic;

@end

@implementation XGProgressHUD

+ (instancetype)sharedManager {
    static XGProgressHUD *_shareManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareManager = [[[self class] alloc] init];
        if (!_shareManager.toastQueue) {
            _shareManager.toastQueue = dispatch_queue_create("xg_toastSingal", DISPATCH_QUEUE_SERIAL);
            _shareManager.toastSema = dispatch_semaphore_create(0);
        }
    });
    return _shareManager;
}

- (NSMutableDictionary *)loadingCntDic {
    if (!_loadingCntDic) {
        _loadingCntDic = [NSMutableDictionary dictionary];
    }
    return _loadingCntDic;
}

#pragma mark - create HUD
- (XGProgressHUD *)progressHUD:(UIView *)view
                          style:(XGProgressHUDStyle)style {
    

    XGProgressHUD *hud = [XGProgressHUD showHUDAddedTo:view
                                              animated:YES];
    
    hud.removeFromSuperViewOnHide = YES;
    
    //Customize your view according to the type
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.backgroundView.color = [UIColor colorWithWhite:0.0f
                                                 alpha:[view isMemberOfClass:[UIView class]] ? 0.0f : 0.5f];
    
    hud.contentColor = [UIColor whiteColor];
    hud.bezelView.color = [UIColor colorWithWhite:0.0f alpha:0.5f];
    [hud.detailsLabel setFont:[UIFont systemFontOfSize:kXGMessageFontSize]];
    hud.detailsLabel.textColor = [UIColor whiteColor];

    return hud;
}

#pragma mark - Show loading HUD
- (XGProgressHUD *)showLoadingHUD:(NSString *)message
                             view:(UIView *)view {
    
    if (loadingCnt <= 0 || !_loadingHud) {
        loadingCnt = 0;
        _loadingHud = [self progressHUD:view style:XGProgressHUDStyleLoading];
        [_loadingHud setMode:MBProgressHUDModeIndeterminate];
    }
    
    _loadingHud.userInteractionEnabled = YES;
    _loadingHud.hidden = toastCnt > 0;
    _loadingHud.detailsLabel.text = message;

    loadingCnt ++;
    
    [self.loadingCntDic setValue:@(loadingCnt) forKey:view.description];
    
    __weak typeof(self) weakSelf = self;
    
    weakSelf.loadingHud.completionBlock = ^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        
        if (strongSelf->loadingCnt <= 0) {
            strongSelf->loadingCnt = 0;
            strongSelf->_loadingHud = nil;
            [strongSelf.loadingCntDic setValue:@(0) forKey:view.description];
        }
    };
    
    return _loadingHud;
}

#pragma mark - Hide loading HUD
- (void)hideLoadingHUD:(NSString *)message
                  view:(UIView *)view {
    loadingCnt --;
    if (message) {
        if (loadingCnt <= 0) {
            [self hideLoadingHUD:view];
        } else {
            _loadingHud.hidden = YES;
        }
        [self showToastHUD:message view:view];
    } else {
        if (loadingCnt <= 0) {
            [self hideLoadingHUD:view];
        }
    }
}

- (void)hideLoadingHUD:(UIView *)view {
    [self hideLoadingHUD:nil view:view animated:YES];
}

- (void)hideLoadingHUD:(NSString *)message
                  view:(UIView *)view
              animated:(BOOL)animated {
    
    if ([self isMultipleHide:view]) {
        return;
    }
    
    loadingCnt --;
    
    if (loadingCnt <= 0) {
        [self.loadingCntDic removeAllObjects];
        [_loadingHud hideAnimated:animated];
        loadingCnt = 0;
        _loadingHud = nil;
    }
}

- (BOOL)isMultipleHide:(UIView *)view {
    NSNumber *loadingCntNumber = self.loadingCntDic[view.description];
    if (loadingCntNumber.intValue == 0) {
        [self.loadingCntDic removeObjectForKey:view.description];
        return YES;
    }
    return NO;
}

#pragma mark - Show toast
- (void)showToastHUD:(NSString *_Nonnull)message
                view:(UIView *)view {

    if (!message || [message length] == 0) {
        return;
    }
    if (_loadingHud) {
        _loadingHud.hidden = YES;
    }

    XGProgressHUD *hud = nil;
    UIView *hudView = [view viewWithTag:kXGToastTag];
    
    if ([hudView isKindOfClass:[XGProgressHUD class]]) {
        hud = (XGProgressHUD *)hudView;
    }

    if (hud && [hud.detailsLabel.text isEqualToString:message]) {
        return;
    }
    
    toastCnt ++;
    __weak typeof(self) weakSelf = self;
    
    dispatch_async(_toastQueue, ^{
        dispatch_sync(dispatch_get_main_queue(), ^{
            XGProgressHUD *toastHud = [self progressHUD:view
                                                  style:XGProgressHUDStyleToast];
            toastHud.tag = kXGToastTag;
            [toastHud setMode:MBProgressHUDModeText];
            toastHud.detailsLabel.text = message;
            toastHud.userInteractionEnabled = self->loadingCnt > 0;

            __weak typeof(toastHud) weakToastHud = toastHud;

            weakToastHud.completionBlock = ^{
                __strong typeof(weakSelf) setongSelf = weakSelf;
                
                setongSelf->toastCnt --;
                if (setongSelf->toastCnt <= 0) {
                    setongSelf->toastCnt = 0;
                }
                if (setongSelf->loadingCnt > 0) {
                    setongSelf.loadingHud.hidden = NO;
                }
                dispatch_semaphore_signal(setongSelf.toastSema);
            };

            [toastHud hideAnimated:YES
                        afterDelay:kXGHideDelay];
        });
        
        dispatch_semaphore_wait(self.toastSema, DISPATCH_TIME_FOREVER);
    });
}

@end


@implementation UIView (XGProgressHUD)

- (XGProgressHUD *)xg_showLoadingHUD {
    return [[XGProgressHUD sharedManager] showLoadingHUD:nil
                                                    view:self];
}

- (XGProgressHUD *)xg_showLoadingHUD:(NSString *)message {
    return [[XGProgressHUD sharedManager] showLoadingHUD:message
                                                    view:self];
}

- (void)xg_showToastHUD:(NSString *)message {
    [[XGProgressHUD sharedManager] showToastHUD:message
                                           view:self];
}

- (void)xg_hideProgressHUD {
    [[XGProgressHUD sharedManager] hideLoadingHUD:self];
}

- (void)xg_hideProgressHUD:(BOOL)animated {
    [[XGProgressHUD sharedManager] hideLoadingHUD:nil
                                             view:self
                                         animated:animated];
}

- (void)xg_hideProgressHUD:(NSString *)message
                      style:(XGProgressHUDStyle)style {
    [[XGProgressHUD sharedManager] hideLoadingHUD:message
                                             view:self];
}

@end
