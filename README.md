# XGProgressHUD

`XGProgressHUD` is a subclass of the open source project `MBProgressHUD`.It's a Category of UIView.It can show or hide the HUD.
When handling time consuming task, ensure that loading and toast can be displayed in sequence without missing or overlapping.


## Requirements

`XGProgressHUD` supports iOS 9.0+. Dependent on `MBProgressHUD`. 

## Adding XGProgressHUD to your project

### Source files
1.Alternatively you can directly add the `XGProgressHUD.h` and `XGProgressHUD.m` source files to your project.
2.Add `MBProgressHUD` to your project. You can use source files or Pods, etc.
3.Include XGProgressHUD wherever you need it with `#import "XGProgressHUD.h"`.

## Usage
1.
```objective-c
    [self.view xg_showLoadingHUD];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        // Do something...
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.view xg_hideProgressHUD];
        });
    });
```

2.
```objective-c
    [self.view xg_showLoadingHUD:@"message"];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        // Do something...
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.view xg_hideProgressHUD];
        });
    });
```

3.
```objective-c
    [self.view xg_showLoadingHUD:@"message"];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        // Do something...
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.view xg_hideProgressHUD:@"message"
                                 style:XGProgressHUDStyleToast];
        });
    });
```

You can add the HUD on any view or window. 

## Note

1.To use `xg_showLoadingHUD`, you need to use `xg_hideProgressHUD` in the appropriate place, otherwise the HUD will not disappear.
2.If you exit the current view while the loading HUD is displaying, you need to actively call `xg_hideProgressHUD:animated`. Animated needs to be set to NO.

```objective-c
    - (void)viewWillDisappear:(BOOL)animated {
        [super viewWillDisappear:animated];
        [self.view xg_hideProgressHUD:NO];
    }

```

## License

This code is distributed under the terms and conditions of the [MIT license](LICENSE).


***


# XGProgressHUD（中文）

`XGProgressHUD` 是开源项目 `MBProgressHUD` 的一个子类。它是 UIView 的一个 Category。它可以显示或隐藏HUD。在处理耗时较长的任务时，确保 loading 和 toast 可以按顺序显示，不会出现遗漏或重叠。


## Requirements

`XGProgressHUD` 支持 iOS 9.0+. 依赖 `MBProgressHUD`。

## 添加 XGProgressHUD 到你的项目

### 源文件
1.你可以直接添加 `XGProgressHUD.h` 和 `XGProgressHUD.m` 源文件到你的项目。
2.添加 `MBProgressHUD` 到你的项目. 你可以使用源文件或者 pods 等其他方式。
3.在你需要使用的位置引入头文件。 `#import "XGProgressHUD.h"`。

## 使用
1.
```objective-c
    [self.view xg_showLoadingHUD];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        // Do something...
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.view xg_hideProgressHUD];
        });
    });
```

2.
```objective-c
    [self.view xg_showLoadingHUD:@"message"];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        // Do something...
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.view xg_hideProgressHUD];
        });
    });
```

3.
```objective-c
    [self.view xg_showLoadingHUD:@"message"];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        // Do something...
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.view xg_hideProgressHUD:@"message"
                                 style:XGProgressHUDStyleToast];
        });
    });
```

你可以在任何 view 或 window 中添加 HUD。

## 注意事项

1.使用 `xg_showLoadingHUD` 时，你需要在适当的地方使用 `xg_hideProgressHUD`，否则 HUD 将不会消失。
2.如果在 loading HUD 显示时退出当前 view（例如点击导航栏返回按钮时），你需要主动调用 `xg_hideProgressHUD:animated` ，animated 设置为 NO。

```objective-c
    [self.view xg_hideProgressHUD:NO];
```

## License

This code is distributed under the terms and conditions of the [MIT license](LICENSE).


