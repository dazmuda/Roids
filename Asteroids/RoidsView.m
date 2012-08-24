//
//  RoidsView.m
//  Asteroids
//
//  Created by JJ Weber on 8/23/12.
//  Copyright (c) 2012 JJ Weber. All rights reserved.
//

#import "RoidsView.h"
#import "Asteroid.h"
#import "SpaceShip.h"
#import <QuartzCore/QuartzCore.h>

@interface RoidsView ()
@property NSMutableArray* roids;
@property NSTimer* repeatingTimer;
@property NSUInteger timerCount;
@property SpaceShip* ship;
@end

@implementation RoidsView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    self.multipleTouchEnabled = YES;
    if (self) {
        self.roids = [NSMutableArray new];
        
        //draw roids and ship
        [self createRoids:10];
        self.ship = [SpaceShip drawSpaceShipAt:self.center In:self];
        
        //make all the roids move
        for (Asteroid* roid in self.roids) {
            [roid moveInDirection];
        }
        
        //start the checkDead timer
        self.repeatingTimer = [NSTimer scheduledTimerWithTimeInterval:.5 target:self selector:@selector(checkDead) userInfo:nil repeats:YES];

    }
    return self;
}

-(void)createRoids: (int)numRoids {
    for (int i = 0; i < numRoids; i++) {
        double xpos = (double) arc4random()/UINT_MAX * (self.frame.size.width);
        double ypos = (double) arc4random()/UINT_MAX * (self.frame.size.height);
        if ((i % 4) == 1) {
            xpos = 10;
        } else if ((i % 4) == 2) {
            ypos = 10;
        } else if ((i % 4) == 3) {
            xpos = self.frame.size.width - 10;
        } else if ((i % 4) == 0) {
            ypos = self.frame.size.height - 10;
        }
        Asteroid* newRoid = [Asteroid createAsteroidAtPosition:CGPointMake(xpos, ypos) withView:self];
        NSArray* directions = @[@400,@300,@200,@100,@-100,@-200,@-300,@-400];
        int randNum1 = arc4random() % [directions count];
        int randNum2 = arc4random() % [directions count];
        NSArray* vector = @[[directions objectAtIndex:randNum1], [directions objectAtIndex: randNum2]];
        newRoid.vector = vector;
        [self.roids addObject:newRoid];
    }
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self blastRoidsFromTouches:touches];
}

- (void) blastRoidsFromTouches:(NSSet*) touches {
    //enumerate through the NSSet
    NSEnumerator *enumerator = [touches objectEnumerator];
    UITouch *touch;
    
    while ((touch = [enumerator nextObject])) {
        //for each touch, create a new CGPoint
        CGPoint touchPoint = [touch locationInView:self];
        for (int i=0; i < [self.roids count]; i++) {
            Asteroid *currentRoid = [self.roids objectAtIndex:i];
            if ([currentRoid isItInYou:touchPoint]) {
                // removes the asteroid model
                [self.roids removeObjectAtIndex:i];
                // removes the asteroid view
                [currentRoid.layer removeFromSuperlayer];
                break;
            }
        }
    }

}

-(void)checkDead {
    CALayer *shipLayer = [self.ship.layer presentationLayer];
    
    //loop through roids
    for (Asteroid *roid in self.roids) {
        //check if asteroid intersects ship frame
        CALayer *roidLayer = [roid.layer presentationLayer];
        if (CGRectIntersectsRect(shipLayer.frame, roidLayer.frame)) {
        //DELETE YO SHIP
            NSLog(@"YOU DIED SUCKA");
            [self.ship.layer removeFromSuperlayer];
        }
    }
}

@end
