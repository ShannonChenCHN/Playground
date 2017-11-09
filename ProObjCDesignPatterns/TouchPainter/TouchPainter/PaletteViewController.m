//
//  PaletteViewController.m
//  TouchPainter
//
//  Created by ShannonChen on 2017/10/30.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import "PaletteViewController.h"
#import "SetStrokeColorCommandDelegate.h"

@interface PaletteViewController () <SetStrokeColorCommandDelegate>

@property (weak, nonatomic) IBOutlet UISlider *redSlider;
@property (weak, nonatomic) IBOutlet UISlider *greenSlider;
@property (weak, nonatomic) IBOutlet UISlider *blueSlider;

@property (weak, nonatomic) IBOutlet UIView *paletteView;

@property (weak, nonatomic) IBOutlet UISlider *strokeSlider;

@end

@implementation PaletteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self updateColor];
}

- (void)updateColor {

    self.paletteView.backgroundColor = self.strokeColor;

    self.strokeSlider.tintColor = self.strokeColor;
    self.strokeSlider.minimumTrackTintColor = self.strokeColor;
    
    CGFloat redValue = 0.0;
    CGFloat greenValue = 0.0;
    CGFloat blueValue = 0.0;
    [self.strokeColor getRed:&redValue green:&greenValue blue:&blueValue alpha:NULL];
    
    self.redSlider.value = redValue;
    self.greenSlider.value = greenValue;
    self.blueSlider.value = blueValue;
}

- (IBAction)onCommandSliderValueChanged:(id)sender {


}


@end
