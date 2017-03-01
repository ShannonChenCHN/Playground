//
//  SCGPUImageView.h
//  GPUImageDemo
//
//  Created by ShannonChen on 2017/1/20.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCGPUImageContext.h"

typedef NS_ENUM(NSUInteger, SCGPUImageFillModeType) {
    kSCGPUImageFillModeStretch,                       // Stretch to fill the full view, which may distort the image outside of its normal aspect ratio
    kSCGPUImageFillModePreserveAspectRatio,           // Maintains the aspect ratio of the source image, adding bars of the specified background color
    kSCGPUImageFillModePreserveAspectRatioAndFill     // Maintains the aspect ratio of the source image, zooming in on its center to fill the view
};


@interface SCGPUImageView : UIView <SCGPUImageInput> {
    SCGPUImageRotationMode inputRotation;

}

@property(nonatomic) BOOL enabled;

/** The fill mode dictates how images are fit in the view, with the default being kGPUImageFillModePreserveAspectRatio
 */
@property(readwrite, nonatomic) SCGPUImageFillModeType fillMode;

/** This calculates the current display size, in pixels, taking into account Retina scaling factors
 */
@property(readonly, nonatomic) CGSize sizeInPixels;


@end
