//
//  MBProgressHUD+Extension.h
//  YesIDo
//
//  Created by ShannonChen on 16/8/12.
//  Copyright © 2016年 YHouse. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>


@interface MBProgressHUD (Extension)

+ (instancetype)vc_showActivityIndicatorAddedTo:(UIView *)view;
+ (instancetype)vc_showActivityIndicatorWithMessage:(NSString *)message addedTo:(UIView *)view;

+ (BOOL)vc_hideHUDForView:(UIView *)view;

+ (instancetype)vc_showMessage:(NSString *)message addedTo:(UIView *)view;
+ (instancetype)vc_showMessage:(NSString *)message addedTo:(UIView *)view duration:(NSTimeInterval)duration;

+ (instancetype)vc_showDetailInfo:(NSString *)info addedTo:(UIView *)view;
+ (instancetype)vc_showDetailInfo:(NSString *)info addedTo:(UIView *)view duration:(NSTimeInterval)duration;

@end
