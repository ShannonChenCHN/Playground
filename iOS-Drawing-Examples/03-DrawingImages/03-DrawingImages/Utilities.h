//
//  Utilities.h
//  03-DrawingImages
//
//  Created by ShannonChen on 2016/10/18.
//  Copyright © 2016年 YHouse. All rights reserved.
//

#import <UIKit/UIKit.h>



//________________________ Rectangle Utilities ____________________________________
CGRect SizeMakeRect(CGSize size);

CGRect RectMakeRect(CGPoint origin, CGSize size);

CGPoint RectGetCenter(CGRect rect);

CGRect RectAroundCenter(CGPoint center, CGSize size);

CGRect RectCenteredInRect(CGRect rect, CGRect mainRect);

CGRect RectInsetByPercent(CGRect destinationRect, CGFloat insetPercent);


//________________________ Calculating a Destination by Fitting to a Rectangle _____________________

// Multiply the size components by the factor
CGSize SizeScaleByFactor(CGSize aSize, CGFloat factor);

// Calculate scale for fitting a size to a destination
CGFloat AspectScaleFit(CGSize sourceSize, CGRect destRect);

// Return a rect fitting a source to a destination
CGRect RectByFittingInRect(CGRect sourceRect, CGRect destinationRect);


//________________________ Calculating a Destination by Filling a Rectangle _____________________

// Calculate scale for filling a destination
CGFloat AspectScaleFill(CGSize sourceSize, CGRect destRect);

// Return a rect that fills the destination
CGRect RectByFillingRect(CGRect sourceRect, CGRect destinationRect);

