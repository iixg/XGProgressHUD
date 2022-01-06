//  XGProgressHUD.h
//  Version 1.0.0
//  Created by ixg on 2022/1/2.

#import "MBProgressHUD.h"

typedef NS_ENUM (NSInteger, XGProgressHUDType) {
    XGProgressHUDLoadingType = 1,
    XGProgressHUDToastType   = 2
};

NS_ASSUME_NONNULL_BEGIN
@interface XGProgressHUD : MBProgressHUD
@end

@interface UIView (XGProgressHUD)

- (XGProgressHUD *)xg_showLoadingHUD;
- (XGProgressHUD *)xg_showLoadingHUD:(NSString * _Nullable)message;

- (void)xg_hideProgressHUD;
- (void)xg_hideProgressHUD:(BOOL)animated;
- (void)xg_hideProgressHUD:(NSString * _Nullable)message
                      type:(XGProgressHUDType)type;

- (void)xg_showToastHUD:(NSString * _Nonnull)message;

@end
NS_ASSUME_NONNULL_END
