//
//  SpaceShip.m
//  Asteroids
//
//  Created by Diana Zmuda on 8/23/12.
//  Copyright (c) 2012 JJ Weber. All rights reserved.
//

#import "SpaceShip.h"
#import <QuartzCore/QuartzCore.h>

@implementation SpaceShip
@synthesize layer;
+ (SpaceShip*) drawSpaceShipAt:(CGPoint) position In:(UIView*) view {
    SpaceShip* newShip = [SpaceShip new];
    newShip.layer = [CALayer new];
    newShip.layer.bounds = CGRectMake(0, 0, 50, 50);
    newShip.layer.backgroundColor = CGColorCreateCopyWithAlpha([[UIColor blueColor] CGColor], 0);
    newShip.layer.position = position;
    newShip.layer.delegate = newShip;
    [newShip.layer setNeedsDisplay];
    [view.layer addSublayer:newShip.layer];
    return newShip;
}
- (void) drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
    //create the triangle with curve
    CGContextMoveToPoint(ctx, 0, layer.bounds.size.height);
    CGContextAddLineToPoint(ctx, layer.bounds.size.width/2, 0);
    CGContextAddLineToPoint(ctx, layer.bounds.size.width, layer.bounds.size.height);
    CGContextAddLineToPoint(ctx, 0, layer.bounds.size.height);
    
    CGContextSetStrokeColorWithColor(ctx, [[UIColor whiteColor] CGColor]);
    CGContextStrokePath(ctx);
}



@end
