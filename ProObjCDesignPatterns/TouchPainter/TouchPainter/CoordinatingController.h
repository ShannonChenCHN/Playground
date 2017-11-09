//
//  CoordinatingController.h
//  TouchPainter
//
//  Created by ShannonChen on 2017/10/30.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ViewController;
@class PaletteViewController;

@interface CoordinatingController : NSObject 


+ (instancetype)sharedInstance;


@property (nonatomic, weak) ViewController *canvasViewController;

@end
