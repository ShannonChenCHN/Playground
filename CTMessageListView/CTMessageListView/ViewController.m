//
//  ViewController.m
//  CTMessageListView
//
//  Created by ShannonChen on 2018/6/27.
//  Copyright © 2018年 ShannonChen. All rights reserved.
//

#import "ViewController.h"
#import "CTHotelMessageListView.h"

#define kScreenWidth  [UIScreen mainScreen].bounds.size.width

@interface ViewController ()

@property (nonatomic, strong) NSArray *tags;
@property (nonatomic, strong) NSMutableArray <NSString *> *messages;

@property (nonatomic, strong) CTHotelMessageListView *listView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.tags = @[@"excellent", @"cool", @"good", @"soso", @"same old same old"];
    self.messages = @[@"I'm Chinese", @"Shanghai is a beautiful city", @"He is wired", @"It's ok to make a mistake"].mutableCopy;
    
    CGFloat leftRightMargin = 15;
    self.listView = [[CTHotelMessageListView alloc] initWithFrame:CGRectMake(leftRightMargin, 100, self.view.frame.size.width - leftRightMargin * 2, 100)];
    _listView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:_listView];
    _listView.backgroundColor = [UIColor redColor];
    
    _listView.lineSpacing = 5;
    _listView.interitemSpacing = 10;
    _listView.padding = UIEdgeInsetsMake(10, 15, 10, 15);
    
    __weak typeof(self) weakSelf = self;
    _listView.numberOfCellsInListView = ^NSInteger(CTHotelMessageListView *listView) {
        return weakSelf.messages.count;
    };
    _listView.createCellIfNeededAtIndex = ^__kindof UIView *(CTHotelMessageListView *listView, NSInteger index) {
        return [[UILabel alloc] init];
    };
    
    _listView.willDisplayCell = ^(CTHotelMessageListView *listView, __kindof UILabel *cell, NSInteger index) {
        cell.text = weakSelf.messages[index];
        cell.backgroundColor = [UIColor blueColor];
        cell.textColor = [UIColor whiteColor];
        cell.font = [UIFont systemFontOfSize:16];
    };
    
    _listView.sizeForCellAtIndex = ^CGSize(CTHotelMessageListView *listView, NSInteger index) {
        NSString *text = weakSelf.messages[index];
        CGRect rect = [text boundingRectWithSize:CGSizeMake(listView.bounds.size.width - 20, 100) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16]} context:nil];
        return rect.size;
    };
    
    
    [_listView reloadData];
    
}


- (IBAction)refresh:(id)sender {
    static BOOL flag = NO;
    flag = !flag;
    if (flag) {
        [_messages addObjectsFromArray:_tags];
    } else {
        [_messages removeObjectsInArray:_tags];
        
        NSMutableArray *array = @[].mutableCopy;
        for (NSString *text in _messages.reverseObjectEnumerator) {
            [array addObject:text];
        }
        _messages = array;
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        [_listView reloadData];
    }];
    
}


@end
