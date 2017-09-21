//
//  SCUserSelfProfileViewController.m
//  ArchitecturePatternsExample
//
//  Created by ShannonChen on 2017/9/10.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import "SCUserSelfProfileViewController.h"
#import "SCUserProfileViewController_Private.h"

#import "SCDraftTableViewController.h"

@interface SCUserSelfProfileViewController ()

@property (strong, nonatomic) SCDraftTableViewController *draftController;

@end

@implementation SCUserSelfProfileViewController
    
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        self.userId = kCurrentUserId;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我";
    
}



@end
