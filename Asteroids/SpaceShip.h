//
//  SpaceShip.h
//  Asteroids
//
//  Created by Diana Zmuda on 8/23/12.
//  Copyright (c) 2012 JJ Weber. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SpaceShip : NSObject
@property CALayer* layer;
+ (SpaceShip*) drawSpaceShipAt:(CGPoint) center In:(UIView*) view;
@end
