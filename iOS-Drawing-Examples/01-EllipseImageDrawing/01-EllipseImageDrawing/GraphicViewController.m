//
//  GraphicViewController.m
//  01-EllipseImageDrawing
//
//  Created by ShannonChen on 16/10/5.
//  Copyright © 2016年 YHouse. All rights reserved.
//

#import "GraphicViewController.h"
#import "GraphicImageView.h"
#import "GraphicView.h"

@interface GraphicViewController ()

@property (strong, nonatomic) GraphicImageView *graphicImageView;
@property (strong, nonatomic) GraphicView *graphicView;
@property (assign, nonatomic) NSInteger index;

@end

@implementation GraphicViewController

- (instancetype)initWithIndex:(NSInteger)index {
    if (self = [super initWithNibName:nil bundle:nil]) {
        _index = index;
        
        self.graphicImageView = [[GraphicImageView alloc] initWithIndex:index];
        self.graphicImageView.backgroundColor = [UIColor whiteColor];
        
        self.graphicView = [[GraphicView alloc] initWithIndex:index];
        self.graphicView.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)loadView {
    if (self.index >= 3) {
        self.view = self.graphicView;
    }
    else {
        self.view = self.graphicImageView;
    }
    
}

@end
