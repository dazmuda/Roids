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

@end

@implementation Asteroid
@synthesize layer;
@synthesize vector;
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

-(BOOL)isItInYou:(CGPoint)point {
    CALayer *presentationLayer = [self.layer presentationLayer];
    return CGRectContainsPoint(presentationLayer.frame, point);
}

- (void) moveInDirection{
    [CATransaction begin];
    
    //create a new position to move to
    CGPoint currentPos;
    CALayer* presentationLayer = [self.layer presentationLayer];
    if (presentationLayer) {
        currentPos = presentationLayer.position;
    } else {
        currentPos = self.layer.position;
    }
    if (currentPos.x > self.layer.superlayer.bounds.size.width + 10) {
        currentPos.x = 0;
        currentPos.y = self.layer.superlayer.bounds.size.height - currentPos.y;
        [CATransaction setAnimationDuration:0];
    } else if (currentPos.y > self.layer.superlayer.bounds.size.height + 10) {
        currentPos.y = 0;
        currentPos.x = self.layer.superlayer.bounds.size.width - currentPos.x;
        [CATransaction setAnimationDuration:0];
    } else if (currentPos.x < -10) {
        currentPos.x = self.layer.superlayer.bounds.size.width;
        currentPos.y = self.layer.superlayer.bounds.size.height - currentPos.y;
        [CATransaction setAnimationDuration:0];
    } else if (currentPos.y < -10) {
        currentPos.y = self.layer.superlayer.bounds.size.height;
        currentPos.x = self.layer.superlayer.bounds.size.width - currentPos.x;
        [CATransaction setAnimationDuration:0];
    } else {
        currentPos.x = currentPos.x + [[self.vector objectAtIndex:0] floatValue];
        currentPos.y = currentPos.y + [[self.vector objectAtIndex:1] floatValue];
        //currentPos.x = currentPos.x + 1;
        //currentPos.y = currentPos.y + 1;
        NSLog(@"normal move");
        NSLog(@"%@", self);
        [CATransaction setAnimationDuration:1];
    }
    self.layer.position = currentPos;
    //completino block calls the method again
    [CATransaction setCompletionBlock:^{
        if (self.layer.superlayer) {
            [self moveInDirection];
        }
    }];
    
    [CATransaction commit];
}

@end
