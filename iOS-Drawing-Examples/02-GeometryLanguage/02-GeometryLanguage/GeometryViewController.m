//
//  GeometryViewController.m
//  02-GeometryLanguage
//
//  Created by ShannonChen on 2016/10/13.
//  Copyright © 2016年 YHouse. All rights reserved.
//

#import "GeometryViewController.h"

#import "GeometryView.h"

@interface GeometryViewController ()

@property (assign, nonatomic) NSInteger index;

@end

@implementation GeometryViewController

- (instancetype)initWithIndex:(NSInteger)index {
    self = [super init];
    if (self) {
        _index = index;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)loadView {
    GeometryView *view = [[GeometryView alloc] initWithIndex:self.index];
    view.backgroundColor = [UIColor whiteColor];
    self.view = view;
}

@end
