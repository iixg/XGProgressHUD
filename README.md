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

##Note

1.To use `xg_showLoadingHUD`, you need to use `xg_hideProgressHUD` in the appropriate place, otherwise the HUD will not disappear.
2.If you exit the current view while the HUD is displaying, you need to actively call 'xg_hideProgressHUD: Animated'. Animated needs to be set to NO.

```objective-c
    [self.view xg_hideProgressHUD:NO];
```

## License

This code is distributed under the terms and conditions of the [MIT license](LICENSE).

## Change-log

A brief summary of each MBProgressHUD release can be found in the [CHANGELOG](CHANGELOG.mdown).
