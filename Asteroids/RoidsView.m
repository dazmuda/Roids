//
//  RoidsView.m
//  Asteroids
//
//  Created by JJ Weber on 8/23/12.
//  Copyright (c) 2012 JJ Weber. All rights reserved.
//

#import "RoidsView.h"
#import "Asteroid.h"

@interface RoidsView ()
@property NSMutableArray* roids;
@end

@implementation RoidsView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.roids = [NSMutableArray new];
        
        for (int i = 0; i < 10; i++) {
            double xpos = (double) arc4random()/UINT_MAX * (frame.size.width);
            double ypos = (double) arc4random()/UINT_MAX * (frame.size.height);
            if ((i % 4) == 1) {
                xpos = 0;
            } else if ((i % 4) == 2) {
                ypos = 0;
            } else if ((i % 4) == 3) {
                xpos = frame.size.width;
            } else if ((i % 4) == 0) {
                ypos = frame.size.height;
            }
            Asteroid* newRoid = [Asteroid createAsteroidAtPosition:CGPointMake(xpos, ypos) withView:self];
            [self.roids addObject:newRoid];
        }

    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
