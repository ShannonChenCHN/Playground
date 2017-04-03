//
//  ViewController.m
//  VideoChatDemo
//
//  Created by ShannonChen on 2017/1/6.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import "ViewController.h"
#import "VideoChatViewController.h"

#import "IMManager.h"
#import "MBProgressHUD+Extension.h"

@interface ViewController ()

@end

@implementation ViewController

+ (XLFormDescriptor *)initialForm {
    XLFormDescriptor * form;
    XLFormSectionDescriptor * section;
    XLFormRowDescriptor * row;
    
    form = [XLFormDescriptor formDescriptor];
    
    section = [XLFormSectionDescriptor formSectionWithTitle:nil];
    [form addFormSection:section];
    
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"caller" rowType:XLFormRowDescriptorTypeButton title:@"caller"];
    row.action.formSelector = @selector(startChatAction:);
    [section addFormRow:row];
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"receiver" rowType:XLFormRowDescriptorTypeButton title:@"receiver"];
    row.action.formSelector = @selector(startChatAction:);
    [section addFormRow:row];
    
    return form;
}

- (instancetype)init {
    return [super initWithForm:[ViewController initialForm] style:UITableViewStylePlain];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navigationItem.title = @"Chat Room";
    
       
}

- (void)startChatAction:(XLFormRowDescriptor *)form {
    
    NSDictionary *userInfo =
    @{@"caller" : @{@"token" : @"tUQoUkMEqzt2+7uhQceU4CSAWtogXCUHKakWtaDqCgnZANTqxOeoNDxs75Y4s5bxelYwLLCyHiLQiPVTWqH0ualsaJDhuR3MvBx6oG8lcW9dW1yhiqwaN/0H++rDY6ygjAh6yVTkFsU=",
                    @"callerId" : @"594734409F2D8D5EE1B54C4BEBC73A0D",
                    @"targetId" : @"7722352545C54D45E1B54C4BEBC73A0D",
                    @"isCaller" : @(YES)}, // 小菲菲
      @"receiver" : @{@"token" : @"Gjl4zf8gXJE2HhUgOwZh2Cdiy2zF0LAwZKaiCWphdHHhzlceX9qWdA5V1kYzTQd4yvag1D4vsBqHJMTSoO7zZ3UM0TbntDFd27dCwfLEu2AiOJAXCvYpI7D6v1bT6XBI",
                      @"callerId" : @"7722352545C54D45E1B54C4BEBC73A0D",
                      @"targetId" : @"594734409F2D8D5EE1B54C4BEBC73A0D",
                      @"isCaller" : @(NO)}  // Mr.white
      };
    
    [MBProgressHUD vc_showActivityIndicatorWithMessage:@"正在登录..." addedTo:self.view];
    
    
    __weak typeof(self) weakSelf = self;
    [[IMManager sharedManager] loginWithRongCloudToken:userInfo[form.tag][@"token"] completion:^(BOOL success) {
        [MBProgressHUD vc_hideHUDForView:weakSelf.view];
        
        NSTimeInterval delayTime = 0.5;
        [MBProgressHUD vc_showMessage:success ? @"登录成功" : @"登录失败" addedTo:weakSelf.view duration:delayTime];
        
        if (success) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                VideoChatViewController *videoChatViewController = [[VideoChatViewController alloc] init];
                videoChatViewController.callerId = userInfo[form.tag][@"callerId"];
                videoChatViewController.targetId = userInfo[form.tag][@"targetId"];
                videoChatViewController.isCaller = [userInfo[form.tag][@"isCaller"] boolValue];
                
                [weakSelf presentViewController:videoChatViewController animated:YES completion:NULL];
            });
        }
        
    }];
    
}


@end
