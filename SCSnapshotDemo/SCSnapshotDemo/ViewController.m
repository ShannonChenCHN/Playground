//
//  ViewController.m
//  SCSnapshotDemo
//
//  Created by ShannonChen on 2017/3/19.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import "ViewController.h"
#import "SCPreviewViewController.h"
#import "SCWebViewController.h"

#import "SCSnapshotContent.h"
#import "SCSnapshotManager.h"

#import <MBProgressHUD.h>

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *generateButton;
@property (weak, nonatomic) IBOutlet UIButton *openWebViewButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.generateButton.layer.borderColor = [UIColor cyanColor].CGColor;
    self.generateButton.layer.borderWidth = 1;
    self.generateButton.layer.cornerRadius = 2;
    
    self.openWebViewButton.layer.borderColor = [UIColor blueColor].CGColor;
    self.openWebViewButton.layer.borderWidth = 1;
    self.openWebViewButton.layer.cornerRadius = 2;
    
    SCSnapshotContent *content = [[SCSnapshotContent alloc] init];
    content.posterName = @"ShannonChen";
    content.posterAvatarURLString = @"https://github.com/account";
    content.userTagDescription = @"iOS Developer/Reader/ESL Learner";
    content.textContent = @"Learn to survive, learn to live a _____ life.";
    content.likeCount = @"200";
    content.picUrls = @[];
    content.shareUrl = @"";
    content.shareDescription = @"";

    self.textField.text = @"https://github.com/ShannonChenCHN";
}

- (IBAction)generateSnapshot:(id)sender {
    if (!self.textField.text.length) {
        return;
    }
    
    [SCSnapshotManager generateSnapshotWithURLString:self.textField.text completionHander:^(UIImage * _Nullable snapshot, NSError * _Nullable error) {
        if (!error) {
            SCPreviewViewController *controller = [[SCPreviewViewController alloc] initWithSnapshot:snapshot];
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:controller];
            [self.navigationController presentViewController:navigationController animated:YES completion:NULL];
        }
        
    }];
}


- (IBAction)openWebView:(id)sender {
    if (!self.textField.text.length) {
        return;
    }
    
    SCWebViewController *controller = [[SCWebViewController alloc] initWithURLString:self.textField.text];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:controller];
    [self.navigationController presentViewController:navigationController animated:YES completion:NULL];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
