//
//  ViewController.m
//  CTMessageListView
//
//  Created by ShannonChen on 2018/6/27.
//  Copyright © 2018年 ShannonChen. All rights reserved.
//

#import "ViewController.h"
#import "CTMessageListView.h"

#define kScreenWidth  [UIScreen mainScreen].bounds.size.width

@interface ViewController ()

@property (nonatomic, strong) NSArray *tags;
@property (nonatomic, strong) NSMutableArray <NSString *> *messages;

@property (nonatomic, strong) CTMessageListView *listView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.tags = @[@"excellent", @"cool", @"good", @"soso"];
    self.messages = @[@"I'm Chinese", @"Shanghai is a beautiful city", @"He is wired"].mutableCopy;
    
    self.listView = [[CTMessageListView alloc] initWithFrame:CGRectMake(15, 100, self.view.frame.size.width, 100)];
    _listView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:_listView];
    _listView.backgroundColor = [UIColor redColor];
    
    _listView.models = _messages;
    [_listView reloadData];
}


- (IBAction)refresh:(id)sender {
    static BOOL flag = NO;
    flag = !flag;
    if (flag) {
        [_messages addObjectsFromArray:_tags];
    } else {
        [_messages removeObjectsInArray:_tags];
    }
    
    [_listView reloadData];
}


@end
