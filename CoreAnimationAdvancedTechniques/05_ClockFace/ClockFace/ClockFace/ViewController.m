//
//  ViewController.m
//  ClockFace
//
//  Created by ShannonChen on 2016/11/27.
//  Copyright © 2016年 ShannonChen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *hourHand;
@property (weak, nonatomic) IBOutlet UIImageView *minHand;
@property (weak, nonatomic) IBOutlet UIImageView *secHand;
@property (weak, nonatomic) NSTimer *timer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //adjust anchor points, default is (0.5, 0.5), so we need to move hands up
    self.secHand.layer.anchorPoint = CGPointMake(0.5f, 0.8f);
    self.minHand.layer.anchorPoint = CGPointMake(0.5f, 0.8f);
    self.hourHand.layer.anchorPoint = CGPointMake(0.5f, 0.8f);
    
    //start timer
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                  target:self
                                                selector:@selector(tick)
                                                userInfo:nil
                                                 repeats:YES];
    
    //set initial hand positions
    [self tick];
}

- (void)tick
{
    //convert time to hours, minutes and seconds
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    NSUInteger units = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *components = [calendar components:units fromDate:[NSDate date]];
    
    //calculate hour hand angle
    CGFloat hourAngle = (components.hour / 12.0) * M_PI * 2.0;
    
    //calculate minute hand angle
    CGFloat minuteAngle = (components.minute / 60.0) * M_PI * 2.0;
    
    //calculate second hand angle
    CGFloat secondAngle = (components.second / 60.0) * M_PI * 2.0;
    
    //rotate hands
    self.hourHand.transform = CGAffineTransformMakeRotation(hourAngle);
    self.minHand.transform = CGAffineTransformMakeRotation(minuteAngle);
    self.secHand.transform = CGAffineTransformMakeRotation(secondAngle);
}


@end
