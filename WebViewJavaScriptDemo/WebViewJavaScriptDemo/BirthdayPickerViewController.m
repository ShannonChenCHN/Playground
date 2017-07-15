//
//  BirthdayPickerViewController.m
//  WebViewJavaScriptDemo
//
//  Created by ShannonChen on 2017/7/4.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import "BirthdayPickerViewController.h"

@interface BirthdayPickerViewController () 
    
@property (weak, nonatomic) IBOutlet UILabel *birthdayLabel;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@end

@implementation BirthdayPickerViewController
    

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem.enabled = NO;

}
    
    
- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        if (self.completionHandler) {
            self.completionHandler(nil);
        }
    }];
}
    
- (IBAction)done:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        if (self.completionHandler) {
            self.completionHandler(self.birthdayLabel.text);
        }
    }];
}
    
- (IBAction)didSelectDate:(id)sender {
    
    self.navigationItem.rightBarButtonItem.enabled = YES;
    
    //用于格式化NSDate对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设置格式：zzz表示时区
    [dateFormatter setDateFormat:@"yyyy/MM/dd"];
    //NSDate转NSString
    NSString *dateString = [dateFormatter stringFromDate:self.datePicker.date];
    
    self.birthdayLabel.text = dateString;
}

@end
