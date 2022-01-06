# XGProgressHUD

#中文说明
`XGProgressHUD` 是继承自开源项目 `MBProgressHUD` 的一个子类，通过 Category 方式，使用 GCD 信号量机制和单例管理 HUD 的显示逻辑。为 HUD 添加计数，让当前页面同一时间只显示一个HUD。如果有多个请求返回 toast，可以按顺序依次显示。解决多个请求时，可能出现 loading 和 toast 重叠或丢失（不显示）的问题。


## Requirements

`XGProgressHUD` 兼容 iOS 9.0+. 依赖（继承自） MBProgressHUD.

## 添加 XGProgressHUD 到你的项目

### 添加源文件

1、直接将 `XGProgressHUD.h` 和 `XGProgressHUD.m` 两个文件拖到你的项目中；
2、添加 `MBProgressHUD`，可以使用源文件或者 pods 等方式；
3、如果使用 pods 等方式添加`MBProgressHUD`到项目，
注意修改 `XGProgressHUD.h` 中引入头文件的方式，改为 `#import <MBProgressHUD/MBProgressHUD.h>`。

## 使用
1、只显示 loading 动画
```objective-c
    [self.view xg_showLoadingHUD];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        // Do something...
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.view xg_hideProgressHUD];
        });
    });
```

2、显示一个带有信息的 loading 动画
```objective-c
    [self.view xg_showLoadingHUD:@"this is a message!"];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        // Do something...
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.view xg_hideProgressHUD];
        });
    });
```

3、返回带有信息的 toast
```objective-c
    [self.view xg_showLoadingHUD:@"this is a message!"];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        // Do something...
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.view xg_hideProgressHUD:@"failed!"
                                 type:XGProgressHUDToastType];
        });
    });
```

可以将 HUD 添加到任意的 view 或者 window 上。

###注意：
1、使用 `xg_showLoadingHUD` 时，需要在适合的位置使用 `xg_hideProgressHUD`，否则 HUD 无法消失。
2、如果 HUD 正在显示时退出当前 view，没有执行 `xg_hideProgressHUD:` 时，可能会影响下一次的正常显示。这种情况，可以在主动退出页面时，主动调用 `xg_hideProgressHUD:`。例如在 `viewWillDisappear:` 中。


```objective-c
- (XGProgressHUD *)progressHUD:(UIView *)view
                          type:(XGProgressHUDType)type
```

## License

This code is distributed under the terms and conditions of the [MIT license](LICENSE).
