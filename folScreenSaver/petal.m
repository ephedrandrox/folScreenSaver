//
//  petal.m
//  folScreenSaver
//
//  Created by Blake Glanville on 11/29/18.
//  Copyright © 2018 Blake Glanville. All rights reserved.
//

#import "petal.h"

@implementation Petal
- (instancetype)init: (CGRect) viewRect
{
    self = [super init];
    if (self) {
        
        
        self.Xoffset = 0;
        self.Yoffset = 0;
        
        self.RedOffset = .5;
        self.GreenOffset = .5;
        self.BlueOffset = .5;
        self.AlphaOffset = .5;
        
        
        self.viewRect = viewRect;
        
        self.centerOfView = NSMakePoint(self.viewRect.size.width/2, self.viewRect.size.height/2);
        
        self.petalDiameter = viewRect.size.height/6;
        self.petalRadius = (self.petalDiameter/2);
        
        self.Xoffset -=self.petalRadius;
        self.Yoffset -=self.petalRadius;
        
       
        
       
        
        NSLog(@"FOL: Diameter; %i Radius: %i" , (int)self.petalDiameter,(int) self.petalRadius);
        /* red = SSRandomFloatBetween(0.0, 255.0);
         green = SSRandomFloatBetween(0.0, 255.0);
         blue = SSRandomFloatBetween(0.0, 255.0);
         alpha = SSRandomFloatBetween( 0.0, 255.0);*/
    }
    return self;
}

 -(instancetype) initWithParent:(Petal *)creatorPetal
{
    
   // NSLog(@"FOL: New Init With Parent");
    
    self = [self init: creatorPetal.viewRect];
    self.id = creatorPetal.id+1;
    
    
    if(self){
        
        
        self.previousePetal = creatorPetal;
        self.flowerDepth = creatorPetal.flowerDepth;
        self.petalDepth = creatorPetal.petalDepth;
        self.directionArrayIndex = creatorPetal.directionArrayIndex;
        
        if(creatorPetal.stepsToTurn == 0)//Needs to turn an angle or advance a depth
        {
             if (creatorPetal.directionArrayIndex == 5)
                 //needs to advance a depth instead of turn an angle or be done
             {
                  if(creatorPetal.petalDepth == self.flowerDepth)
                      //already deep enough
                  {
                      NSLog(@"FOL: returning cause yeagh");
                      return nil;
                  }
                  else
                  {
                      NSLog(@"FOL: Starting new Depth");

                      
                      
                      self.petalDepth++;
                      self.stepsToTurn = self.petalDepth-1;
                      self.directionArrayIndex = 0;
                      
                     
                      self.Yoffset -= self.petalDepth*self.petalRadius;
                      
                    
                      
                      self.nextPetal = [[Petal alloc] initWithParent:self];

                      
                  }
             }
             else
             {
                 //turning angle, resetting steps to next angle
                 
                 NSLog(@"FOL: Turning Angle");
                 self.stepsToTurn = self.petalDepth-1;
                 
                 
                
                 
                 float xtry = (cos(angleArray[ self.directionArrayIndex]*(M_PI/180)) *self.petalRadius)+creatorPetal.Xoffset; //plus last x
                 float ytry = (sin(angleArray[ self.directionArrayIndex]*(M_PI/180)) *self.petalRadius) + creatorPetal.Yoffset; // +plus lasgt y
                 
                 self.Xoffset = xtry;
                 self.Yoffset = ytry;
                 self.directionArrayIndex++;

                 self.nextPetal = [[Petal alloc] initWithParent:self];

             }
        }
        else{
            //needs to advance one step on same angle
            NSLog(@"FOL: Advancing at current angle ");
            
            float xtry = (cos(angleArray[ self.directionArrayIndex]*(M_PI/180)) *self.petalRadius)+creatorPetal.Xoffset; //plus last x
            float ytry = (sin(angleArray[ self.directionArrayIndex]*(M_PI/180)) *self.petalRadius)+creatorPetal.Yoffset; // +plus lasgt y
            
           // float xtry = sinf(90 / 180 * M_PI);
          
            NSLog(@"FOL: xtry:%f ytry: %f ", xtry, ytry);
            
            self.stepsToTurn = creatorPetal.stepsToTurn - 1;
            
            self.Xoffset = xtry;
            self.Yoffset = ytry;
            
           
            
            //self.Yoffset = self.petalDepth*self.petalRadius;
            
           // self.Xoffset += self.petalRadius* self.stepsToTurn;
            
            self.nextPetal = [[Petal alloc] initWithParent:self];

        }
          //  self.nextPetal = [[Petal alloc] initWithParent:self];
            
        
       
    }
    return self;
}


