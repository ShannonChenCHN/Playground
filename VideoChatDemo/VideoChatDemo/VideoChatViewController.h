//
//  VideoChatViewController.h
//  VideoChatDemo
//
//  Created by ShannonChen on 2017/1/6.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoChatViewController : UIViewController

@property (strong, nonatomic) NSString *callerId;
@property (strong, nonatomic) NSString *targetId;
@property (assign, nonatomic) BOOL isCaller;

@end
