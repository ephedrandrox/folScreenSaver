//
//  flower.m
//  folScreenSaver
//
//  Created by Blake Glanville on 11/30/18.
//  Copyright © 2018 Blake Glanville. All rights reserved.
//

#import "flower.h"

@implementation Flower

-(instancetype) initWithView:(NSRect)viewRect
{
    self = [super self];
    if(self){
        self.viewBounds = viewRect;
        self.frameCount = 0;
        self.firstPetal = [[Petal alloc] initFirstInList:6 viewRect:viewRect];
    }
    return self;
}

-(void) drawFlower:(CGContextRef) CGContext
{
    
    self.frameCount++;
    
    [self.firstPetal transformNextFrameProperties];
    
    [self.firstPetal drawPetal: CGContext];
    NSString *theViewSize =[NSString stringWithFormat:@"Rect Size:\n Width: %1.f \n Height: %1.f \n Frame: %d", self.viewBounds.size.width, self.viewBounds.size.height, self.frameCount];
    
    //note we are using the convenience method, so we don't need to autorelease the object
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[NSFont fontWithName:@"Helvetica" size:24], NSFontAttributeName,[NSColor whiteColor], NSForegroundColorAttributeName, nil];
    
    NSAttributedString * currentText=[[NSAttributedString alloc] initWithString:theViewSize attributes: attributes];
    
   // NSSize attrSize = [currentText size];
    [currentText drawAtPoint:NSMakePoint(0, 0)];
    
  
    
}

@end
