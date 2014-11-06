//
//  Particle.h
//  HeatMapPath
//
//  Created by Dylan Marriott on 12/15/13.
//  Copyright (c) 2013 Dylan Marriott. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Particle : UIView

@property (nonatomic) NSMutableArray* path;
@property (nonatomic) float speed;
@property (nonatomic) BOOL animating;

@end