-(instancetype) initFirstInList:(int)flowerDepth
                       viewRect:(CGRect)viewRect
{
    NSLog(@"FOL: New Init First In list");
//calculate size of petal to pass on
    
    self = [self init: viewRect];
    if(self){
        self.id = 0;
        self.flowerDepth = flowerDepth;
        self.petalDepth = 0;
        self.stepsToTurn = 0;
        self.directionArrayIndex = 5;
        

       
        
        if(flowerDepth>0)
            self.nextPetal = [[Petal alloc] initWithParent:self];
    }
    return self;
}
-(void) drawPetal:(CGContextRef) CGContext
{
    
   /*
    if(self.petalPath == nil)
    {
        NSLog(@"FOL: Path nil, creating new ");
        
        NSRect circle;
        
        
        
        circle.size = NSMakeSize(self.petalDiameter, self.petalDiameter);
        circle.origin = NSMakePoint(self.centerOfView.x+self.Xoffset, self.centerOfView.y+self.Yoffset);
        
        
        
        self.petalPath = [NSBezierPath bezierPathWithOvalInRect:circle];
    }
    else
    {
        NSLog(@"FOL: Path not nil, not creating new ");
        
    }
    
    self.petalColor = [NSColor colorWithCalibratedRed:self.RedOffset green:self.GreenOffset blue:self.BlueOffset alpha:self.AlphaOffset];
    
    [self.petalColor set];
    
  
    [self.petalPath fill];
  
    [self.petalPath stroke];
    

   NSString *idString =[NSString stringWithFormat:@" %i:%i:%i", self.id, self.stepsToTurn, self.directionArrayIndex];
    
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[NSFont fontWithName:@"Helvetica" size:12], NSFontAttributeName,[NSColor whiteColor], NSForegroundColorAttributeName, nil];
    
    
    NSAttributedString * currentText=[[NSAttributedString alloc] initWithString:idString attributes: attributes];
    
    // NSSize attrSize = [currentText size];
    [currentText drawAtPoint:circle.origin];
    
  
    
    
    
    CGContextSetRGBFillColor (CGContext, 1, 0, 0, 1);// 3
    CGContextFillRect (CGContext, CGRectMake (200, 0, 200, 100 ));// 4
    CGContextSetRGBFillColor (CGContext, 0, 0, 1, .5);// 5
    CGContextFillRect (CGContext, CGRectMake (100, 0, 100, 200));
     */
    CGContextSetRGBStrokeColor(CGContext, self.RedOffset, self.GreenOffset, self.BlueOffset, self.AlphaOffset);
    CGContextSetRGBFillColor (CGContext, self.RedOffset, self.GreenOffset, self.BlueOffset, self.AlphaOffset);// 5
    //CGContextFillRect (CGContext, CGRectMake (self.centerOfView.x+self.Xoffset,self.centerOfView.y+self.Yoffset, self.petalDiameter, self.petalDiameter));
    //CGContextAddArc(CGContext, 100, 100, 400, 0, M_PI*2, YES);
    //CGContextSetRGBFillColor (CGContext, 0, 0, 1, .5);// 5    
    CGContextFillEllipseInRect(CGContext, CGRectMake (self.centerOfView.x+self.Xoffset,self.centerOfView.y+self.Yoffset, self.petalDiameter, self.petalDiameter));
    
   // CGContextSetRGBFillColor (CGContext, self.RedOffset, self.GreenOffset, self.BlueOffset, self.AlphaOffset);// 5
    //CGContextFillRect (CGContext, CGRectMake (self.centerOfView.x+self.Xoffset,self.centerOfView.y+self.Yoffset, self.petalDiameter, self.petalDiameter));
    
   // CGContextAddArc(CGContext, 100, 1000, 400, 0, M_PI*2, YES);
    
    if (self.nextPetal)
    {
        [self.nextPetal drawPetal: CGContext];
    }
    
    return;
}
-(void) transformNextFrameProperties
{
    
    
    
    self.BlueOffset = [self randomCGFloatOffsetChange: self.BlueOffset];
    
    self.RedOffset =   [self randomCGFloatOffsetChange: self.RedOffset];
    
    self.GreenOffset =   [self randomCGFloatOffsetChange: self.GreenOffset];
    
    if (self.nextPetal)
    {
        [self.nextPetal transformNextFrameProperties];
    }
    
    return;
}
-(CGFloat) randomCGFloatOffsetChange: (CGFloat) offset
{
    
    if(SSRandomIntBetween(0, 1) == 1)
    {
        offset = offset + .005;
        
    }else{
        offset = offset - .005;
        
    }
    
    
    if(offset > 1)
        offset = 1;
    if(offset < 0)
        offset = 0;
    
    return offset;
}
@end
