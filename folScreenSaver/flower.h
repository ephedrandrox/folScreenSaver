//
//  flower.h
//  folScreenSaver
//
//  Created by Blake Glanville on 11/30/18.
//  Copyright © 2018 Blake Glanville. All rights reserved.
//

#ifndef flower_h
#define flower_h

#import <Foundation/Foundation.h>
#import "petal.h"

@interface Flower : NSObject
@property int id;

@property NSRect viewBounds;
@property int frameCount;

@property Petal *firstPetal;

//make a block code that sets petal in pointer array each time one is created


-(instancetype) initWithView:(NSRect) viewRect;

-(void) drawFlower:(CGContextRef) CGContext;

@end
#endif /* flower_h */
