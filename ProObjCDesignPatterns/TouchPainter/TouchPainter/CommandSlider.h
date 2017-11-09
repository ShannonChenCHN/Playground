//
//  CommandSlider.h
//  TouchPainter
//
//  Created by ShannonChen on 2017/10/31.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Command.h"

@interface CommandSlider : UISlider

@property (nonatomic, strong) IBOutlet Command *command;

@end
