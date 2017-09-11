//
//  SCDraftTableViewController.h
//  ArchitecturePatternsExample
//
//  Created by ShannonChen on 2017/9/11.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 草稿箱模块的 controller
 */
@interface SCDraftTableViewController : UITableViewController

    
- (void)fetchDataWithCompletionHandler:(void(^)(NSError *error, id result))completion;
    
@end
