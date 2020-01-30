//
//  folScreenSaverView.h
//  folScreenSaver
//
//  Created by Blake Glanville on 11/29/18.
//  Copyright © 2018 Blake Glanville. All rights reserved.
//

#import <ScreenSaver/ScreenSaver.h>
#import <CoreGraphics/CoreGraphics.h>
#import "flower.h"

@interface folScreenSaverView : ScreenSaverView

@property CGContextRef CGContext;

@property Flower *mainFlower;


@end
