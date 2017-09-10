//
//  ImageViewController.m
//  03-DrawingImages
//
//  Created by ShannonChen on 2016/10/13.
//  Copyright © 2016年 YHouse. All rights reserved.
//

#import "ImageViewController.h"

#import "MyImageView.h"
#import "MyGraphicView.h"

@interface ImageViewController ()

@property (assign, nonatomic) NSInteger index;

@end

@implementation ImageViewController

- (instancetype)initWithIndex:(NSInteger)index {
    self = [super init];
    if (self) {
        _index = index;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
}

- (void)loadView {
    switch (self.index) {
        case 0:
        case 1:
        case 2: {
            MyImageView *imageView = [[MyImageView alloc] initWithIndex:self.index];
            imageView.backgroundColor = [UIColor grayColor];
            self.view = imageView;
        }
            break;
        case 3:
        case 4:{
            MyGraphicView *imageView = [[MyGraphicView alloc] initWithIndex:self.index];
            imageView.backgroundColor = [UIColor grayColor];
            self.view = imageView;
        }
            break;
            
        default: {
            [super loadView];
        }
            break;
    }
    
}


@end
