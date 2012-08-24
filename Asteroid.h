//
//  Asteroid.h
//  Asteroids
//
//  Created by JJ Weber on 8/23/12.
//  Copyright (c) 2012 JJ Weber. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Asteroid : NSObject
@property CALayer* layer;
@property NSArray* vector;
+ (Asteroid*) createAsteroidAtPosition: (CGPoint) position withView: (UIView*) view;
-(BOOL)isItInYou:(CGPoint)point;
-(void)moveInDirection;
@end
