//
//  MBProgressHUD+Extension.m
//  YesIDo
//
//  Created by ShannonChen on 16/8/12.
//  Copyright © 2016年 YHouse. All rights reserved.
//

#import "MBProgressHUD+Extension.h"

static const NSTimeInterval kHUDShowingDuration = 2;

@implementation MBProgressHUD (Extension)

+ (instancetype)vc_showActivityIndicatorAddedTo:(UIView *)view {
    return [MBProgressHUD vc_showActivityIndicatorWithMessage:nil addedTo:view];
}

+ (BOOL)vc_hideHUDForView:(UIView *)view {
    
    if (!view) {
        return NO;
    }
    
    MBProgressHUD *hud = [self HUDForView:view];
    if (hud != nil) {
        hud.removeFromSuperViewOnHide = YES;
        dispatch_async(dispatch_get_main_queue(), ^{
            [hud hideAnimated:YES];
        });
        return YES;
    }
    return NO;
    
}

+ (instancetype)vc_showActivityIndicatorWithMessage:(NSString *)message addedTo:(UIView *)view {
    [self vc_hideHUDForView:view];
    
    if (!view) {
        return nil;
    }
    
    MBProgressHUD *hud = [[self alloc] initWithView:view];
    hud.removeFromSuperViewOnHide = YES;
    
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.bezelView.color = [UIColor blackColor];
    hud.contentColor = [UIColor whiteColor];
    hud.label.text = message;
    hud.label.font = [UIFont systemFontOfSize:12];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [view addSubview:hud];
        [hud showAnimated:YES];
    });
       
    
    return hud;
}

+ (instancetype)vc_showMessage:(NSString *)message addedTo:(UIView *)view duration:(NSTimeInterval)duration {
    [self vc_hideHUDForView:view];
    
    if (!message || !message.length) {
        return nil;
    }
    
    if (!view) {
        return nil;
    }
    
    MBProgressHUD *hud = [[self alloc] initWithView:view];
    hud.removeFromSuperViewOnHide = YES;
    hud.userInteractionEnabled = NO;
    
    hud.mode = MBProgressHUDModeText;
    hud.bezelView.color = [UIColor blackColor];
    hud.contentColor = [UIColor whiteColor];
    hud.label.text = message;
    hud.label.font = [UIFont systemFontOfSize:13];
    hud.margin = 10.f;
    hud.bezelView.layer.cornerRadius = 3.0f;
    hud.offset = CGPointMake(hud.offset.x, 120);
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [view addSubview:hud];
        [hud showAnimated:YES];
        [hud hideAnimated:YES afterDelay:duration];
        
    });
    
    return hud;
}

+ (instancetype)vc_showMessage:(NSString *)message addedTo:(UIView *)view {
    return [self vc_showMessage:message addedTo:view duration:kHUDShowingDuration];
}

+ (instancetype)vc_showDetailInfo:(NSString *)info addedTo:(UIView *)view duration:(NSTimeInterval)duration {
    [self vc_hideHUDForView:view];
    
    if (!info || !info.length) {
        return nil;
    }
    
    if (!view) {
        return nil;
    }
    
    MBProgressHUD *hud = [[self alloc] initWithView:view];
    hud.removeFromSuperViewOnHide = YES;
    hud.userInteractionEnabled = NO;
    
    hud.mode = MBProgressHUDModeText;
    hud.bezelView.color = [UIColor blackColor];
    hud.contentColor = [UIColor whiteColor];
    hud.detailsLabel.text = info;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [view addSubview:hud];
        [hud showAnimated:YES];
        [hud hideAnimated:YES afterDelay:duration];
    });
        
    
    return hud;
}

+ (instancetype)vc_showDetailInfo:(NSString *)info addedTo:(UIView *)view {
    return [self vc_showDetailInfo:info addedTo:view duration:kHUDShowingDuration];
}

+ (instancetype)vc_showProgressBarWithMessage:(NSString *)message addedTo:(UIView *)view {
    [self vc_hideHUDForView:view];
    
    if (!view) {
        return nil;
    }

    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeDeterminateHorizontalBar;
    hud.label.text = message;
    
    return hud;
}

- (void)vc_updateProgressBarWithProgress:(float)progress message:(NSString *)message {
    
    self.progress = progress;
    self.label.text = message;
}

@end
