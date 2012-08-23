//
//  Asteroid.m
//  Asteroids
//
//  Created by JJ Weber on 8/23/12.
//  Copyright (c) 2012 JJ Weber. All rights reserved.
//

#import "Asteroid.h"
#import <QuartzCore/QuartzCore.h>

@interface Asteroid ()
@property CALayer* layer;
@end

@implementation Asteroid
@synthesize layer;
+ (Asteroid*) createAsteroidAtPosition:(CGPoint)position withView:(UIView *)view {
    Asteroid* newRoid = [Asteroid new];
    newRoid.layer = [CALayer new];
    newRoid.layer.bounds = CGRectMake(0, 0, 100, 100);
    newRoid.layer.backgroundColor = CGColorCreateCopyWithAlpha([[UIColor blueColor] CGColor], 0);
    newRoid.layer.position = position;
    newRoid.layer.delegate = newRoid;
    [newRoid.layer setNeedsDisplay];
    [view.layer addSublayer:newRoid.layer];
    return newRoid;
}

- (void) drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
    CGContextSetStrokeColorWithColor(ctx, [[UIColor whiteColor] CGColor]);
    CGContextStrokeEllipseInRect(ctx, layer.bounds);
}
@end
