//
//  CustomModel.m
//  NSArrayDemo
//
//  Created by ShannonChen on 2017/9/14.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import "CustomModel.h"

@implementation CustomModel

- (id)copyWithZone:(NSZone *)zone {
    CustomModel *model = [[CustomModel allocWithZone:zone] init];
    model->_flag = _flag;
    model->_name = [_name copyWithZone:zone];
    
    return model;
}

@end
