//
//  folScreenSaverView.m
//  folScreenSaver
//
//  Created by Blake Glanville on 11/29/18.
//  Copyright © 2018 Blake Glanville. All rights reserved.
//

#import "folScreenSaverView.h"

@implementation folScreenSaverView

- (instancetype)initWithFrame:(NSRect)frame isPreview:(BOOL)isPreview
{
    self = [super initWithFrame:frame isPreview:isPreview];
    if (self) {
        [self setAnimationTimeInterval:1/30];
        
        
        self.mainFlower = [[Flower alloc] initWithView:(NSRect) frame];
    }
    return self;
}

- (void)startAnimation
{
    [super startAnimation];
}

- (void)stopAnimation
{
    [super stopAnimation];
}
- (void)drawRect:(NSRect)rect
{
    CGContextRef CGContext = [[NSGraphicsContext currentContext] CGContext];
    
    
    [super drawRect:rect];
 
    [self.mainFlower drawFlower: CGContext];
}

- (void)animateOneFrame
{
   
    [self setNeedsDisplayInRect:[self bounds]];
    
 
}

- (BOOL)hasConfigureSheet
{
    return NO;
}

- (NSWindow*)configureSheet
{
    return nil;
}

@end
