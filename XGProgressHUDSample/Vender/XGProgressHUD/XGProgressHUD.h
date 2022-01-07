//  XGProgressHUD.h
//  Version 1.0.0
//  Created by ixg on 2022/1/2.
//  Copyright (c) 2022 ixg.
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.
//


#import "MBProgressHUD.h"

typedef NS_ENUM (NSInteger, XGProgressHUDStyle) {
    XGProgressHUDStyleLoading = 1,
    XGProgressHUDStyleToast   = 2
};

NS_ASSUME_NONNULL_BEGIN
@interface XGProgressHUD : MBProgressHUD
@end

@interface UIView (XGProgressHUD)

/**
 * Show the loading HUD.
 *
 * @return A reference to the created HUD.
 */
- (XGProgressHUD *)xg_showLoadingHUD;


/**
 * Show the loading HUD.
 * @param message The message to be displayed on the HUD.
 * @return A reference to the created HUD.
 */
- (XGProgressHUD *)xg_showLoadingHUD:(NSString * _Nullable)message;


/**
 * Hide the loading HUD.
 * HUD will use animations while disappearing.
 *
 */
- (void)xg_hideProgressHUD;

/**
 * Hide the loading HUD.
 *
 * @param animated If set to YES the HUD will disappear using the current animationType（MBProgressHUD）. If set to NO the HUD will not use
 * animations while disappearing.
 */
- (void)xg_hideProgressHUD:(BOOL)animated;

/**
 * Hide the loading HUD.
 *
 * @param message  The message to be displayed on the HUD.
 * @param style    Generally, XGProgressHUDToast is used.
 */
- (void)xg_hideProgressHUD:(NSString * _Nullable)message
                      style:(XGProgressHUDStyle)style;

/**
 * Show a toast.
 *
 * @param message The message to be displayed on the HUD.
 */
- (void)xg_showToastHUD:(NSString *)message;

@end
NS_ASSUME_NONNULL_END
