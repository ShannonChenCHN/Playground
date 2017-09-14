//
//  SCUserProfileViewController.m
//  ArchitecturePatternsExample
//
//  Created by ShannonChen on 2017/9/10.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import "SCUserProfileViewController.h"
#import "SCBlogTableViewController.h"
#import "SCDraftTableViewController.h"
#import "SCUserInfoViewController.h"

#import "UIView+SCLayout.h"

@interface SCUserProfileViewController ()
    
@property (strong, nonatomic) SCUserInfoViewController *userInfoController;
@property (strong, nonatomic) SCBlogTableViewController *blogController;
@property (strong, nonatomic) SCDraftTableViewController *draftController;

@end

@implementation SCUserProfileViewController
    
    
- (instancetype)initWithUserId:(NSString *)userId {
    if (self = [super init]) {
        _userId = userId;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    self.title = [NSString stringWithFormat:@"用户 %@", self.userId];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [self setupControllers];
    
    
    [self setupViews];
    
    
    [self setupModels];
    
}
    

    
- (void)setupControllers {
    
    self.userInfoController = [[SCUserInfoViewController alloc] initWithUserId:self.userId];
    
    self.blogController = [[SCBlogTableViewController alloc] initWithUserId:self.userId];
}
    
    
- (void)setupViews {
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.userInfoController.view.frame = CGRectMake(0, 0, self.view.width, 160);
    self.userInfoController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:self.userInfoController.view];
    
    
    self.blogController.view.frame = CGRectMake(0, self.userInfoController.view.bottom, self.view.width, self.view.height - self.userInfoController.view.height);
    self.blogController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:self.blogController.view];
}
    
- (void)setupModels {
    [self.userInfoController fetchDataWithCompletionHandler:nil];
    
    
    [self.blogController fetchDataWithCompletionHandler:nil];
}


@end
