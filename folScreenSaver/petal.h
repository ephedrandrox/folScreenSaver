//
//  petal.h
//  folScreenSaver
//
//  Created by Blake Glanville on 11/29/18.
//  Copyright © 2018 Blake Glanville. All rights reserved.
//

#ifndef petal_h
#define petal_h


#import <Foundation/Foundation.h>
#import <ScreenSaver/ScreenSaver.h>

//static int angleArray[] =   {30,90,150,210,270,330};
//static int angleArray[] =   {330,270,210,150,90,30};
//static int angleArray[] =   {210,150,90,30,330,270};
static int angleArray[] =   {150,90,30,330,270,210};

//static int angleArray2[] =   {270,330,30,90,150,210};



@interface Petal : NSObject
@property int id;

@property NSArray* angleArray;

@property NSBezierPath* petalPath;
@property NSColor* petalColor;



@property NSPoint centerOfView;

@property CGFloat petalDiameter;
@property int petalRadius;

@property int flowerDepth;
@property int petalDepth;
@property int stepsToTurn;
@property int directionArrayIndex;

@property CGFloat Xoffset;

@property CGFloat Yoffset;

@property CGFloat RedOffset;
@property CGFloat BlueOffset;
@property CGFloat GreenOffset;
@property CGFloat AlphaOffset;


@property CGRect viewRect;


@property Petal *previousePetal;
@property Petal *nextPetal;


-(instancetype) init: (CGRect) viewRect;
-(instancetype) initWithParent:(Petal*) creatorPetal;

-(instancetype) initFirstInList: (int) flowerDepth
                       viewRect: (CGRect) viewRect;

-(void) drawPetal: (CGContextRef) CGContext;

-(void) transformNextFrameProperties;

-(CGFloat) randomCGFloatOffsetChange: (CGFloat) offset;



@end

#endif /* petal_h */

