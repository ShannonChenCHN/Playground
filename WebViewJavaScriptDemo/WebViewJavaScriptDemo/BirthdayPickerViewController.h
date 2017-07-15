//
//  BirthdayPickerViewController.h
//  WebViewJavaScriptDemo
//
//  Created by ShannonChen on 2017/7/4.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BirthdayPickerViewController : UIViewController
    
@property (copy, nonatomic) void(^completionHandler)(NSString *birthday);

@end
